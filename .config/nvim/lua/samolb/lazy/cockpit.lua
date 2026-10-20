local cockpit = {
    -- Completely commented out - WON'T LOAD
    --{
    --    "cockpit",
    --    dir = "~/personal/cockpit",
    --    config = function()
    --        require("cockpit")
    --        vim.keymap.set("n", "<leader>ct", "<cmd>CockpitTest<CR>")
    --        vim.keymap.set("n", "<leader>cr", "<cmd>CockpitRefresh<CR>")
    --    end,
    --},

    -- Uncommented - WILL LOAD
    --{
    --    "another-plugin",
    --    dir = "~/personal/another-plugin",
    --    config = function()
    --        require("another-plugin")
    --    end,
    --},
}
return cockpit
