return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "SmiteshP/nvim-navic",
    "ThePrimeagen/harpoon",

    },
  config = function()
    local fn = vim.fn
    local bo = vim.bo

    -- Current file with icon
    local function currentFile()
      local name = fn.expand("%:t")
      local ext = fn.expand("%:e")
      local icon = ""
      local devicons = require("nvim-web-devicons")
      if devicons then
        icon = devicons.get_icon(name, ext, { default = true }) or ""
      end
      return icon .. " " .. name
    end

    -- Clock (moved from tabline to statusline)
    local function clock()
      if vim.o.columns < 80 then return "" end
      local time = os.date("%H:%M")
      if os.time() % 2 == 1 then time = time:gsub(":", " ") end
      return "󰥔 " .. time
    end

    -- Visual mode selection count
    local function selectionCount()
      if not fn.mode():find("[Vv]") then return "" end
      local s = fn.line("v")
      local e = fn.line(".")
      local lines = math.abs(e - s) + 1
      return (" %dL %dC"):format(lines, fn.wordcount().visual_chars)
    end

    -- Time-based emoji component
    local function timeBasedEmoji()
      local hour = tonumber(os.date("%H"))
      if hour < 12 then
        return "🌇🍌"
      elseif hour < 18 then
        return "🌞"
      else
        return "🌙💩"
      end
    end
    -- Harpoon mark index
    local function harpoonMark()
      local ok, harpoon = pcall(require, "harpoon")
      if not ok then return "" end
      local idx = harpoon:list():get_current_index()
      return idx and idx > 0 and ("󱡅 %d"):format(idx) or ""
    end

    -- Git branch (with icon)
    local function gitBranch()
      local branch = require("lualine.components.branch.git_branch").get_branch()
      return (branch ~= "" and bo.buftype == "") and " " .. branch or ""
    end

    -- Navic breadcrumbs (LSP context)
    local function navicBreadcrumbs()
      local ok, navic = pcall(require, "nvim-navic")
      return (ok and navic.is_available()) and navic.get_location() or ""
    end

    -- Mixed whitespace warning
    local function irregularWhitespace()
      local hasTabs = fn.search("^\t", "nw") > 0
      local hasSpaces = fn.search("^ ", "nw") > 0
      if hasTabs and hasSpaces then return " Mixed indent" end
      if hasTabs then return "󰌒 Tabs" end
      if hasSpaces then return "󱁐 Spaces" end
      return ""
    end

    require("lualine").setup({
      options = {
        theme = "dracula", -- change if you prefer a different theme
        globalstatus = true,
        icons_enabled = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },

      -- 🧼 No tabline at all
      tabline = {},

      -- ✅ Full bottom line
      sections = {
        lualine_a = { clock, gitBranch },
        lualine_b = { currentFile, navicBreadcrumbs },
        lualine_c = {},
        lualine_x = {
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
            },
            irregularWhitespace,
            {timeBasedEmoji,
            update_event = "Hourly"},
        },
        lualine_y = { harpoonMark, selectionCount },
        lualine_z = { "location" },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}

