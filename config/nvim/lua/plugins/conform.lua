return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>fb",
      function()
        require("conform").format()
      end,
    },
  },
  opts = {
    formatters_by_ft = {
      sh = { "shellcheck", "shfmt" },
      lua = { "stylua" },
    },
    format_on_save = true,
    default_format_opts = {
      timeout_ms = 2000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },
  },
}
