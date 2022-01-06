local fn = vim.fn
local packer_bootstrap

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  fn.execute("packadd packer.nvim")
end

return require("packer").startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- color code highlights
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup(nil, { css = "true" })
      end,
    })

    -- language parser
    use({
      "nvim-treesitter/nvim-treesitter-textobjects", -- syntax-aware textobjects with treesitter
      "nvim-treesitter/playground", -- query treesitter information
      {
        "nvim-treesitter/nvim-treesitter", -- treesitter configuration
        config = function()
          require("plugins.treesitter").setup()
        end,
      },
    })

    -- fuzzy finder
    use({
      {
        "nvim-telescope/telescope-fzf-native.nvim", -- telescope sorter
        run = "make",
      },
      {
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
          require("plugins.telescope").setup()
        end,
      },
    })

    -- indent guides
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("plugins.indentlines").setup()
      end,
    })

    -- file explorer
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.nvim-tree").setup()
      end,
    })

    -- comment motions
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })

    -- LSP
    use({
      "neovim/nvim-lspconfig", -- server configurations
      "williamboman/nvim-lsp-installer", -- server installer
      {
        "jose-elias-alvarez/null-ls.nvim", -- general-purpose language server
        requires = "nvim-lua/plenary.nvim",
      },
    })

    -- Git decorations
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugins.gitsigns").setup()
      end,
    })

    -- autopair plugin
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("plugins.autopairs").setup()
      end,
    })

    -- completion framework
    use({
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      {
        "hrsh7th/nvim-cmp",
        config = function()
          require("plugins.cmp").setup()
        end,
      },
    })

    -- statusline
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine").setup()
      end,
    })

    -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    use({ "AndrewRadev/splitjoin.vim", branch = "main" })

    use("tpope/vim-fugitive") -- git wrapper
    use("tpope/vim-repeat") -- enables repeating other supported plugins with the . command
    use("tpope/vim-surround") -- mappings to easily delete, change and add such surroundings in pairs
    use("tpope/vim-unimpaired") -- mappings which are simply short normal mode aliases for commonly used ex commands
    use("tpope/vim-sleuth") -- detect indent style (tabs vs. spaces)

    use("~/Development/codes/repos/quantum.vim")

    use("antoinemadec/FixCursorHold.nvim") -- Needed while issue https://github.com/neovim/neovim/issues/12587 is open
    use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
