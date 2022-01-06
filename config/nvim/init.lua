pcall(require, "impatient")

require("settings")

require("plugins")
require("keymaps")
require("autocmds")

pcall(require, "packer_compiled")

require("plugins.lsp").setup()

vim.cmd("colorscheme quantum")
