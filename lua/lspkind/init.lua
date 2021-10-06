local lspkind = {}
local fmt = string.format

local kind_presets = {
  default = {
-- if you change or add symbol here
-- replace corresponding line in readme
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
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
  'Text', 'Method', 'Function', 'Constructor', 'Field', 'Variable', 'Class', 'Interface', 'Module',
  'Property', 'Unit', 'Value', 'Enum', 'Keyword', 'Snippet', 'Color', 'File', 'Reference', 'Folder',
  'EnumMember', 'Constant', 'Struct', 'Event', 'Operator', 'TypeParameter'
}
local kind_len = 25

-- default true
function opt_with_text(opts)
  return opts == nil or opts['with_text'] == nil or opts['with_text']
end

-- default 'default'
function opt_preset(opts)
  local preset
  if opts == nil or opts['preset'] == nil then
    preset = 'default'
  else
    preset = opts['preset']
  end
  return preset
end

function lspkind.init(opts)
  local with_text = opt_with_text(opts)
  local preset = opt_preset(opts)

  local symbol_map = kind_presets[preset]
  local symbol_map = (opts and opts['symbol_map'] and
                       vim.tbl_extend('force', symbol_map, opts['symbol_map'])) or symbol_map

  local symbols = {}
  local len = kind_len
  if with_text then
    for i = 1, len do
      local name = kind_order[i]
      local symbol = symbol_map[name]
      symbol = symbol and (symbol .. ' ') or ''
      symbols[i] = fmt('%s%s', symbol, name)
    end
  else
    for i = 1, len do
      local name = kind_order[i]
      symbols[i] = symbol_map[name]
    end
  end

  for k,v in pairs(symbols) do
    require('vim.lsp.protocol').CompletionItemKind[k] = v
  end
end

lspkind.presets = kind_presets

function lspkind.symbolic(kind, opts)
  local with_text = opt_with_text(opts)
  local preset = opt_preset(opts)

  local symbol = kind_presets[preset][kind]
  if with_text == true then
    symbol = symbol and (symbol .. ' ') or ''
    return fmt('%s%s', symbol, kind)
  else
    return symbol
  end
end

function lspkind.cmp_format(opts)
  if opts == nil then
    opts = {}
  end

  return function(entry, vim_item)
    vim_item.kind = lspkind.symbolic(vim_item.kind, opts)

    if opts.menu ~= nil then
      vim_item.menu = opts.menu[entry.source.name]
    end

    return vim_item
  end
end

return lspkind
