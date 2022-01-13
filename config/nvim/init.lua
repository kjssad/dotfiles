pcall(require, "impatient")

require("settings")
require("keymaps")
require("autocmds")
require("commands")

pcall(require, "packer_compiled")

vim.cmd("colorscheme quantum")
