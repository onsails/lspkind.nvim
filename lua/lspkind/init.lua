local lspkind = {}

function lspkind.init(opts)
    local with_text = opts == nil or opts['with_text']

    -- deliberate code repeat to avoid if cond
    -- or string concat on each symbol

    if with_text == true or with_text == nil then
        require('vim.lsp.protocol').CompletionItemKind = {
            ' Text';        -- = 1
            'ƒ Method';      -- = 2;
            ' Function';    -- = 3;
            ' Constructor'; -- = 4;
            'Field';         -- = 5;
            ' Variable';    -- = 6;
            ' Class';       -- = 7;
            'ﰮ Interface';   -- = 8;
            ' Module';      -- = 9;
            ' Property';    -- = 10;
            ' Unit';        -- = 11;
            ' Value';       -- = 12;
            '了Enum';        -- = 13;
            ' Keyword';     -- = 14;
            '﬌ Snippet';     -- = 15;
            ' Color';       -- = 16;
            ' File';        -- = 17;
            'Reference';     -- = 18;
            ' Folder';      -- = 19;
            ' EnumMember';  -- = 20;
            ' Constant';    -- = 21;
            ' Struct';      -- = 22;
            'Event';         -- = 23;
            'Operator';      -- = 24;
            'TypeParameter'; -- = 25;
        }
    else
        require('vim.lsp.protocol').CompletionItemKind = {
            '';             -- Text          = 1;
            'ƒ';             -- Method        = 2;
            '';             -- Function      = 3;
            '';             -- Constructor   = 4;
            'Field';         -- Field         = 5;
            '';             -- Variable      = 6;
            '';             -- Class         = 7;
            'ﰮ';             -- Interface     = 8;
            '';             -- Module        = 9;
            '';             -- Property      = 10;
            '';             -- Unit          = 11;
            '';             -- Value         = 12;
            '了';            -- Enum          = 13;
            '';             -- Keyword       = 14;
            '﬌';             -- Snippet       = 15;
            '';             -- Color         = 16;
            '';             -- File          = 17;
            'Reference';     -- Reference     = 18;
            '';             -- Folder        = 19;
            '';             -- EnumMember    = 20;
            '';             -- Constant      = 21;
            '';             -- Struct        = 22;
            'Event';         -- Event         = 23;
            'Operator';      -- Operator      = 24;
            'TypeParameter'; -- TypeParameter = 25;
        }
    end
end

return lspkind
