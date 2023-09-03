return {
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'lewis6991/gitsigns.nvim',
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' } }
    },
    { 'rose-pine/neovim',                name = 'rose-pine' },
    { 'catppuccin/nvim',                 name = 'catppuccin', priority = 1000 },
    { 'tpope/vim-fugitive',              name = 'fugitive' },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        },
    },
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
        },
    },
    { 'ray-x/lsp_signature.nvim', event = 'VeryLazy', opts = {},
        config = function(_, opts) require('lsp_signature').setup(opts) end },

}
