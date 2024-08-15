return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("plugins.lsp.diagnostic").setup()

    local lsp_config_augroup = vim.api.nvim_create_augroup("lsp_config_setup", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_config_augroup,
      callback = function(args)
        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = args.buf
          opts.silent = opts.silent ~= false
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map("n", "gl", vim.lsp.buf.declaration)
        map("n", "gf", vim.lsp.buf.definition)
        map("n", "K", vim.lsp.buf.hover)
        map("n", "gi", vim.lsp.buf.implementation)
        map("i", "<C-x><C-x>", vim.lsp.buf.signature_help)
        map("n", "gy", vim.lsp.buf.type_definition)
        map("n", "<leader>rn", vim.lsp.buf.rename)
        map("n", "<leader>ca", vim.lsp.buf.code_action)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "<space>a", vim.diagnostic.open_float)
        map("n", "<leader>cc", vim.lsp.codelens.run)
        map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end)
        map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end)
        map("n", "<leader>fb", function() vim.lsp.buf.format({ async = true }) end)
        map("n", "<Leader>hh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
        end)
      end,
    })

    ---Fires a function if the LSP client supports the given method.
    ---@param method string
    ---@param fn fun(bufnr: integer)
    local function on_supports_method(method, fn)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_config_augroup,
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- PERF: cache client's supported methods
          if client and client.supports_method(method) then
            fn(bufnr)
          end
        end,
      })
    end

    on_supports_method("textDocument/documentHighlight", function(bufnr)
      local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
      vim.api.nvim_clear_autocmds({
        group = highlight_augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = highlight_augroup,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = highlight_augroup,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end)

    on_supports_method("textDocument/codeLens", function(bufnr)
      local lens_augroup = vim.api.nvim_create_augroup("lsp_codelens", { clear = false })
      vim.api.nvim_clear_autocmds({
        group = lens_augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = lens_augroup,
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end)

    on_supports_method("textDocument/inlayHints", function(bufnr)
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end)

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

    if has_cmp then
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())
    end

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

        config = vim.tbl_deep_extend("force", config, capabilities)

        lspconfig.lua_ls.setup(config)
      end,
    }

    mason_lspconfig.setup_handlers(handlers)
  end,
}
