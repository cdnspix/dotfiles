vim.g.mapleader = 'ç'
vim.g.maplocalleader = 'Ç'
require 'before'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.system({ "git", "clone", "--filter=blob:none", lazyrepo, lazypath }, { text = true })
end
vim.opt.rtp:prepend(lazypath)
require 'lazy'.setup {
    defaults = { lazy = true },
    spec = { import = 'plugins' },
    profiling = { loader = true, require = true },
    readme = { skip_if_doc_exists = false },
    install = { colorscheme = { 'bluloco-light' } },
    performance = {
        rtp = {
            disabled_plugins = {
                'matchit', 'matchparen', 'tohtml', 'netrwPlugin', 'tarPlugin', 'tutor', 'zipPlugin', 'gzip'
            },
        },
    },
    checker = {
        enabled = true,
        concurrency = 1,
        notify = true,
        frequency = 60 * 60 * 2,
    },
    change_detection = { enabled = true, notify = false },
}
require 'after'
