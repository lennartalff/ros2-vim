require('mason').setup({
    ui = {
        border = 'rounded'
    }
})
-- Install language servers
require('mason-lspconfig').setup {
    ensure_installed = {
        'lua_ls', 'clangd', 'pylsp', 'yamlls'
    }
}
local lsp = require('lsp-zero').preset({
    manage_nvim_cmp = {
        set_sources = 'lsp',
        set_basic_mappings = true,
        set_extra_mappings = false,
        use_luasnip = true,
        set_format = true,
        documentation_window = true,
    }
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

-- configure auto complete key
cmp.setup({
    mapping = {
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-space>'] = cmp.mapping.complete(),
        ['<C-j>'] = cmp.mapping.scroll_docs(1),
        ['<C-k>'] = cmp.mapping.scroll_docs(-1),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

require('lspconfig').pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                autopep8 = { enabled = false },
                yapf = { enabled = true, args = '--style={based_on_style: google column_limit: 80}' },
            }
        }
    }
}
