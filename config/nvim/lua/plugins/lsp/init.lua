local M = {}

local function document_highlight(client, bufnr)
  if client.supports_method("textDocument/documentHighlight") then
    require("autocmds").lsp_document_highlight(bufnr)
  end
end

local function codelens(client, bufnr)
  if client.supports_method("textDocument/codeLens") then
    require("autocmds").lsp_codelens(bufnr)
  end
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

function M.common_on_attach(client, bufnr)
  document_highlight(client, bufnr)
  codelens(client, bufnr)
  require("keymaps").lsp(bufnr)

  if client.supports_method("textDocument/documentSymbol") then
    local loaded, navic = pcall(require, "nvim-navic")

    if loaded then
      navic.attach(client, bufnr)
    end
  end
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

  local loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

  if loaded then
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

  if not loaded then
    return
  end

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

return M
