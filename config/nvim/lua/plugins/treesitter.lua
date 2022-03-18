local loaded, ts_config = pcall(require, "nvim-treesitter.configs")

if not loaded then
  return
end

local config = {
  ensure_installed = {
    "bash",
    "lua",
    "latex"
  },
  highlight = {
    enable = true,
    -- terrilble elixir performance
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1957
    disable = { "elixir" },
  },
  indent = {
    enable = true,
    -- disable = {'dart', 'latex'}
  },
  incremental_selection = {
    enable = true,
    -- disable = {'latex'},
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ak"] = "@block.outer",
        ["ik"] = "@block.inner",
        ["ir"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]k"] = "@block.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]K"] = "@block.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[k"] = "@block.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[K"] = "@block.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
}

local M = {}

function M.setup()
  ts_config.setup(config)
end

return M
