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
  local map = require("utils").map

  map("n", "gl", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map("n", "gf", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("i", "<C-x><C-x>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  map("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  map("n", "<space>a", "<cmd>lua vim.diagnostic.open_float()<CR>")
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  map("n", "<leader>fb", "<cmd>lua vim.lsp.buf.formatting()<CR>")
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

  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

  if status_ok then
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
  local config = M.common_options()
  require("plugins.null-ls").setup(config)
  require("plugins.lsp.diagnostic").setup()

  local installer = require("nvim-lsp-installer")
  local servers = require("plugins.lsp.servers")

  install_servers(installer, servers)

  installer.on_server_ready(function(server)
    if servers[server.name] then
      config = vim.tbl_deep_extend("force", config, servers[server.name].config)
    end

    server:setup(config)
    vim.cmd([[ do User LspAttachBuffers ]])
  end)
end

return M
