require("settings")
require("commands")
require("keymaps").defaults()
require("autocmds").defaults()

local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(install_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    install_path,
  })
end

vim.opt.rtp:prepend(install_path)

require("lazy").setup(
  {
    { import = "plugins" },
  },
  {
    change_detection = {
      enabled = false,
      notify = false,
    },
  }
)
