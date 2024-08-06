return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>r", "<cmd>Telescope buffers<CR>" },
      { "<leader>e", "<cmd>Telescope find_files<CR>" },
      { "<leader>rg", "<cmd>Telescope live_grep_args<CR>" },
      {
        "<leader>t",
        function()
          local in_git_repo = pcall(require("telescope.builtin").git_files)

          if not in_git_repo then
            pcall(require("telescope.builtin").find_files)
          end
        end,
      },
      {
        "<leader>s",
        function()
          local in_git_repo = pcall(function()
            require("telescope.builtin").git_status({
              git_icons = {
                added = "A",
                changed = "M",
                copied = "C",
                deleted = "D",
                renamed = "R",
                unmerged = "U",
                untracked = "?",
              },
            })
          end)

          if not in_git_repo then
            vim.print("Not a git repository")
          end
        end,
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")

      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-space>"] = action_layout.toggle_preview,
            },
          },
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = {
            horizontal = {
              preview_width = 90,
              prompt_position = "top",
            },
            vertical = {
              mirror = true,
              preview_cutoff = 30,
              prompt_position = "top",
            },
          },
          borderchars = {
            { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
            prompt = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
            results = { " ", "▕", "▁", "▏", "▏", "▕", "🭿", "🭼" },
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("live_grep_args")
    end,
  },
}
