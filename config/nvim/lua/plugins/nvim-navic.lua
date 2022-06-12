local loaded, navic = pcall(require, "nvim-navic")

if not loaded then
  return
end

local config = {
  icons = {
    File = "  ",
    Module = "  ",
    Namespace = "  ",
    Package = "  ",
    Class = "  ",
    Method = "  ",
    Property = "  ",
    Field = "  ",
    Constructor = "  ",
    Enum = "  ",
    Interface = "  ",
    Function = "  ",
    Variable = "  ",
    Constant = "  ",
    String = "  ",
    Number = "  ",
    Boolean = "  ",
    Array = "  ",
    Object = "  ",
    Key = "  ",
    Null = "  ",
    EnumMember = "  ",
    Struct = "  ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
  },
  highlight = true,
  separator = " ❯ ",
}

local M = {}

function M.setup()
  navic.setup(config)
end

return M
