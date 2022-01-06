local M = {}

local config = {
  char = "▏",
  space_char_blankline = " ",
  use_treesitter = true,
  show_trailing_blankline_indent = false,
  show_end_of_line = true,
  filetype_exclude = { "NvimTree", "help" },
  buftype_exclude = { "terminal" },
  show_current_context = true,
  show_current_context_start = true,
}

function M.setup()
  require("indent_blankline").setup(config)
end

return M
