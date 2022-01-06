local M = {}

local config = {
  fast_wrap = {},
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "vim" },
}

function M.setup()
  local autopairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")

  autopairs.setup(config)

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

  require("nvim-treesitter.configs").setup({ autopairs = { enable = true } })

  local ts_conds = require("nvim-autopairs.ts-conds")

  -- press % => %% is only inside comment or string
  autopairs.add_rules({
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
  })
end

return M
