-- vim.opt.guicursor = ''

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- default indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.api.nvim_create_autocmd("FileTYpe", {
    pattern = "cpp",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end
})

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 500
vim.opt.colorcolumn = '80'

