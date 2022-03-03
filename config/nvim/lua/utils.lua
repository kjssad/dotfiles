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

return utils
