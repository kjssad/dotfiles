return {
  "lewis6991/gitsigns.nvim",
  event = "BufRead",
  opts = {
    signs = {
      add = { text = "▌" },
      change = { text = "▌" },
      delete = { text = "▶" },
      topdelete = { text = "▶" },
      changedelete = { text = "▌" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end)

      -- Actions
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
      map("n", "<leader>hS", gitsigns.stage_buffer)
      map("n", "<leader>hu", gitsigns.undo_stage_hunk)
      map("n", "<leader>hR", gitsigns.reset_buffer)
      map("n", "<leader>hp", gitsigns.preview_hunk)
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end)
      map("n", "<leader>htb", gitsigns.toggle_current_line_blame)
      map("n", "<leader>hd", gitsigns.diffthis)
      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end)
      map("n", "<leader>htd", gitsigns.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
    status_formatter = function(status)
      local added, changed, removed = status.added, status.changed, status.removed

      if (added and added > 0) or (removed and removed > 0) or (changed and changed > 0) then
        return "*"
      end

      return ""
    end,
    preview_config = {
      border = require("plugins.lsp.diagnostic").border,
      row = 1,
    },
  },
}
