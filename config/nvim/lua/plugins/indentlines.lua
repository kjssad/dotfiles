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
  context_char = "▏",
}

function M.setup()
  local loaded, indentlines = pcall(require, "indent_blankline")

  if loaded then
    indentlines.setup(config)
  end
end

return M
