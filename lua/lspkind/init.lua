local lspkind = {}

function lspkind.init()
	require('vim.lsp.protocol').CompletionItemKind = {
    '';             -- Text          = 1;
    '';             -- Method        = 2;
    'ƒ';             -- Function      = 3;
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

return lspkind
