-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  {
    'igorlfs/nvim-dap-view',
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
  },
  {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      'igorlfs/nvim-dap-view',
      -- 'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',

      -- DLL auto chooser
      'ramboe/ramboe-dotnet-utils',
    },
    keys = {
      -- Basic debugging keymaps, feel free to change to your liking!
      {
        '<F5>',
        function()
          require('dap').continue()
        end,
        desc = 'Debug: Start/Continue',
      },
      {
        '<F1>',
        function()
          require('dap').step_into()
        end,
        desc = 'Debug: Step Into',
      },
      {
        '<F2>',
        function()
          require('dap').step_over()
        end,
        desc = 'Debug: Step Over',
      },
      {
        '<F3>',
        function()
          require('dap').step_out()
        end,
        desc = 'Debug: Step Out',
      },
      {
        '<leader>bp',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
      },
      {
        '<leader>B',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      {
        '<F7>',
        function()
          -- require('dapui').toggle()
          require('dap-view').toggle()
        end,
        desc = 'Debug: See last session result.',
      },
    },
    config = function()
      local dap = require 'dap'
      -- local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
        },
      }

      -- Change breakpoint icons
      -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
      -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
      -- local breakpoint_icons = vim.g.have_nerd_font
      --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
      -- for type, icon in pairs(breakpoint_icons) do
      --   local tp = 'Dap' .. type
      --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      -- end
      --
      -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup {
        delve = {
          -- On Windows delve must be run attached or it crashes.
          -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          detached = vim.fn.has 'win32' == 0,
        },
      }

      require('easy-dotnet.netcoredbg').register_dap_variables_viewer()

      local mason_path = vim.fn.stdpath 'data' .. '/mason/packages/netcoredbg/netcoredbg'

      local netcoredbg_adapter = {
        type = 'executable',
        command = mason_path,
        args = { '--interpreter=vscode' },
      }

      dap.adapters.netcoredbg = netcoredbg_adapter -- needed for normal debugging
      dap.adapters.coreclr = netcoredbg_adapter -- needed for unit test debugging

      dap.configurations.cs = {
        {
          type = 'coreclr',
          name = 'launch - netcoredbg',
          request = 'launch',
          program = function()
            return require('dap-dll-autopicker').build_dll_path()
          end,
          -- justMyCode = false,
          -- stopAtEntry = false,
          -- -- program = function()
          -- --   -- todo: request input from ui
          -- --   return "/path/to/your.dll"
          -- -- end,
          env = {
            ASPNETCORE_ENVIRONMENT = function()
              -- todo: request input from ui
              return 'Development'
            end,
            -- ASPNETCORE_URLS = function()
            --   -- todo: request input from ui
            --   return 'http://localhost:5282'
            -- end,
          },
          cwd = function()
            -- todo: request input from ui
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir = vim.fn.fnamemodify(current_file, ':p:h')
            return vim.fn.input('Project Directory: ', require('dap-dll-autopicker').find_project_root_by_csproj(current_dir))
          end,
        },
        {
          type = 'coreclr',
          name = 'Attach to .NET Process',
          request = 'attach',
          -- This will prompt you to select a running process from a list
          processId = require('dap.utils').pick_process,
        },
      }

      dap.adapters.dart = {
        type = 'executable',
        -- As of this writing, this functionality is open for review in https://github.com/flutter/flutter/pull/91802
        command = 'flutter',
        args = { 'debug_adapter' },
      }
      dap.configurations.dart = {
        {
          type = 'dart',
          request = 'launch',
          name = 'Launch Flutter Program',
          console = 'terminal',
          -- The nvim-dap plugin populates this variable with the filename of the current buffer
          program = '${file}',
          -- The nvim-dap plugin populates this variable with the editor's current working directory
          cwd = '${workspaceFolder}',
        },
      }
    end,
  },
}
