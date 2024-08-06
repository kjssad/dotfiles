return {
  "windwp/nvim-autopairs",
  opts = {
    fast_wrap = {},
    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "vim" },
  },
  config = function(_, opts) 
    local autopairs = require("nvim-autopairs")
    autopairs.setup(opts)

    local cmp = require("cmp")

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

    local ts_config = require("nvim-treesitter.configs")

    ts_config.setup({ autopairs = { enable = true } })

    local ts_conds = require("nvim-autopairs.ts-conds")

    local Rule = require("nvim-autopairs.rule")

    -- press % => %% is only inside comment or string
    autopairs.add_rules({
      Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
      Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
    })
  end,
}
