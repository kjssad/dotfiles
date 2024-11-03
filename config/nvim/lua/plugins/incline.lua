return {
  "b0o/incline.nvim",
  opts = {
    highlight = {
      groups = {
        InclineNormal = {
          default = true,
          group = "Normal",
        },
        InclineNormalNC = {
          default = true,
          group = "Normal",
        },
      },
    },
    window = {
      margin = {
        horizontal = 0,
        vertical = 1,
      },
    },
    render = function(props)
      local function diagnostics()
        local symbols = { error = " ", warn = " ", info = " ", hint = " " }
        local label = {}

        for severity, symbol in pairs(symbols) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { symbol .. n .. " ", group = "DiagnosticSign" .. severity })
          end
        end
        if #label == 0 then
          table.insert(label, { "󰄬 ", group = "DiagnosticSignHint" })
        end
        return label
      end

      return {
        diagnostics(),
      }
    end,
  },
  config = function(_, opts)
    local incline = require("incline")

    incline.setup(opts)

    -- Refresh incline when diagnostics changed
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      group = vim.api.nvim_create_augroup("incline_user_diagnostic_refresh", { clear = true }),
      callback = function()
        incline.refresh()
      end,
    })
  end,
}
