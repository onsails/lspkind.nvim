---@class Lspkind
---@field symbol_map SymbolMap
local lspkind = {}

---@class LspkindOpts
---@field mode? "text"|"text_symbol"|"symbol_text"|"symbol"
---@field preset? "default"|"codicons"
---@field symbol_map? SymbolMap

---@alias SymbolKind
---|"Class"
---|"Color"
---|"Constant"
---|"Constructor"
---|"Enum"
---|"EnumMember"
---|"Event"
---|"Field"
---|"File"
---|"Folder"
---|"Function"
---|"Interface"
---|"Keyword"
---|"Method"
---|"Module"
---|"Operator"
---|"Property"
---|"Reference"
---|"Snippet"
---|"Struct"
---|"Text"
---|"TypeParameter"
---|"Unit"
---|"Value"
---|"Variable"

---@class SymbolMap
---@field Class string
---@field Color string
---@field Constant string
---@field Constructor string
---@field Enum string
---@field EnumMember string
---@field Event string
---@field Field string
---@field File string
---@field Folder string
---@field Function string
---@field Interface string
---@field Keyword string
---@field Method string
---@field Module string
---@field Operator string
---@field Property string
---@field Reference string
---@field Snippet string
---@field Struct string
---@field Text string
---@field TypeParameter string
---@field Unit string
---@field Value string
---@field Variable string

local kind_presets = { ---@type table<"default"|"codicons", SymbolMap>
  default = {
    -- if you change or add symbol here
    -- replace corresponding line in readme
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰜢",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "󰈇",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "󰙅",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "",
  },
  codicons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
}

local kind_order = {
  "Text",
  "Method",
  "Function",
  "Constructor",
  "Field",
  "Variable",
  "Class",
  "Interface",
  "Module",
  "Property",
  "Unit",
  "Value",
  "Enum",
  "Keyword",
  "Snippet",
  "Color",
  "File",
  "Reference",
  "Folder",
  "EnumMember",
  "Constant",
  "Struct",
  "Event",
  "Operator",
  "TypeParameter",
}

---@type table<"text"|"text_symbol"|"symbol_text"|"symbol", fun(kind: SymbolKind): string>
local modes = {
  text = function(kind)
    return kind
  end,
  text_symbol = function(kind)
    return ("%s %s"):format(kind, lspkind.symbol_map[kind])
  end,
  symbol_text = function(kind)
    return ("%s %s"):format(lspkind.symbol_map[kind], kind)
  end,
  symbol = function(kind)
    return ("%s"):format(lspkind.symbol_map[kind])
  end,
}

-- default 'symbol'
---@param opts? LspkindOpts
---@return "text"|"text_symbol"|"symbol_text"|"symbol" mode
local function opt_mode(opts)
  return (opts and opts.mode) and opts.mode or "symbol"
end

-- default 'default'
---@param opts? LspkindOpts
---@return "codicons"|"default" preset
local function opt_preset(opts)
  return (opts and opts.preset) and opts.preset or "default"
end

---@param opts? LspkindOpts
local function opt_symbol_map(opts)
  local symbol_map = kind_presets[opt_preset(opts)]
  lspkind.symbol_map = (opts and opts.symbol_map) and vim.tbl_extend("force", symbol_map, opts.symbol_map) or symbol_map
end

---@param opts? LspkindOpts
function lspkind.init(opts)
  opt_symbol_map(opts)

  local mode = opt_mode(opts)
  for i, kind in ipairs(kind_order) do
    vim.lsp.protocol.CompletionItemKind[i] = modes[mode](kind)
  end
end

lspkind.setup = lspkind.init
lspkind.presets = kind_presets
lspkind.symbol_map = kind_presets.default

-- This function is for backward compatibility with other plugins
---@param kind SymbolKind
---@return string symbol
function lspkind.symbolic(kind)
  return lspkind.symbol_map[kind] or ""
end

---@param str string
---@param maxwidth integer
---@param ellipsis_char string
local function abbreviateString(str, maxwidth, ellipsis_char)
  if vim.fn.strchars(str) > maxwidth then
    return vim.fn.strcharpart(str, 0, maxwidth) .. ellipsis_char
  end

  return str
end

function lspkind.cmp_format(opts)
  opts = opts or {}
  if opts.preset or opts.symbol_map then
    opt_symbol_map(opts)
  end

  if not opts.maxwidth or type(opts.maxwidth) == "number" or type(opts.maxwidth) == "function" then
    opts.maxwidth = {
      abbr = opts.maxwidth,
      menu = opts.maxwidth,
    }
  end

  return function(entry, vim_item)
    if opts.before then
      vim_item = opts.before(entry, vim_item)
    end

    if opts.menu ~= nil then
      vim_item.menu = (opts.menu[entry.source.name] ~= nil and opts.menu[entry.source.name] or "")
        .. ((opts.show_labelDetails and vim_item.menu ~= nil) and vim_item.menu or "")
    end

    local ellipsis_char = opts.ellipsis_char ~= nil and opts.ellipsis_char or ""

    if opts.maxwidth.menu then
      local maxwidth = opts.maxwidth.menu
      maxwidth = type(maxwidth) == "function" and maxwidth() or maxwidth
      vim_item.menu = abbreviateString(vim_item.menu, maxwidth, ellipsis_char)
    end

    if opts.maxwidth.abbr then
      local maxwidth = opts.maxwidth.abbr
      maxwidth = type(maxwidth) == "function" and maxwidth() or maxwidth
      vim_item.abbr = abbreviateString(vim_item.abbr, maxwidth, ellipsis_char)
    end

    return vim_item
  end
end

return lspkind
