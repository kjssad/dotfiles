return {
  ["sumneko_lua"] = {
    config = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Both",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
            maxPreload = 10000,
          },
        },
      },
    },
    formatters = {},
    linters = {},
  },
  ["texlab"] = {
    config = {
      settings = {
        texlab = {
          chktex = {
            onOpenAndSave = true,
            onEdit = true,
          },
        },
      },
    },
  },
}
