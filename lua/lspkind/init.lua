local lspkind = {}
local fmt = string.format

local kind_presets = {
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

local modes = {
  ["text"] = function(kind)
    return kind
  end,
  ["text_symbol"] = function(kind)
    return fmt("%s %s", kind, lspkind.symbol_map[kind])
  end,
  ["symbol_text"] = function(kind)
    return fmt("%s %s", lspkind.symbol_map[kind], kind)
  end,
  ["symbol"] = function(kind)
    return fmt("%s", lspkind.symbol_map[kind])
  end,
}

-- default 'symbol'
local function opt_mode(opts)
  local mode = "symbol"
  if opts ~= nil and opts["mode"] ~= nil then
    mode = opts["mode"]
  end
  return mode
end

-- default 'default'
local function opt_preset(opts)
  local preset
  if opts == nil or opts["preset"] == nil then
    preset = "default"
  else
    preset = opts["preset"]
  end
  return preset
end

local function opt_symbol_map(opts)
  local preset = opt_preset(opts)

  local symbol_map = kind_presets[preset]
  lspkind.symbol_map = (opts and opts["symbol_map"] and vim.tbl_extend("force", symbol_map, opts["symbol_map"]))
    or symbol_map
end

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
function lspkind.symbolic(kind)
  return lspkind.symbol_map[kind] or ""
end

local function abbreviateString(str, maxwidth, ellipsis_char)
  if vim.fn.strchars(str) > maxwidth then
    str = vim.fn.strcharpart(str, 0, maxwidth) .. ellipsis_char
  end

  return str
end

function lspkind.cmp_format(opts)
  if opts == nil then
    opts = {}
  end
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
