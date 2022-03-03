local M = {}

local function document_highlight(client)
  if client.resolved_capabilities.document_highlight then
    require("autocmds").lsp_document_highlight()
  end
end

local function codelens(client)
  if client.resolved_capabilities.code_lens then
    require("autocmds").lsp_codelens()
  end
end

local function keymappings()
  require("keymaps").lsp()
end

local function install_servers(installer, servers)
  for name, _ in pairs(servers) do
    local ok, server = installer.get_server(name)

    if ok then
      if not server:is_installed() then
        print("Installing " .. name)
        server:install()
      end
    end
  end
end

function M.common_on_attach(client, _)
  document_highlight(client)
  codelens(client)
  keymappings()
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local cmp_lsp_loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

  if cmp_lsp_loaded then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  return capabilities
end

function M.common_options()
  return {
    on_attach = M.common_on_attach,
    capabilities = M.common_capabilities(),
  }
end

function M.setup()
  require("plugins.lsp.diagnostic").setup()

  local loaded, installer = pcall(require, "nvim-lsp-installer")

  if loaded then
    local servers = require("plugins.lsp.servers")

    install_servers(installer, servers)

    local config = M.common_options()

    installer.on_server_ready(function(server)
      if servers[server.name] then
        config = vim.tbl_deep_extend("force", config, servers[server.name].config)
      end

      server:setup(config)
      vim.cmd([[ do User LspAttachBuffers ]])
    end)
  end
end

return M
