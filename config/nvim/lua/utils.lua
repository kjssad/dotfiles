local utils = {}

function utils.map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent

  if type(modes) == "string" then
    modes = { modes }
  end

  for _, mode in ipairs(modes) do
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

function utils.augroup(group, cmds)
  vim.cmd("augroup " .. group)
  vim.cmd("autocmd!")
  for _, cmd in ipairs(cmds) do
    vim.cmd("autocmd " .. cmd)
  end
  vim.cmd("augroup END")
end

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
