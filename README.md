# lspkind.nvim

> VS Code–style pictograms for Neovim completion items

[![GitHub Stars](https://img.shields.io/github/stars/onsails/lspkind.nvim?style=flat)](https://github.com/onsails/lspkind.nvim)
[![License](https://img.shields.io/badge/license-MIT-informational.svg)](./LICENSE)
[![Neovim](https://img.shields.io/badge/Neovim-%E2%89%A5%200.7-blue.svg)](https://neovim.io/)

**lspkind.nvim** adds a clear, consistent iconography layer to Neovim’s completion UI (LSP, snippets, paths, etc.). It improves scanability of completion menus, making intent and item type obvious at a glance.

![Screenshot](https://github.com/onsails/lspkind-nvim/raw/images/images/screenshot.png "Screenshot")
<sup>[nvim-compe](https://github.com/hrsh7th/nvim-compe), [vim-vsnip](https://github.com/hrsh7th/vim-vsnip), [vim-vsnip-integ](https://github.com/hrsh7th/vim-vsnip-integ), [jellybeans-nvim](https://github.com/metalelf0/jellybeans-nvim)</sup>

---

## Features

* **Readable completion menus** with VS Code–like pictograms
* **Drop-in integration** with `nvim-cmp` via `lspkind.cmp_format`
* **Two presets** out of the box: `default` (Nerd Fonts) and `codicons`
* **Fully customizable** symbol map per kind and per external source
* **Zero heavy deps**; tiny footprint and straightforward Lua API

---

## Requirements

* Neovim **0.7+**
* A patched icon font:

  * **Nerd Fonts** for `preset = 'default'` → [https://www.nerdfonts.com/](https://www.nerdfonts.com/)
  * **VS Code Codicons** for `preset = 'codicons'` → [https://github.com/microsoft/vscode-codicons](https://github.com/microsoft/vscode-codicons)

---

## Configuration

### Option 1: vanilla Neovim LSP

Wherever you configure lsp put the following lua command:

```lua
-- setup() is also available as an alias
require('lspkind').init({
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
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
})
```

### Option 2: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

```lua
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    fields = { 'abbr', 'icon', 'kind', 'menu' },
    format = lspkind.cmp_format({
      maxwidth = {
        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        -- can also be a function to dynamically calculate max width such as
        -- menu = function() return math.floor(0.45 * vim.o.columns) end,
        menu = 50, -- leading text (labelDetails)
        abbr = 50, -- actual suggestion item
      },
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        -- ...
        return vim_item
      end
    })
  }
}
```

## Related LSP plugins

[diaglist.nvim](https://github.com/onsails/diaglist.nvim) – live render workspace diagnostics in quickfix with current buf errors on top, buffer diagnostics in loclist
