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

local function get_symbol(kind) 
    local symbol = lspkind.symbol_map[kind]
    return symbol or ''
end

local modes = { 
    ['text'] = function(kind)
        return kind
    end, 
    ['text_symbol'] = function(kind)
        local symbol = get_symbol(kind)
        return fmt("%s %s", kind, symbol)
    end, 
    ['symbol_text'] = function(kind)
        local symbol = get_symbol(kind)
        return fmt("%s %s", symbol, kind)
    end, 
    ['symbol']  = function(kind)
        local symbol = get_symbol(kind)
        return fmt("%s", symbol)
    end 
}

-- default true
-- deprecated
local function opt_with_text(opts)
  return opts == nil or opts['with_text'] == nil or opts['with_text']
end

-- default 'symbol'
local function opt_mode(opts) 
    local mode = 'symbol'
    if opt_with_text(opts) and opts ~= nil and opts['mode'] == nil then
        vim.api.nvim_command("echoerr 'DEPRECATED replaced by mode option.'")
        mode = 'symbol_text'
    elseif opts ~= nil and opts['mode'] ~= nil then
        mode = opts['mode']
    end
    return mode
end

-- default 'default'
local function opt_preset(opts)
  local preset
  if opts == nil or opts['preset'] == nil then
    preset = 'default'
  else
    preset = opts['preset']
  end
  return preset
end

function lspkind.init(opts)
  local preset = opt_preset(opts)

  local symbol_map = kind_presets[preset]
  lspkind.symbol_map = (opts and opts['symbol_map'] and
                       vim.tbl_extend('force', symbol_map, opts['symbol_map'])) or symbol_map

  local symbols = {}
  local len = kind_len
  for i = 1, len do
    local name = kind_order[i]
    symbols[i] = lspkind.symbolic(name, opts)
  end

  for k,v in pairs(symbols) do
    require('vim.lsp.protocol').CompletionItemKind[k] = v
  end
end

lspkind.presets = kind_presets
lspkind.symbol_map = kind_presets.default

function lspkind.symbolic(kind, opts)
  local mode = opt_mode(opts)
  local formatter = modes[mode]

  -- if someone enters an invalid mode, default to symbol
  if formatter == nil then
      formatter = modes['symbol']
  end

  return formatter(kind)
end

function lspkind.cmp_format(opts)
  if opts == nil then
    opts = {}
  end
  if opts.preset or opts.symbol_map then
    lspkind.init(opts)
  end

  return function(entry, vim_item)
    if opts.before then
          vim_item = opts.before(entry, vim_item)
    end
        
    vim_item.kind = lspkind.symbolic(vim_item.kind, opts)

    if opts.menu ~= nil then
      vim_item.menu = opts.menu[entry.source.name]
    end

    if opts.maxwidth ~= nil then
        vim_item.abbr = string.sub(vim_item.abbr, 1, opts.maxwidth)
    end

    return vim_item
  end
end

return lspkind
