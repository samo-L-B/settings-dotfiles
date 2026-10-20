return {
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<leader>B", function() 
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, desc = "Debug: Conditional Breakpoint" },
    },
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { 
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Debug: Evaluate Expression" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })
      
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Python debugger
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "python",
    config = function()
      local function get_python_path()
        local cwd = vim.fn.getcwd()
        
        local venv = os.getenv("VIRTUAL_ENV")
        if venv then
          local venv_python = venv .. "\\Scripts\\python.exe"
          if vim.fn.filereadable(venv_python) == 1 then
            vim.notify("✓ Using VIRTUAL_ENV: " .. venv_python, vim.log.levels.INFO)
            return venv_python
          end
        end
        
        local win_paths = {
          cwd .. "\\venv\\Scripts\\python.exe",
          cwd .. "\\.venv\\Scripts\\python.exe",
          cwd .. "\\env\\Scripts\\python.exe",
          cwd .. "\\Scripts\\python.exe",
        }
        
        for _, path in ipairs(win_paths) do
          if vim.fn.filereadable(path) == 1 then
            vim.notify("✓ Using project venv: " .. path, vim.log.levels.INFO)
            return path
          end
        end
        
        local python_cmd = vim.fn.exepath("python")
        if python_cmd ~= "" then
          vim.notify("⚠ Using system Python: " .. python_cmd, vim.log.levels.WARN)
          return python_cmd
        end
        
        vim.notify("✗ No Python found! Install Python or activate venv", vim.log.levels.ERROR)
        return "python"
      end
      
      local python_path = get_python_path()
      require("dap-python").setup(python_path)
      
      vim.defer_fn(function()
        local handle = io.popen(python_path .. ' -c "import debugpy; print(debugpy.__version__)" 3>&1')
        if handle then
          local result = handle:read("*a")
          handle:close()
          if result:match("%d+%.%d+") then
            vim.notify("✓ debugpy " .. result:gsub("\n", "") .. " is installed", vim.log.levels.INFO)
          else
            vim.notify("✗ debugpy not found! Run: pip install debugpy", vim.log.levels.ERROR)
          end
        end
      end, 101)
      
      vim.keymap.set("n", "<leader>dpr", function()
        require("dap-python").test_method()
      end, { desc = "Debug: Python Test Method" })
      
      vim.keymap.set("n", "<leader>dpc", function()
        require("dap-python").test_class()
      end, { desc = "Debug: Python Test Class" })
    end,
  },
}
