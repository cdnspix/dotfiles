#include <linux/input-event-codes.h>
#include <linux/uinput.h>
#include <linux/input.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#ifdef STANDALONE
#include <stdio.h>
#endif

static int initted = 0;
static int inittedu = 0;
static int rfd = 0;
static int wfd = 0;
static unsigned short leds;
void init_the_library() {
    rfd = open("/dev/input/event5", O_RDONLY);
}
int get_caps_state() {
    if (!initted) {
        initted = 1;
        init_the_library();
    }
    ioctl(rfd, EVIOCGLED(2), &leds);
    return leds & 2;
}

void emit(int fd, int type, int code, int val) {
    struct input_event ie = {
        .type = type,
        .code = code,
        .value = val,
        .time =
            {
                .tv_sec = 0,
                .tv_usec = 0,
            },
    };
    write(fd, &ie, sizeof(ie));
}

void report(int fd) {
    emit(fd, EV_SYN, SYN_REPORT, 0);
}

int kinit() {
    wfd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
    ioctl(wfd, UI_SET_EVBIT, EV_KEY);
    ioctl(wfd, UI_SET_KEYBIT, KEY_CAPSLOCK);
    struct uinput_setup usetup = {
        .id =
            {
                .bustype = BUS_USB,
                .vendor = 0x1234,
                .product = 0x5678,
            },
        .ff_effects_max = 0,
        .name = "Example device",
    };
    ioctl(wfd, UI_DEV_SETUP, &usetup);
    ioctl(wfd, UI_DEV_CREATE);
    sleep(1);
    return wfd;
}

void to_capes() {
    if (!inittedu) {
        inittedu = 1;
        kinit();
    }
    emit(wfd, EV_KEY, KEY_CAPSLOCK, 1);
    emit(wfd, EV_SYN, SYN_REPORT, 0);
    emit(wfd, EV_KEY, KEY_CAPSLOCK, 0);
    emit(wfd, EV_SYN, SYN_REPORT, 0);
}

#ifdef STANDALONE
int main() {
    while (getchar() != 'c') {
        fprintf(stderr, "simbora\n");
        fprintf(stderr, "%d\n", wfd);
        to_capes();
    }
}
#endif
