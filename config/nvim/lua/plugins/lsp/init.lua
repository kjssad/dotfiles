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

local function common_on_attach(client, bufnr)
  document_highlight(client, bufnr)
  -- codelens(client, bufnr)
  require("keymaps").lsp(bufnr)

  if client.supports_method("textDocument/documentSymbol") then
    local loaded, navic = pcall(require, "nvim-navic")

    if loaded then
      navic.attach(client, bufnr)
    end
  end
end

local function common_capabilities()
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
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  return capabilities
end

local function common_options()
  return {
    on_attach = common_on_attach,
    capabilities = common_capabilities(),
  }
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("plugins.lsp.diagnostic").setup()

    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
      },
    })

    local handlers = {
      function(server_name)
        lspconfig[server_name].setup(capabilities)
      end,
      ["lua_ls"] = function()
        local config = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Both",
              },
              telemetry = { enable = false },
              hint = { enable = true },
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        }

        config = vim.tbl_deep_extend("force", config, common_options())

        lspconfig.lua_ls.setup(config)
      end,
    }

    mason_lspconfig.setup_handlers(handlers)
  end,
}
