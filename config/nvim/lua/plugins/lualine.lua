local M = {}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 70
  end,
}

local mode = {
  function()
    return require("utils").get_mode()
  end,
  padding = 1,
}

local branch = {
  "branch",
  icon = "",
  padding = { left = 1, right = 0 },
}

local status = {
  function()
    return vim.b.gitsigns_status or ""
  end,
  padding = 0,
}

local filetype_icon = {
  "filetype",
  colored = false,
  icon_only = true,
  padding = { left = 2, right = 0 },
}

local filename = {
  "filename",
  cond = conditions.buffer_not_empty,
}

local diagnostics = {
  "diagnostics",
  cond = conditions.hide_in_width,
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = false,
}

local indentation = {
  function()
    if vim.bo.expandtab == 1 then
      return "Spaces: " .. vim.bo.shiftwidth
    else
      return "Tabs: " .. vim.bo.shiftwidth
    end
  end,
  cond = conditions.hide_in_width,
}

local encoding = {
  "encoding",
  cond = conditions.hide_in_width,
  fmt = string.upper,
}

local filetype = {
  "filetype",
  cond = conditions.buffer_not_empty and conditions.hide_in_width,
  colored = false,
}

local fileformat = {
  "fileformat",
  cond = conditions.hide_in_width,
}

local config = {
  options = {
    theme = "quantum",
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { "NvimTree" },
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, status },
    lualine_c = { filetype_icon, filename, diagnostics },
    lualine_x = {},
    lualine_y = { "location", indentation, encoding, filetype },
    lualine_z = { fileformat },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_v = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

function M.setup()
  require("lualine").setup(config)
end

return M
