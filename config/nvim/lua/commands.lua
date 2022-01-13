vim.api.nvim_add_user_command("PackerClean", function()
  require("plugins")
  require("packer").clean()
end, {})

vim.api.nvim_add_user_command("PackerCompile", function()
  require("plugins")
  require("packer").compile()
end, {})

vim.api.nvim_add_user_command("PackerInstall", function()
  require("plugins")
  require("packer").install()
end, {})

vim.api.nvim_add_user_command("PackerStatus", function()
  require("plugins")
  require("packer").status()
end, {})

vim.api.nvim_add_user_command("PackerSync", function()
  require("plugins")
  require("packer").sync()
end, {})

vim.api.nvim_add_user_command("PackerUpdate", function()
  require("plugins")
  require("packer").update()
end, {})
