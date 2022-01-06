local opt = vim.opt

opt.swapfile = false
opt.writebackup = false
-- opt.updatecount = 0

opt.inccommand = "split"

opt.clipboard = "unnamedplus"

opt.mouse = "a"

-- folding
opt.foldenable = false
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldtext = "getline(v:foldstart) . '⋯'"

-- searching
opt.ignorecase = true
opt.smartcase = true

-- splits
opt.splitbelow = true
opt.splitright = true
opt.diffopt:append("vertical")

-- tab control
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true

-- wrapping and indents
opt.wrap = false
opt.smartindent = true
opt.breakindent = true

-- opt.updatetime=250
vim.g.cursorhold_updatetime = 100

opt.timeoutlen = 500

opt.cursorline = true

opt.showmode = false
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.showmatch = true
opt.signcolumn = "yes"

opt.list = true
opt.listchars = {
  tab = "→ ",
  space = "·",
  eol = "¬",
  trail = "…",
  extends = "❯",
  precedes = "❮",
}
opt.fillchars = {
  vert = "▏",
  fold = " ",
  diff = "╱",
  eob = " ",
}
opt.showbreak = "↪"

opt.completeopt = { "menu", "menuone", "noinsert" }
opt.pumheight = 10

opt.termguicolors = true
