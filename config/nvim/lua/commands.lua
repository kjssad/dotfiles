local command = vim.api.nvim_create_user_command

command("PackerClean", function()
  require("plugins")
  require("packer").clean()
end, {})

command("PackerCompile", function()
  require("plugins")
  require("packer").compile()
end, {})

command("PackerInstall", function()
  require("plugins")
  require("packer").install()
end, {})

command("PackerStatus", function()
  require("plugins")
  require("packer").status()
end, {})

command("PackerSync", function()
  require("plugins")
  require("packer").sync()
end, {})

command("PackerUpdate", function()
  require("plugins")
  require("packer").update()
end, {})
