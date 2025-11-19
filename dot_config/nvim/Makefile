all:
	gcc -o kagain.so kagain.c -shared -fPIC -Wl,-undefined -Wl,dynamic_lookup
	gcc -DSTANDALONE -o kagain kagain.c
