local loaded, lualine = pcall(require, "lualine")

if not loaded then
  return
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.o.columns > 97
  end,
}

local mode = {
  function()
    return require("utils").get_mode()
  end,
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
  padding = { left = 0, right = 1 },
}

local filename = {
  "filename",
  path = 1,
  cond = conditions.buffer_not_empty,
}

local diagnostics = {
  "diagnostics",
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = false,
}

local indentation = {
  function()
    if vim.bo.expandtab then
      return "Spaces: " .. vim.bo.shiftwidth
    else
      return "Tabs: " .. vim.bo.shiftwidth
    end
  end,
  cond = conditions.hide_in_width,
}

local location = {
  "%l, Col %v",
  fmt = function(str)
    return "Ln " .. str
  end,
}

local encoding = {
  "encoding",
  cond = conditions.hide_in_width,
  fmt = string.upper,
}

local filetype = {
  "vim.bo.filetype",
  cond = conditions.buffer_not_empty and conditions.hide_in_width,
  fmt = function(str)
    return str:gsub("^%l", string.upper)
  end,
  colored = false,
}

local fileformat = {
  function()
    local fileformat = vim.bo.fileformat
    if fileformat == "unix" then
      return ""
    end

    local symbols = {
      dos = "",
      mac = "",
    }

    return symbols[fileformat] or fileformat
  end,
  cond = conditions.hide_in_width,
}

local config = {
  options = {
    theme = "quantum",
    component_separators = "",
    section_separators = "",
    globalstatus = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = {},
    lualine_c = { branch, status, filename, diagnostics },
    lualine_x = { location, indentation, encoding, filetype, fileformat },
    lualine_y = {},
    lualine_z = {},
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

local M = {}

function M.setup()
  if loaded then
    lualine.setup(config)
  end
end

return M
