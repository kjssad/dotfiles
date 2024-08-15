local map = require("utils").map

local M = {}

function M.defaults()
  -- leader key
  map("n", ",", "<NOP>")
  vim.g.mapleader = ","

  -- remap esc
  map("i", "jk", "<ESC>")

  -- save shortcut
  map("n", "<leader>,", ":w<CR>")

  -- quit shortcut
  map("n", "<leader>`", ":q<CR>")

  -- disable highlighting of current search until next search
  map("n", "<space>", ":nohlsearch<CR>")

  -- activate spell-checking alternatives
  map("n", ";s", ":set invspell spelllang=en<CR>")

  -- remove extra whitespace
  map("n", "<leader><space>", [[:%s/\s\+$<CR>]])
  map("n", "<leader><space><space>", [[:%s/\n\{2,}/\r\r/g<CR>]])

  -- switch between current and last buffer
  map("n", "<leader>.", "<C-^>")

  -- enable . command in visual mode
  map("v", ".", ":normal .<CR>")

  -- -- window navigation
  -- map("n", "<C-h>", function()
  --   require("utils").move_win("h")
  -- end)
  -- map("n", "<C-j>", function()
  --   require("utils").move_win("j")
  -- end)
  -- map("n", "<C-k>", function()
  --   require("utils").move_win("k")
  -- end)
  -- map("n", "<C-l>", function()
  --   require("utils").move_win("l")
  -- end)

  -- scroll the viewport faster
  map("n", "<C-e>", "3<C-e>")
  map("n", "<C-y>", "3<C-y>")

  -- move cursor by display line
  map("n", "j", "gj")
  map("n", "k", "gk")
  map("n", "^", "g^")
  map("n", "$", "g$")

  -- don't exit visual mode after pressing > and <
  map("v", ">", ">gv")
  map("v", "<", "<gv")

  -- helpers for dealing with other people's code
  map("n", "\\t", ":set ts=4 sts=4 sw=4 noet<CR>")
  map("n", "\\s", ":set ts=4 sts=4 sw=4 et<CR>")
  map("n", "\\2t", ":set ts=2 sts=2 sw=2 noet<CR>")
  map("n", "\\2s", ":set ts=2 sts=2 sw=2 et<CR>")

  map("n", "<F2>", ":TSHighlightCapturesUnderCursor<CR>")
end

function M.gitsigns(bufnr)
  local options = { buffer = bufnr }
  local expr = { buffer = bufnr, expr = true }
  local gitsigns = require("gitsigns")

  -- Navigation
  map("n", "]c", "&diff ? ']c' : ':Gitsigns next_hunk<CR>'", expr)
  map("n", "[c", "&diff ? '[c' : ':Gitsigns prev_hunk<CR>'", expr)

  -- Actions
  map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", options)
  map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", options)
  map("n", "<leader>hS", gitsigns.stage_buffer, options)
  map("n", "<leader>hu", gitsigns.undo_stage_hunk, options)
  map("n", "<leader>hR", gitsigns.reset_buffer, options)
  map("n", "<leader>hp", gitsigns.preview_hunk, options)
  map("n", "<leader>hb", function()
    gitsigns.blame_line({ full = true })
  end, options)
  map("n", "<leader>htb", gitsigns.toggle_current_line_blame, options)
  map("n", "<leader>hd", gitsigns.diffthis, options)
  map("n", "<leader>hD", function()
    gitsigns.diffthis("~")
  end, options)
  map("n", "<leader>htd", gitsigns.toggle_deleted, options)

  -- Text object
  map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", options)
end

return M
