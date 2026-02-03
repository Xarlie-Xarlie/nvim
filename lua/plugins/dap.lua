return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim"
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()

      -- JavaScript/TypeScript debug adapter (using Mason-installed js-debug-adapter)
      local js_debug_adapter = vim.fn.exepath("js-debug-adapter")
      if js_debug_adapter ~= "" then
        for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "node", "chrome" }) do
          dap.adapters[adapter] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
              command = js_debug_adapter,
              args = { "${port}" },
            },
          }
        end

        local js_based_languages = {
          "typescript",
          "javascript",
          "typescriptreact",
          "javascriptreact",
          "vue",
        }

        for _, language in ipairs(js_based_languages) do
          dap.configurations[language] = {
            -- Debug single nodejs files
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            -- Attach by process ID (pick from list)
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach to Node Process (Process ID)",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            -- Attach by port (simpler workflow)
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach to Node Process (Port)",
              port = function()
                local co = coroutine.running()
                return coroutine.create(function()
                  vim.ui.input({
                    prompt = "Enter debug port: ",
                    default = "9229",
                  }, function(port)
                    if port == nil or port == "" then
                      port = "9229"
                    end
                    coroutine.resume(co, tonumber(port))
                  end)
                end)
              end,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            -- Launch with npm run dev
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch npm dev",
              runtimeExecutable = "npm",
              runtimeArgs = { "run", "dev" },
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
              skipFiles = { "<node_internals>/**" },
              sourceMaps = true,
            },
            -- Launch with npm start
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch npm start",
              runtimeExecutable = "npm",
              runtimeArgs = { "start" },
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
              skipFiles = { "<node_internals>/**" },
              sourceMaps = true,
            },
            -- Launch with pnpm dev
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch pnpm dev",
              runtimeExecutable = "pnpm",
              runtimeArgs = { "dev" },
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
              skipFiles = { "<node_internals>/**" },
              sourceMaps = true,
            },
            -- Launch with pnpm start
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch pnpm start",
              runtimeExecutable = "pnpm",
              runtimeArgs = { "start" },
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
              skipFiles = { "<node_internals>/**" },
              sourceMaps = true,
            },
            -- Debug Jest tests
            {
              type = "pwa-node",
              request = "launch",
              name = "Debug Jest Tests (current file)",
              runtimeExecutable = "node",
              runtimeArgs = function()
                local jest_path = vim.fn.findfile("node_modules/.bin/jest", ".;")
                if jest_path == "" then
                  jest_path = "node_modules/.bin/jest"
                end
                return { jest_path, "${file}", "--runInBand" }
              end,
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
              skipFiles = { "<node_internals>/**", "**/node_modules/**" },
              sourceMaps = true,
            },
            -- Debug Vitest tests
            {
              type = "pwa-node",
              request = "launch",
              name = "Debug Vitest Tests (current file)",
              runtimeExecutable = "node",
              runtimeArgs = function()
                local vitest_path = vim.fn.findfile("node_modules/.bin/vitest", ".;")
                if vitest_path == "" then
                  vitest_path = "node_modules/.bin/vitest"
                end
                return { vitest_path, "run", "${file}" }
              end,
              rootPath = "${workspaceFolder}",
              cwd = "${workspaceFolder}",
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
              skipFiles = { "<node_internals>/**", "**/node_modules/**" },
              sourceMaps = true,
            },
            -- Debug web applications (client side)
            {
              type = "pwa-chrome",
              request = "launch",
              name = "Launch & Debug Chrome",
              url = function()
                local co = coroutine.running()
                return coroutine.create(function()
                  vim.ui.input({
                    prompt = "Enter URL: ",
                    default = "http://localhost:3000",
                  }, function(url)
                    if url == nil or url == "" then
                      return
                    else
                      coroutine.resume(co, url)
                    end
                  end)
                end)
              end,
              webRoot = "${workspaceFolder}",
              protocol = "inspector",
              sourceMaps = true,
              userDataDir = false,
            },
          }
        end
      end

      -- Enhanced Go configurations (additional to dap-go defaults)
      local dlv_path = vim.fn.exepath("dlv")
      if dlv_path ~= "" then
        -- Ensure Go configurations table exists
        if dap.configurations.go == nil then
          dap.configurations.go = {}
        end

        -- Attach to Go process by port (simpler than process picker)
        table.insert(dap.configurations.go, {
          type = "go",
          name = "Attach to Go Process (Port)",
          mode = "remote",
          request = "attach",
          port = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = "Enter delve port: ",
                default = "2345",
              }, function(port)
                if port == nil or port == "" then
                  port = "2345"
                end
                coroutine.resume(co, tonumber(port))
              end)
            end)
          end,
          host = "127.0.0.1",
        })

        -- Debug API with Make (assumes cmd/api/main.go entry point)
        table.insert(dap.configurations.go, {
          type = "go",
          name = "Debug API with Make (run-local-api)",
          request = "launch",
          program = "${workspaceFolder}/cmd/api/main.go",
          cwd = "${workspaceFolder}",
          buildFlags = "",
          args = function()
            return coroutine.create(function(dap_run_co)
              vim.ui.input({
                prompt = "Args (or leave empty): ",
                default = "",
              }, function(input)
                local args = {}
                if input and input ~= "" then
                  args = vim.split(input, " ")
                end
                coroutine.resume(dap_run_co, args)
              end)
            end)
          end,
        })

        -- Debug cmd/api/main.go directly
        table.insert(dap.configurations.go, {
          type = "go",
          name = "Debug cmd/api/main.go",
          request = "launch",
          program = "${workspaceFolder}/cmd/api/main.go",
          cwd = "${workspaceFolder}",
          buildFlags = "",
        })

        -- Debug cmd/api/main.go with arguments
        table.insert(dap.configurations.go, {
          type = "go",
          name = "Debug cmd/api/main.go (with args)",
          request = "launch",
          program = "${workspaceFolder}/cmd/api/main.go",
          cwd = "${workspaceFolder}",
          buildFlags = "",
          args = function()
            return coroutine.create(function(dap_run_co)
              vim.ui.input({
                prompt = "Args: ",
                default = "",
              }, function(input)
                local args = {}
                if input and input ~= "" then
                  args = vim.split(input, " ")
                end
                coroutine.resume(dap_run_co, args)
              end)
            end)
          end,
        })

        -- Alternative entry points (commented out - uncomment and adjust path as needed)
        --[[
        table.insert(dap.configurations.go, {
          type = "go",
          name = "Debug cmd/server/main.go",
          request = "launch",
          program = "${workspaceFolder}/cmd/server/main.go",
          cwd = "${workspaceFolder}",
          buildFlags = "",
        })

        table.insert(dap.configurations.go, {
          type = "go",
          name = "Debug main.go (root)",
          request = "launch",
          program = "${workspaceFolder}/main.go",
          cwd = "${workspaceFolder}",
          buildFlags = "",
        })
        --]]
      end

      -- Set breakpoint icons
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '󱣿', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })

      require("nvim-dap-virtual-text").setup {
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        highlight_new_as_changed = true,
        only_first_definition = false,
        all_references = true,
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      }

      local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"
      if elixir_ls_debugger ~= "" then
        dap.adapters.mix_task = {
          type = "executable",
          command = elixir_ls_debugger,
        }

        dap.configurations.elixir = {
          {
            type = "mix_task",
            name = "phoenix server",
            task = "phx.server",
            request = "launch",
            projectDir = "${workspaceFolder}",
            exitAfterTaskReturns = false,
            debugAutoInterpretAllModules = false,
          },
        }
      end

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
