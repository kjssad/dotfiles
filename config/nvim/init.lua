pcall(require, "impatient")

require("settings")
require("commands")
require("keymaps").defaults()
require("autocmds").defaults()

pcall(require, "packer_compiled")

vim.cmd("colorscheme quantum")
