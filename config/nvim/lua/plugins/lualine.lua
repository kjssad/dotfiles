return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "auto",
      component_separators = "",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "branch",
          icon = "",
          padding = { left = 1, right = 0 },
        },
        {
          "vim.b.gitsigns_status",
          padding = { left = 0, right = 1 },
        },
        {
          "filename",
          path = 1,
          symbols = {
            unnamed = "",
          },
        },
        {
          "navic",
          color_correction = "dynamic",
          fmt = function(str)
            if str == "" then
              return ""
            end

            return "❯ " .. str
          end,
          padding = { left = 0, right = 1 },
        },
      },
      lualine_x = {
        "%S", -- partially entered commands
        {
          function()
            if vim.v.hlsearch == 0 then
              return ""
            end

            local ok, result = pcall(vim.fn.searchcount)

            if not ok then
              return ""
            end

            if result.incomplete == 1 then
              return "[?/??]"
            elseif result.incomplete == 2 then
              if result.total > result.maxcount and result.current > result.maxcount then
                return string.format(">%d of >%d", result.current, result.total)
              elseif result.total > result.maxcount then
                return string.format("%d of >%d", result.current, result.total)
              end
            end

            return string.format("%d of %d", result.current, result.total)
          end,
        },
        {
          -- recording status
          function()
            local register = vim.fn.reg_recording()

            if register == "" then
              return ""
            end

            return "Recording @" .. register
          end,
        },
        {
          -- cursor position and progress
          function()
            local lnum = vim.fn.line(".")
            local col = vim.fn.charcol(".")
            local last = vim.fn.line("$")

            return string.format("%d:%d, %d%%%%", lnum, col, math.floor(lnum / last * 100))
          end,
        },
        {
          "encoding",
          fmt = function(str)
            -- don't load component if encoding is UTF-8
            if str == "utf-8" then
              return ""
            end

            return string.upper(str)
          end,
        },
        {
          "fileformat",
          -- don't load component if fileformat is unix
          cond = function()
            return vim.bo.fileformat ~= "unix"
          end,
        },
      },
      lualine_y = {},
      lualine_z = {
        {
          "mode",
          padding = 0,
          fmt = function(_)
            -- only show color as mode indicator
            return " "
          end,
        },
      },
    },
  },
  config = function(_, opts)
    local lualine = require("lualine")

    lualine.setup(opts)

    -- Refresh lualine when entering record mode
    -- NOTE: The register isn't cleared immediately after `RecordingLeave` so we just wait for lualine to refresh itself
    vim.api.nvim_create_autocmd("RecordingEnter", {
      group = vim.api.nvim_create_augroup("lualine_user_stl_refresh", { clear = true }),
      callback = function()
        lualine.refresh({ place = { "statusline" } })
      end,
    })
  end,
}
