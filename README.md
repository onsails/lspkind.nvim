# lspkind-nvim

This tiny plugin adds vscode-like pictograms to neovim built-in lsp:

![Screenshot](https://github.com/onsails/lspkind-nvim/raw/images/images/screenshot.png "Screenshot")
<sup>[nvim-compe](https://github.com/hrsh7th/nvim-compe), [vim-vsnip](https://github.com/hrsh7th/vim-vsnip), [vim-vsnip-integ](https://github.com/hrsh7th/vim-vsnip-integ), [one-nvim](https://github.com/Th3Whit3Wolf/one-nvim)</sup>

## Configuration

Wherever you configure lsp put the following lua command:

```lua
require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
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
})
```
