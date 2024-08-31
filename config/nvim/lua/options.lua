local opt = vim.opt

-- Apeparance
opt.cmdheight = 0 -- hide command bar when not in use
opt.cursorline = true -- highlight current line
opt.fillchars = { -- characters to use as window separators, ...
  horiz = "▁",
  horizup = "🭼",
  horizdown = "▁",
  vert = "▏",
  vertleft = "▏",
  vertright = "🭼",
  verthoriz = "🭼",
  fold = " ",
  diff = "╱",
  eob = " ",
}
opt.laststatus = 3 -- show global statusline
opt.list = true -- show invisible characters
opt.listchars = {
  eol = "¬",
  extends = "❯",
  precedes = "❮",
  tab = "→ ",
  trail = "•",
}
opt.number = true -- show line numbers in gutter
opt.pumheight = 10 -- number of popup menu items
opt.relativenumber = true -- use relative line numbers
opt.showbreak = "↪" -- wrapped line indicator
opt.showmatch = true -- show matching brackets
opt.showmode = false -- don't show mode since its shown in the statusline
opt.signcolumn = "yes" -- show sign column
opt.termguicolors = true -- true color support

-- Backups
opt.swapfile = false -- disable swap file
opt.writebackup = false -- don't write backups

-- Diff
opt.diffopt:append("algorithm:patience") -- diff algorithm
opt.diffopt:append("linematch:60") -- align diff lines
opt.diffopt:append("vertical") -- use vertical splits

-- Folding
opt.foldenable = false -- don't fold by default
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter to detect folds
opt.foldlevelstart = 99 -- no folds closed
opt.foldmethod = "expr"
opt.foldtext = "" -- use current buffer text as fold text

-- Indents
opt.shiftround = true -- round indent to multiple of `shiftwidth`
opt.shiftwidth = 2 -- size of indents
opt.smartindent = true -- autoindent

-- Motions
opt.scrolloff = 5 -- number of lines to keep above/below of the cursor when moving vertically
opt.sidescrolloff = 10 -- number of columns to keep left/right of the cursor when moving horizontally

-- Searching
opt.ignorecase = true -- case-insensitive search
opt.smartcase = true -- case-sensitive search if pattern contains an upper case char

-- Splits
opt.splitbelow = true -- open new window below the current one
opt.splitright = true -- open new window right of the current one

-- Tab control
opt.expandtab = true -- use spaces instead of tabs
opt.tabstop = 2 -- number of spaces of tabs

-- Wraps
opt.breakindent = true -- indent wrapped lines
opt.wrap = false -- disable line wraps

opt.completeopt = { "menu", "menuone", "noinsert" } -- completion menu behavior

opt.confirm = true -- ask to save changes before exiting a modified buffer

opt.inccommand = "split" -- substitute command preview

opt.mouse = "a" -- enable mouse support for all modes

opt.timeoutlen = 500 -- time in ms to wait for a mapped key sequence

opt.updatetime = 200 -- swap file save and CursorHold event trigger time in ms

-- don't set the clipboard when in SSH (OSC 52 integration)
if not vim.env.SSH_TTY then
  opt.clipboard = "unnamedplus"
end
