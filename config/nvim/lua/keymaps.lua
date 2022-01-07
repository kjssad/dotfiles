local map = vim.keymap.set

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

-- window navigation
map("n", "<C-h>", function()
  require("utils").move_win("h")
end)
map("n", "<C-j>", function()
  require("utils").move_win("j")
end)
map("n", "<C-k>", function()
  require("utils").move_win("k")
end)
map("n", "<C-l>", function()
  require("utils").move_win("l")
end)

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
