local M = {}

function M.setup()
  vim.g.vimtex_view_method = "zathura"
  vim.g.vimtex_complete_enabled = false
  vim.g.vimtex_format_enabled = false
  vim.g.vimtex_include_search_enabled = false
  vim.g.vimtex_syntax_enabled = false
end

return M
