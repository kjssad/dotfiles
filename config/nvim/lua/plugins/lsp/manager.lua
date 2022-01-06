local M = {}

function M.setup(server_name)
  local servers = require("nvim-lsp-installer.servers")
  local server_available, requested_server = servers.get_server(server_name)

  if not server_available then
    return
  end

  local config = require("plugins.lsp").common_options()
  local server_config = require("plugins.lsp.servers")

  if server_config[server_name] then
    server_config = server_config[server_name]

    if server_config.options then
      config = vim.tbl_deep_extend("force", config, server_config.options)
    end

    -- if server_config.formatters then
    --   require("null-ls").register()
    -- end
  end

  if not requested_server:is_installed() then
    requested_server:install()
  end

  requested_server:on_ready(function()
    requested_server:setup(config)
  end)
end

return M
