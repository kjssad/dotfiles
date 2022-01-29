local loaded, indentlines = pcall(require, "indent_blankline")

if not loaded then
  return
end

local config = {
  char = "▏",
  space_char_blankline = " ",
  use_treesitter = true,
  show_trailing_blankline_indent = false,
  show_end_of_line = true,
  filetype_exclude = { "NvimTree", "help" },
  buftype_exclude = { "terminal" },
  show_current_context = true,
  context_char = "▏",
}

local M = {}

function M.setup()
  indentlines.setup(config)
end

return M
