local loaded, gitsigns = pcall(require, "gitsigns")

if not loaded then
  return
end

local config = {
  signs = {
    add = { text = "▌" },
    change = { text = "▌" },
    delete = { text = "▶" },
    topdelete = { text = "▶" },
    changedelete = { text = "▌" },
  },
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>hs", gitsigns.stage_hunk)
    map({ "n", "v" }, "<leader>hr", gitsigns.reset_hunk)
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
    local status_txt = (status.changed or status.removed) and "*" or ""
    status_txt = status.added and status_txt .. "+" or status_txt

    return status_txt
  end,
  preview_config = {
    border = require("plugins.lsp.diagnostic").border,
    row = 1,
  },
}

local M = {}

function M.setup()
  gitsigns.setup(config)
end

return M
