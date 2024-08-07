return {
  {
    "kjssad/quantum.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme quantum")
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gclog" },
    keys = {
      { "<leader>gs", "<cmd>Git<CR>" },
      { "<leader>gl", "<cmd>Gclog<CR>" },
    },
  },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-surround" },
}
