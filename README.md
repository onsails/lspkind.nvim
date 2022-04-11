# 🪧 lspkind.nvim

This tiny plugin adds vscode-like pictograms to neovim built-in lsp:

![Screenshot](https://github.com/onsails/lspkind-nvim/raw/images/images/screenshot.png "Screenshot")
<sup>[nvim-compe](https://github.com/hrsh7th/nvim-compe), [vim-vsnip](https://github.com/hrsh7th/vim-vsnip), [vim-vsnip-integ](https://github.com/hrsh7th/vim-vsnip-integ), [jellybeans-nvim](https://github.com/metalelf0/jellybeans-nvim)</sup>

## 📦 Installation
Use your favorite package manager.
This example uses `packer.nvim`:

```lua
use({'onsails/lspkind.nvim'})
```

## ⚙️ Configuration

### Option 1: vanilla Neovim LSP

Wherever you configure lsp put the following lua command:

```lua
require('lspkind').setup({
  -- Defines how annotations are shown,
  -- can be 'text', 'text_symbol', 'symbol' or 'symbol_text'
  -- default: symbol_text
  mode = 'symbol_text',

  -- Symbols list can be a preset or a table with custom icons
  -- 'default' and 'mdi' (requires nerd-fonts font) or
  -- 'codicons' (requires vscode-codicons font)
  -- No need to worry about the order as this is managed by the plugin
  -- default: 'default'
  symbols = 'default',
  -- or override preset symbols
  symbols = {
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
})
```

### Option 2: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

```lua
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        ...
        return vim_item
      end
    })
  }
}
```

### 🗃️ Available presets
<details>
  <summary>default - mixed icons</summary>

  ```
  Text = ''
  Method = ''
  Function = ''
  Constructor = ''
  Field = 'ﰠ'
  Variable = ''
  Class = 'ﴯ'
  Interface = ''
  Module = ''
  Property = 'ﰠ'
  Unit = '塞'
  Value = ''
  Enum = ''
  Keyword = ''
  Snippet = ''
  Color = ''
  File = ''
  Reference = ''
  Folder = ''
  EnumMember = ''
  Constant = ''
  Struct = 'פּ'
  Event = ''
  Operator = ''
  TypeParameter = ''
  Namespace = ''
  Package = ''
  String = ''
  Number = ''
  Boolean = ''
  Array = ''
  Object = ''
  Key = ''
  Null = 'ﳠ'
  ```
</details>
<details>
  <summary>codicons - VSCode icons</summary>

  ```
  Text = ''
  Method = ''
  Function = ''
  Constructor = ''
  Field = ''
  Variable = ''
  Class = ''
  Interface = ''
  Module = ''
  Property = ''
  Unit = ''
  Value = ''
  Enum = ''
  Keyword = ''
  Snippet = ''
  Color = ''
  File = ''
  Reference = ''
  Folder = ''
  EnumMember = ''
  Constant = ''
  Struct = ''
  Event = ''
  Operator = ''
  TypeParameter = ''
  Namespace = ''
  Package = ''
  String = ''
  Number = ''
  Boolean = ''
  Array = ''
  Object = ''
  Key = ''
  Null = ''
  ```
</details>
<details>
  <summary>mdi - Material Design icons</summary>

  ```
  Text = ''
  Method = ''
  Function = ''
  Constructor = '漣'
  Field = ''
  Variable = ''
  Class = 'פּ'
  Interface = '囹'
  Module = ''
  Property = '襁'
  Unit = ''
  Value = ''
  Enum = '惡'
  Keyword = ''
  Snippet = ''
  Color = ''
  File = ''
  Reference = ''
  Folder = ''
  EnumMember = '惡'
  Constant = ''
  Struct = 'ﴯ'
  Event = ''
  Operator = ''
  TypeParameter = ''
  Namespace = '異'
  Package = ''
  String = ''
  Number = ''
  Boolean = '蘒'
  Array = ''
  Object = ''
  Key = ''
  Null = 'ﳠ'
  ```
</details>

## 🤝 Related LSP plugins

[diaglist.nvim](https://github.com/onsails/diaglist.nvim) – live render workspace diagnostics in quickfix with current buf errors on top, buffer diagnostics in loclist
