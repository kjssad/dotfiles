return {
  { "rafamadriz/friendly-snippets" },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").config.setup({
        region_check_events = "InsertEnter",
        delete_check_events = "TextChanged,InsertLeave",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        confirmation = {
          -- default_behavior = cmp.ConfirmBehavior.Replace,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
          }),
        }),
        formatting = {
          fields = { "kind", "abbr" },
          format = function(_, vim_item)
            local kind_icons = {
              Text = " ",
              Method = " ",
              Function = " ",
              Constructor = " ",
              Field = " ",
              Variable = " ",
              Class = " ",
              Interface = " ",
              Module = " ",
              Property = " ",
              Unit = " ",
              Value = " ",
              Enum = " ",
              Keyword = " ",
              Snippet = " ",
              Color = " ",
              File = " ",
              Reference = " ",
              Folder = " ",
              EnumMember = " ",
              Constant = " ",
              Struct = " ",
              Event = " ",
              Operator = " ",
              TypeParameter = " ",
            }

            vim_item.kind = kind_icons[vim_item.kind]
            return vim_item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "Delimiter",
          },
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        window = {
          completion = {
            border = require("plugins.lsp.diagnostic").border,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          },
          documentation = {
            border = require("plugins.lsp.diagnostic").border,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          },
        },
      }
    end,
  },
}
