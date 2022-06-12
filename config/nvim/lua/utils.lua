local utils = {}

function utils.move_win(key)
  local old_win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. key)
  if old_win == vim.api.nvim_get_current_win() then
    if key:match("[jk]") then
      vim.cmd("wincmd s")
    else
      vim.cmd("wincmd v")
    end
    vim.cmd("wincmd " .. key)
  end
end

function utils.last_cursor()
  local filetype = vim.bo.filetype
  local buftype = vim.bo.buftype

  if buftype == "help" or buftype == "nofile" or filetype == "gitcommit" then
    return
  end

  local line = vim.fn.line
  if line("'\"") > 0 and line("'\"") <= line("$") then
    vim.cmd('normal! g`"zz')
  end
end

function utils.set_relative_number(ok)
  if not ok and vim.wo.number then
    vim.cmd("set norelativenumber")
    return
  end

  local filetype = vim.bo.filetype
  local buftype = vim.bo.buftype

  if buftype == "help" or buftype == "nofile" or filetype == "NvimTree" then
    return
  end

  if vim.wo.number and vim.api.nvim_get_mode().mode ~= "i" then
    vim.cmd("set relativenumber")
  end
end

function utils.get_mode()
  local mode_map = {
    ["n"] = "N",
    ["i"] = "I",
    ["R"] = "R",
    ["v"] = "V",
    ["V"] = "VL",
    [""] = "VB",
    ["c"] = "C",
    ["s"] = "S",
    ["S"] = "SL",
    [""] = "SB",
    ["t"] = "T",
  }

  local mode_code = vim.api.nvim_get_mode().mode

  if mode_map[mode_code] then
    return mode_map[mode_code]
  end

  return mode_code
end

function utils.in_table(table, val)
  for _, value in ipairs(table) do
    if value == val then
      return true
    end
  end

  return false
end

function utils.set_winbar()
  local filename = vim.api.nvim_buf_get_name(0)

  if filename == "" then
    return ""
  end

  local head = vim.fn.fnamemodify(filename, ":.:h")

  if head == "." or (vim.fn.winwidth(0) <= 97 and string.len(filename) > 90) then
    head = " "
  else
    head = " " .. head .. "/ "
  end

  local devicons_loaded, devicons = pcall(require, "nvim-web-devicons")
  local icon, color_code

  local extension = vim.fn.fnamemodify(filename, ":.:e")

  if devicons_loaded then
    icon, color_code = devicons.get_icon_color(filename, extension, { default = true })
  end

  if icon then
    icon = "%#WinBarFileTypeIcon#" .. icon .. "%* "
    vim.api.nvim_set_hl(0, "WinBarFileTypeIcon", { fg = color_code })
  else
    icon = ""
  end

  local winbar = head .. icon .. vim.fn.fnamemodify(filename, ":t")

  if vim.bo.modified then
    winbar = winbar .. "[+]"
  end

  if vim.bo.modifiable == false or vim.bo.readonly == true then
    winbar = winbar .. "[-]"
  end

  local navic_loaded, navic = pcall(require, "nvim-navic")

  if navic_loaded and navic.is_available() then
    local context = navic.get_location()

    if context ~= "" then
      return winbar .. " ❯ " .. context
    end
  end

  return winbar
end

return utils
