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
  local autopairs_loaded, autopairs = pcall(require, "nvim-autopairs")

  if not autopairs_loaded then
    return
  end

  local Rule = require("nvim-autopairs.rule")

  autopairs.setup(config)

  local cmp_loaded, cmp = pcall(require, "cmp")

  if cmp_loaded then
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
  end

  local ts_loaded, ts_config = pcall(require, "nvim-treesitter.configs")

  if ts_loaded then
    ts_config.setup({ autopairs = { enable = true } })

    local ts_conds = require("nvim-autopairs.ts-conds")

    -- press % => %% is only inside comment or string
    autopairs.add_rules({
      Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
      Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
    })
  end
end

return M
