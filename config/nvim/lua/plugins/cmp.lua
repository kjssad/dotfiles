local loaded, cmp = pcall(require, "cmp")

if not loaded then
  return
end

local luasnip = require("luasnip")

local kind_icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Operator = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local config = {
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
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },
  experimental = {
    ghost_text = {
      hl_group = "Delimiter",
    },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "buffer" },
  },
  window = {
    completion = {
      border = require("plugins.lsp.diagnostic").border,
    },
    documentation = {
      border = require("plugins.lsp.diagnostic").border,
    },
  },
}

local M = {}

function M.setup()
  cmp.setup(config)
end

return M
