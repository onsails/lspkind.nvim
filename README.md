# lspkind-nvim

This tiny plugin adds vscode-like pictograms to neovim built-in lsp:

![Screenshot](https://github.com/onsails/lspkind-nvim/raw/master/images/screenshot.png "Screenshot")

## Configuration

Wherever you configure lsp put the following lua command:

```lua
-- commented options are defaults
require('lspkind').init({
    -- with_text = true,
    -- symbol_map = {
    --   Text = '',
    --   Method = 'ƒ',
    --   Function = '',
    --   Constructor = '',
    --   Variable = '',
    --   Class = '',
    --   Interface = 'ﰮ',
    --   Module = '',
    --   Property = '',
    --   Unit = '',
    --   Value = '',
    --   Enum = '了',
    --   Keyword = '',
    --   Snippet = '﬌',
    --   Color = '',
    --   File = '',
    --   Folder = '',
    --   EnumMember = '',
    --   Constant = '',
    --   Struct = ''
    -- },
})
```
