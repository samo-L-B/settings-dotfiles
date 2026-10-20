vim.opt.guicursor = ""
vim.opt.spell = true
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- Safe undir configuration
local function setup_undodir()
    local home = vim.env.HOME or os.getenv("HOME")
    if home then
        local undodir = home .. "/.vim/undodir"
        -- Create directory if it doesn't exist
        local handle = io.popen("mkdir \"" .. undodir .. "\" 2>NUL")
        if handle then
            handle:close()
            vim.opt.undodir = undodir
            vim.opt.undofile = true
        end
    else
        print("Warning: HOME environment variable not found!")
    end
end
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

--vim.opt.colorcolumn = "80"
--vim.opt.virtualedit = "block"
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
      if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
        vim.cmd("normal! g`\"")
      end
    end
}) -- return to last edit position when opening files


local HighlightYank = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = HighlightYank,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
}) -- highlight yanked text using the 'IncSearch' highlight group for 40ms

local Prettier = vim.api.nvim_create_augroup("Prettier", { clear = true })
vim.api.nvim_create_autocmd("bufWritePost", {
  group = Prettier,
  pattern = "*.vue",
  command = "silent !node_modules/.bin/prettier % -w",
})

