local themes = {}

function themes.flex(opts)
  opts = opts or {}

  local theme_opts = {
    theme = "flex",

    sorting_strategy = "ascending",
    layout_strategy = "center",
    results_title = false,
    preview_title = false,
    preview = true,
    preview_cutoff = 1,
    width = 0.7,
    results_height = 15,
    borderchars = {
      { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
  }

  return vim.tbl_deep_extend("force", theme_opts, opts)
end

return themes
