-- ~/nvim/lua/plugins/ui.lua

return {
  -- 🌀 Animated UI with mini.animate
--  {
--    "echasnovski/mini.animate",
--    version = "*",
--    config = function()
--      require("mini.animate").setup({
--        scroll = {
--          enable = true,
--          timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),},
--        cursor = {
--          enable = true,
--          timing = require("mini.animate").gen_timing.linear({ duration = 75, unit = "total" }),},
--        resize = {
--          enable = true,
--          timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),},
--       open = {
--          enable = true,
--          timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),},
--         close = {
--          enable = true,
--          timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),},})
--    end,},
  -- 🔔 Better Notification UI
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require("notify")
      vim.notify = notify
      notify.setup({
        stages = "fade_in_slide_out", -- smooth animation
        timeout = 3000,
        background_colour = "#1e1e2e", -- match your colorscheme
        render = "default",})
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons",},
    config = function()
        require("nvim-tree").setup {
          sort = { sorter = "case_sensitive" },
          view = {
            width = 30,
            adaptive_size = false,},
          renderer = { group_empty = true },
          filters = { dotfiles = false },}
      end,
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
        routes = {
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '; after #%d+' },
                { find = '; before #%d+' },
                { find = '%d fewer lines' },
                { find = '%d more lines' }, },
            },
            opts = { skip = true },
          }
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
    --   "rcarriga/nvim-notify",
    }
  },
  -- 🌒 Dim inactive portions of code
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25, -- amount of dimming
          color = { "Normal", "#ffffff" },
          term_bg = "#000000",
        },
        context = 10, -- lines of context (visible)
        expand = { -- which nodes should always be expanded
          "function",
          "method",
          "table",
          "if_statement",
        },
      })
    end,
  },
}

