local M = {}
local cmp_loaded, cmp = pcall(require, "cmp")
local luasnip_loaded, luasnip = pcall(require, "luasnip")

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

local source_names = {
  nvim_lsp = "(lsp)",
  path = "(path)",
  luasnip = "(snippet)",
  buffer = "(buffer)",
  vsnip = "(snippet)",
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
  documentation = {
    border = require("plugins.lsp.diagnostic").border,
  },
  confirmation = {
    -- default_behavior = cmp.ConfirmBehavior.Replace,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
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
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      vim_item.menu = source_names[entry.source.name]
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
}

function M.setup()
  if cmp_loaded and luasnip_loaded then
    luasnip.config.setup({
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged,InsertLeave",
    })
    require("luasnip/loaders/from_vscode").lazy_load()
    cmp.setup(config)
  end
end

return M
