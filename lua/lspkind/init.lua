local M = {}
local H = {}
local fmt = string.format

local kinds = {
  -- Kind items order
  order = {
    cmp = {
      Text = 1,
      Method = 2,
      Function = 3,
      Constructor = 4,
      Field = 5,
      Variable = 6,
      Class = 7,
      Interface = 8,
      Module = 9,
      Property = 10,
      Unit = 11,
      Value = 12,
      Enum = 13,
      Keyword = 14,
      Snippet = 15,
      Color = 16,
      File = 17,
      Reference = 18,
      Folder = 19,
      EnumMember = 20,
      Constant = 21,
      Struct = 22,
      Event = 23,
      Operator = 24,
      TypeParameter = 25,
    },
    sym = {
      File = 1,
      Module = 2,
      Namespace = 3,
      Package = 4,
      Class = 5,
      Method = 6,
      Property = 7,
      Field = 8,
      Constructor = 9,
      Enum = 10,
      Interface = 11,
      Function = 12,
      Variable = 13,
      Constant = 14,
      String = 15,
      Number = 16,
      Boolean = 17,
      Array = 18,
      Object = 19,
      Key = 20,
      Null = 21,
      EnumMember = 22,
      Struct = 23,
      Event = 24,
      Operator = 25,
      TypeParameter = 26,
    },
  },
  -- Kind items list
  list = {
    cmp = require('vim.lsp.protocol').CompletionItemKind,
    sym = require('vim.lsp.protocol').SymbolKind,
  },
  -- Kind presets
  presets = {
    -- Mixed icons
    default = {
      Text = '',
      Method = '',
      Function = '',
      Constructor = '',
      Field = 'ﰠ',
      Variable = '',
      Class = 'ﴯ',
      Interface = '',
      Module = '',
      Property = 'ﰠ',
      Unit = '塞',
      Value = '',
      Enum = '',
      Keyword = '',
      Snippet = '',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = 'פּ',
      Event = '',
      Operator = '',
      TypeParameter = '',
      Namespace = '',
      Package = '',
      String = '',
      Number = '',
      Boolean = '',
      Array = '',
      Object = '',
      Key = '',
      Null = 'ﳠ',
    },
    -- VSCode icons, needs codicons font
    codicons = {
      Text = '',
      Method = '',
      Function = '',
      Constructor = '',
      Field = '',
      Variable = '',
      Class = '',
      Interface = '',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '',
      Keyword = '',
      Snippet = '',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = '',
      Event = '',
      Operator = '',
      TypeParameter = '',
      Namespace = '',
      Package = '',
      String = '',
      Number = '',
      Boolean = '',
      Array = '',
      Object = '',
      Key = '',
      Null = '',
    },
    -- Material Design Icons
    mdi = {
      Text = '',
      Method = '',
      Function = '',
      Constructor = '漣',
      Field = '',
      Variable = '',
      Class = 'פּ',
      Interface = '囹',
      Module = '',
      Property = '襁',
      Unit = '',
      Value = '',
      Enum = '惡',
      Keyword = '',
      Snippet = '',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      EnumMember = '惡',
      Constant = '',
      Struct = 'ﴯ',
      Event = '',
      Operator = '',
      TypeParameter = '',
      Namespace = '異',
      Package = '',
      String = '',
      Number = '',
      Boolean = '蘒',
      Array = '',
      Object = '',
      Key = '',
      Null = 'ﳠ',
    },
  },
}

function H.get_symbol(list, order, item)
  local kind = {}
  for _kind, _idx in pairs(order) do
    if type(item) == 'string' and item == _kind then
      kind.name = _kind
      kind.icon = list[_idx]
      kind.idx = _idx
    elseif type(item) == 'number' and item == _idx then
      kind.name = _kind
      kind.icon = list[item]
      kind.idx = item
    end
  end
  return kind
end

H.modes = {
  text = function(kind)
    return kind.name
  end,
  text_symbol = function(kind)
    return fmt('%s %s', kind.name, kind.icon)
  end,
  symbol = function(kind)
    return fmt('%s', kind.icon)
  end,
  symbol_text = function(kind)
    return fmt('%s %s', kind.icon, kind.name)
  end,
}

H.defaults = {
  mode = 'symbol_text',
  symbols = 'default',
}

function H.fmt_kind(mode, _kind, icon)
  local kitem = {
    name = H.get_symbol(kinds.list.cmp, kinds.order.cmp, _kind).name,
    icon = icon,
  }
  return H.modes[mode](kitem)
end

function H.set_symbols(ktype, symbols, mode)
  local idx
  for kind, icon in pairs(symbols) do
    if ktype[kind] ~= nil then
      idx = ktype[kind]
      ktype[idx] = H.fmt_kind(mode, kind, icon)
    end
  end
end

function M.setup(opts)
  opts = vim.tbl_deep_extend('force', H.defaults, opts or {})
  local symbols
  if type(opts.symbols) == 'string' then
    symbols = kinds.presets[opts.symbols]
  else
    symbols = vim.tbl_deep_extend('force', kinds.presets.default, opts.symbols)
  end

  H.set_symbols(kinds.list.cmp, symbols, opts.mode)
  H.set_symbols(kinds.list.sym, symbols, opts.mode)
end

function M.cmp_format(opts)
  opts = vim.tbl_deep_extend('force', H.defaults, opts or {})

  if opts.symbols then
    M.setup(opts)
  end

  return function(entry, vim_item)
    if opts.before then
      vim_item = opts.before(entry, vim_item)
    end

    vim_item.kind = H.get_symbol(kinds.list.cmp, kinds.order.cmp, vim_item.kind).icon

    if opts.menu ~= nil then
      vim_item.menu = opts.menu[entry.source.name]
    end

    if opts.maxwidth ~= nil then
      vim_item.abbr = string.sub(vim_item.abbr, 1, opts.maxwidth)
    end

    return vim_item
  end
end

return M
