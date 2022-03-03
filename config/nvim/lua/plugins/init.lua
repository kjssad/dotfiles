local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
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
    use({ "wbthomason/packer.nvim", opt = true })

    -- color code highlights
    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        local loaded, colorizer = pcall(require, "colorizer")

        if loaded then
          colorizer.setup(nil, { css = "true" })
        end
      end,
      event = "BufRead",
    })

    -- language parser
    use({
      {
        "nvim-treesitter/nvim-treesitter", -- treesitter configuration
        config = function()
          require("plugins.treesitter").setup()
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects", -- syntax-aware textobjects with treesitter
        after = "nvim-treesitter",
      },
      {
        "nvim-treesitter/playground", -- query treesitter information
        after = "nvim-treesitter",
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
        after = "telescope-fzf-native.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
          require("plugins.telescope").setup()
        end,
        setup = function()
          require("keymaps").telescope()
        end,
      },
    })

    -- indent guides
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("plugins.indentlines").setup()
      end,
      event = "BufRead",
    })

    -- file explorer
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.nvim-tree").setup()
      end,
      setup = function()
        require("keymaps").nvim_tree()
      end,
      cmd = { "NvimTreeFindFileToggle", "NvimTreeFindFile" },
    })

    -- comment motions
    use({
      "numToStr/Comment.nvim",
      config = function()
        local loaded, comment = pcall(require, "Comment")

        if loaded then
          comment.setup()
        end
      end,
      event = "BufRead",
    })

    -- LSP
    use({
      {
        "neovim/nvim-lspconfig", -- server configurations
        config = function()
          require("plugins.lsp").setup()
        end,
      },
      {
        "jose-elias-alvarez/null-ls.nvim", -- general-purpose language server
        requires = "nvim-lua/plenary.nvim",
        config = function()
          require("plugins.null-ls").setup()
        end,
      },
      { "williamboman/nvim-lsp-installer", after = "nvim-lspconfig" }, -- server installer
    })

    -- Git decorations
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugins.gitsigns").setup()
      end,
      event = "BufRead",
    })

    -- snippets
    use({
      { "rafamadriz/friendly-snippets", event = "InsertEnter" },
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip").config.setup({
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave",
          })
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
        after = "friendly-snippets",
      },
    })

    -- completion framework
    use({
      {
        "hrsh7th/nvim-cmp",
        config = function()
          require("plugins.cmp").setup()
        end,
        after = "LuaSnip",
      },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
    })

    -- autopair plugin
    use({
      "windwp/nvim-autopairs",
      after = { "nvim-treesitter", "nvim-cmp" },
      config = function()
        require("plugins.autopairs").setup()
      end,
    })

    -- statusline
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine").setup()
      end,
    })

    use({
      "lervag/vimtex",
      config = function()
        require("plugins.vimtex").setup()
      end,
    })

    -- single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
    use({ "AndrewRadev/splitjoin.vim", branch = "main", event = "BufRead" })

    -- git wrapper
    use({ "tpope/vim-fugitive", cmd = { "Git", "Gclog" } })

    -- enables repeating other supported plugins with the . command
    use({ "tpope/vim-repeat", event = "BufRead" })

    -- mappings to easily delete, change and add such surroundings in pairs
    use({ "tpope/vim-surround", event = "BufRead" })

    -- mappings which are simply short normal mode aliases for commonly used ex commands
    use({ "tpope/vim-unimpaired", event = "BufRead" })

    -- detect indent style (tabs vs. spaces)
    use({ "tpope/vim-sleuth", event = "BufRead" })

    use("~/Development/codes/repos/quantum.vim")

    use("antoinemadec/FixCursorHold.nvim") -- Needed while issue https://github.com/neovim/neovim/issues/12587 is open
    use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
