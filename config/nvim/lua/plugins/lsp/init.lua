local M = {}

local function document_highlight(client)
  if client.resolved_capabilities.document_highlight then
    vim.cmd(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local function codelens_refresh(client)
  if client.resolved_capabilities.code_lens then
    vim.cmd(
      [[
        augroup lsp_code_lens_refresh
          autocmd! * <buffer>
          autocmd InsertLeave <buffer> lua vim.lsp.codelens.refresh()
          autocmd InsertLeave <buffer> lua vim.lsp.codelens.display()
        augroup END
      ]],
      false
    )
  end
end

local function keymappings()
  local map = vim.keymap.set
  local options = { buffer = true }

  map("n", "gl", vim.lsp.buf.declaration, options)
  map("n", "gf", vim.lsp.buf.definition, options)
  map("n", "K", vim.lsp.buf.hover, options)
  map("n", "gi", vim.lsp.buf.implementation, options)
  map("i", "<C-x><C-x>", vim.lsp.buf.signature_help, options)
  map("n", "gy", vim.lsp.buf.type_definition, options)
  map("n", "<leader>rn", vim.lsp.buf.rename, options)
  map("n", "<leader>ca", vim.lsp.buf.code_action, options)
  map("n", "gr", vim.lsp.buf.references, options)
  map("n", "<space>a", vim.diagnostic.open_float, options)
  map("n", "[d", vim.diagnostic.goto_prev, options)
  map("n", "]d", vim.diagnostic.goto_next, options)
  map("n", "<leader>fb", vim.lsp.buf.formatting, options)
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
  codelens_refresh(client)
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
