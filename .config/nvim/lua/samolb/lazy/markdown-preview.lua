return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
	build = "cd app && npx --yes yarn install",
        config = function()
            -- Browser to use (leave empty for default browser)
            vim.g.mkdp_browser = ''
            
            -- Auto-start preview when opening markdown file
            vim.g.mkdp_auto_start = 0  -- 0 = manual, 1 = auto
            
            -- Auto-close preview when switching away from markdown
            vim.g.mkdp_auto_close = 1
            
            -- Refresh preview on save or leaving insert mode
            vim.g.mkdp_refresh_slow = 0  -- 0 = real-time, 1 = on save only
            
            -- Preview server port (random if 0)
            vim.g.mkdp_port = '8080'
            
            -- Theme: 'dark' or 'light'
            vim.g.mkdp_theme = 'dark'
            
            -- Keybindings (only in markdown files)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    -- <leader>mp = Markdown Preview toggle
                    vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", 
                        { buffer = true, silent = true, desc = "Toggle Markdown Preview" })
                    
                    -- <leader>mo = Markdown Open preview
                    vim.keymap.set("n", "<leader>mo", ":MarkdownPreview<CR>", 
                        { buffer = true, silent = true, desc = "Open Markdown Preview" })
                    
                    -- <leader>mc = Markdown Close preview
                    vim.keymap.set("n", "<leader>mc", ":MarkdownPreviewStop<CR>", 
                        { buffer = true, silent = true, desc = "Close Markdown Preview" })
                end,
            })
        end,
    },
}
