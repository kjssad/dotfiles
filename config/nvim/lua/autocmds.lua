local augroup = require("utils").augroup

augroup("configgroup", {
  "FocusLost * silent! wa",
  -- make help and quickfix windows take all the lower section of the screen
  -- when there are multiple windows open
  "FileType help,qf wincmd J",
  "FileType help,qf nmap <buffer> q :q<CR>",
  "TermOpen * setlocal nonumber norelativenumber signcolumn=no",
  "BufReadPost * lua require('utils').last_cursor()",
  "TextYankPost * silent! lua vim.highlight.on_yank({ timeout=250 })",
})

augroup("linenumbers", {
  "BufEnter,FocusGained,InsertLeave,WinEnter * lua require('utils').set_relative_number(true)",
  "BufLeave,FocusLost,InsertEnter,WinLeave * lua require('utils').set_relative_number(false)",
})

augroup("packer_reload", {
  "BufWritePost */lua/plugins/init.lua source <afile> | PackerCompile",
})
