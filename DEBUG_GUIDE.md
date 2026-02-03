# Neovim DAP Debug Guide

Complete guide for debugging Node.js/TypeScript and Go projects in Neovim using nvim-dap.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Basic DAP Commands](#basic-dap-commands)
- [Node.js/TypeScript Debugging](#nodejstypescript-debugging)
  - [Launch Mode (Debugger Starts Server)](#launch-mode-debugger-starts-server)
  - [Attach Mode (Attach to Running Server)](#attach-mode-attach-to-running-server)
  - [Debugging Tests](#debugging-nodejs-tests)
  - [Chrome Debugging](#chrome-debugging)
- [Go Debugging](#go-debugging)
  - [Launch Mode (Debugger Starts Program)](#launch-mode-debugger-starts-program)
  - [Attach Mode (Attach to Running Process)](#attach-mode-attach-to-running-process)
  - [Debugging Tests](#debugging-go-tests)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Installations (via Mason)

1. Open Neovim and run `:Mason`
2. Install the following debuggers:
   - `js-debug-adapter` (for Node.js/TypeScript)
   - `delve` (for Go)

### Verify Installation

```bash
# Check if debuggers are installed
ls ~/.local/share/nvim/mason/bin/

# Should show:
# - js-debug-adapter
# - dlv
```

---

## Basic DAP Commands

| Command | Description |
|---------|-------------|
| `:DapContinue` | Start debugging or continue execution |
| `:DapToggleBreakpoint` | Toggle breakpoint on current line |
| `:DapStepOver` | Step over (execute current line) |
| `:DapStepInto` | Step into function |
| `:DapStepOut` | Step out of function |
| `:DapTerminate` | Stop debugging session |

### Recommended Keymaps

Add to your Neovim config if not already present:

```lua
-- Set breakpoint
vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>')
-- Start/Continue debugging
vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>')
-- Step over
vim.keymap.set('n', '<leader>do', ':DapStepOver<CR>')
-- Step into
vim.keymap.set('n', '<leader>di', ':DapStepInto<CR>')
-- Step out
vim.keymap.set('n', '<leader>dO', ':DapStepOut<CR>')
-- Terminate
vim.keymap.set('n', '<leader>dt', ':DapTerminate<CR>')
```

---

## Node.js/TypeScript Debugging

### Launch Mode (Debugger Starts Server)

**When to use:** Simple projects where you want the debugger to start your development server.

#### Steps:

1. **Open your project** in Neovim
2. **Open a source file** (not node_modules)
3. **Set breakpoints** using `:DapToggleBreakpoint` or `<leader>db`
4. **Start debugging:**
   ```
   :DapContinue
   ```
5. **Select a launch configuration:**
   - `Launch file` - Debug current file
   - `Launch npm dev` - Start with `npm run dev`
   - `Launch npm start` - Start with `npm start`
   - `Launch pnpm dev` - Start with `pnpm dev`
   - `Launch pnpm start` - Start with `pnpm start`

6. **Wait for server to start** and hit your breakpoints

#### Example: Launch pnpm dev

```
1. Open: src/server.ts
2. Set breakpoint on line 10
3. :DapContinue
4. Select: "Launch pnpm dev"
5. Server starts and debugger attaches
6. Navigate to your app in browser to trigger breakpoint
```

---

### Attach Mode (Attach to Running Server)

**When to use:**
- Complex projects with specific startup requirements
- Monorepo projects (Next.js with multiple apps)
- When you need more control over server startup
- Production-like environments

#### Method 1: Attach by Port (Recommended)

##### Steps:

1. **Start your server with `--inspect` flag:**

   **For pnpm:**
   ```bash
   pnpm dev -- --inspect=9229
   # or break on first line:
   pnpm dev -- --inspect-brk=9229
   ```

   **For npm:**
   ```bash
   npm run dev -- --inspect=9229
   # or break on first line:
   npm run dev -- --inspect-brk=9229
   ```

   **For custom ports (useful in monorepos):**
   ```bash
   # App 1
   pnpm dev --filter=app1 -- --inspect=9229

   # App 2
   pnpm dev --filter=app2 -- --inspect=9230

   # App 3
   pnpm dev --filter=app3 -- --inspect=9231
   ```

2. **In Neovim, open source file and set breakpoints**

3. **Start debugging:**
   ```
   :DapContinue
   ```

4. **Select: "Attach to Node Process (Port)"**

5. **Enter port number:**
   ```
   Enter debug port: 9229
   ```
   (Press Enter for default 9229)

6. **Trigger your code** (navigate in browser, make API call, etc.)

7. **Debugger stops at breakpoints**

##### Common Ports:

| Service | Port |
|---------|------|
| Primary dev server | 9229 |
| Second service | 9230 |
| Third service | 9231 |
| Custom | Choose any available port |

#### Method 2: Attach by Process ID

##### Steps:

1. **Start your server normally:**
   ```bash
   pnpm dev -- --inspect
   ```

2. **In Neovim:**
   ```
   :DapContinue
   ```

3. **Select: "Attach to Node Process (Process ID)"**

4. **Search/select your process from the list**

---

### Debugging Node.js Tests

#### Jest Tests

##### Steps:

1. **Open your test file** (e.g., `user.test.ts`)

2. **Set breakpoints** in test or source code

3. **Start debugging:**
   ```
   :DapContinue
   ```

4. **Select: "Debug Jest Tests (current file)"**

5. **Debugger runs tests and stops at breakpoints**

##### Example:

```typescript
// user.test.ts
describe('User', () => {
  it('should create user', () => {
    // Set breakpoint here
    const user = createUser({ name: 'John' });
    expect(user.name).toBe('John');
  });
});
```

#### Vitest Tests

##### Steps:

1. **Open your test file** (e.g., `utils.test.ts`)

2. **Set breakpoints** in test or source code

3. **Start debugging:**
   ```
   :DapContinue
   ```

4. **Select: "Debug Vitest Tests (current file)"**

5. **Debugger runs tests and stops at breakpoints**

##### Requirements:

- Vitest must be installed: `pnpm add -D vitest`
- Test file must be in your project

---

### Chrome Debugging

Debug client-side JavaScript/TypeScript in Chrome browser.

#### Steps:

1. **Open your frontend file**

2. **Set breakpoints** in client-side code

3. **Start debugging:**
   ```
   :DapContinue
   ```

4. **Select: "Launch & Debug Chrome"**

5. **Enter URL:**
   ```
   Enter URL: http://localhost:3000
   ```
   (Adjust port for your app)

6. **Chrome opens automatically**

7. **Navigate in browser** to trigger breakpoints

#### Notes:

- Chrome must be installed
- Works with React, Vue, vanilla JS/TS
- Source maps must be enabled in your build config

---

## Go Debugging

### Launch Mode (Debugger Starts Program)

**When to use:** Direct debugging of Go programs without manual setup.

#### Method 1: Debug Current File

##### Steps:

1. **Open a Go file** (e.g., `main.go`)

2. **Set breakpoints**

3. **Start debugging:**
   ```
   :DapContinue
   ```

4. **Select one of:**
   - `Debug` - Debug current file
   - `Debug (Arguments)` - Debug with command-line arguments
   - `Debug Package` - Debug entire package

5. **Program runs and stops at breakpoints**

#### Method 2: Debug API Entry Point

**For projects with `cmd/api/main.go` structure:**

##### Steps:

1. **Open any Go file in your project**

2. **Set breakpoints** (in handlers, services, etc.)

3. **Start debugging:**
   ```
   :DapContinue
   ```

4. **Select one of:**
   - `Debug cmd/api/main.go` - Start API without args
   - `Debug cmd/api/main.go (with args)` - Start API with args
   - `Debug API with Make (run-local-api)` - Start API with optional args

5. **If prompted for args, enter them:**
   ```
   Args: --port 8080 --env dev
   ```
   (Or leave empty for no args)

6. **API starts and debugger attaches**

7. **Make API requests** to trigger breakpoints

##### Example: Debug API

```go
// cmd/api/main.go
func main() {
    // Set breakpoint here
    server := setupServer()
    server.Start()
}

// internal/handlers/user.go
func CreateUser(w http.ResponseWriter, r *http.Request) {
    // Set breakpoint here
    user := parseRequest(r)
    db.Save(user)
}
```

#### Method 3: Debug Alternative Entry Points

**For projects with different structures:**

Uncomment lines 299-316 in `lua/plugins/dap.lua` and adjust paths:

```lua
-- Uncomment and modify as needed:
table.insert(dap.configurations.go, {
  type = "go",
  name = "Debug cmd/server/main.go",
  request = "launch",
  program = "${workspaceFolder}/cmd/server/main.go",
  cwd = "${workspaceFolder}",
  buildFlags = "",
})
```

---

### Attach Mode (Attach to Running Process)

**When to use:**
- Debugging running services
- Debugging processes started by make/scripts
- Debugging long-running programs

#### Method 1: Attach by Port (Recommended)

##### Steps:

1. **Start delve server manually:**

   **Basic start:**
   ```bash
   cd /path/to/project
   dlv debug --headless --listen=:2345 --api-version=2 ./cmd/api/main.go
   ```

   **With arguments:**
   ```bash
   dlv debug --headless --listen=:2345 --api-version=2 --accept-multiclient \
     ./cmd/api/main.go -- --port 8080 --env dev
   ```

   **Different port:**
   ```bash
   dlv debug --headless --listen=:3010 --api-version=2 ./cmd/api/main.go
   ```

2. **In Neovim, open Go file and set breakpoints**

3. **Start debugging:**
   ```
   :DapContinue
   ```

4. **Select: "Attach to Go Process (Port)"**

5. **Enter port:**
   ```
   Enter delve port: 2345
   ```

6. **Make requests to your API** to hit breakpoints

#### Method 2: Attach to Running Process

##### Steps:

1. **Start your Go program normally:**
   ```bash
   make run-local-api
   # or
   go run ./cmd/api/main.go
   ```

2. **Find the process ID:**
   ```bash
   pgrep -f "api"
   # or
   ps aux | grep api
   ```

3. **Start delve attached to process:**
   ```bash
   dlv attach <PID> --headless --listen=:2345 --api-version=2
   ```

4. **In Neovim:**
   ```
   :DapContinue
   ```

5. **Select: "Attach to Go Process (Port)"**

6. **Enter port: 2345**

#### Optional: Makefile Debug Target

Add to your project's `Makefile` for easier debugging:

```makefile
.PHONY: debug-api
debug-api:
	dlv debug --headless --listen=:2345 --api-version=2 --accept-multiclient \
	  ./cmd/api/main.go

.PHONY: debug-api-with-args
debug-api-with-args:
	dlv debug --headless --listen=:2345 --api-version=2 --accept-multiclient \
	  ./cmd/api/main.go -- --port 8080
```

Then use:
```bash
make debug-api
```

---

### Debugging Go Tests

#### Method 1: Debug Current Test (Automatic)

##### Steps:

1. **Open your test file** (e.g., `user_test.go`)

2. **Place cursor in a test function:**
   ```go
   func TestCreateUser(t *testing.T) {
       // Place cursor anywhere in this function
       user := CreateUser("John")
       assert.Equal(t, "John", user.Name)
   }
   ```

3. **Set breakpoints**

4. **Start debugging:**
   ```
   :DapContinue
   ```

5. **Select: "Debug test"**

6. **dap-go automatically detects the test function** and runs it

#### Method 2: Debug Entire Test Package

##### Steps:

1. **Open any test file in the package**

2. **Set breakpoints**

3. **Start debugging:**
   ```
   :DapContinue
   ```

4. **Select: "Debug test (go.mod)"**

5. **All tests in package run** with debugger attached

#### Example:

```go
// internal/user/user_test.go
func TestUserService(t *testing.T) {
    t.Run("Create user", func(t *testing.T) {
        // Set breakpoint here
        user, err := service.CreateUser("John")
        assert.NoError(t, err)
        assert.Equal(t, "John", user.Name)
    })

    t.Run("Delete user", func(t *testing.T) {
        // Set breakpoint here
        err := service.DeleteUser(123)
        assert.NoError(t, err)
    })
}
```

---

## Troubleshooting

### Node.js Issues

#### "Cannot connect to runtime process"

**Cause:** Server not started with `--inspect` flag

**Solution:**
```bash
# Make sure to add --inspect
pnpm dev -- --inspect=9229
```

#### "EADDRINUSE: address already in use"

**Cause:** Debug port already in use

**Solution:**
```bash
# Use different port
pnpm dev -- --inspect=9230

# Or kill existing process
lsof -ti:9229 | xargs kill -9
```

#### "Breakpoint not hit in TypeScript"

**Cause:** Source maps not generated or incorrect

**Solution:** Check your `tsconfig.json`:
```json
{
  "compilerOptions": {
    "sourceMap": true
  }
}
```

#### "Cannot find module when debugging tests"

**Cause:** Test runner can't resolve paths

**Solution:**
- Ensure test file is in correct directory
- Check `jest.config.js` or `vitest.config.ts` paths
- Verify `node_modules/.bin/jest` or `vitest` exists

---

### Go Issues

#### "could not launch process: exec: \"dlv\": executable file not found"

**Cause:** delve not installed or not in PATH

**Solution:**
```bash
# Check installation
which dlv

# If not found, install via Mason
# In Neovim: :Mason -> Install delve

# Or install manually
go install github.com/go-delve/delve/cmd/dlv@latest
```

#### "API server exited with code -1: could not attach to pid"

**Cause:** Insufficient permissions or process not found

**Solution:**
```bash
# On Linux, may need ptrace permissions
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope

# Or run as root (not recommended)
sudo dlv attach <PID>
```

#### "could not find symbol value for main.main"

**Cause:** Binary compiled without debug symbols

**Solution:**
```bash
# Ensure debug build
go build -gcflags="all=-N -l" ./cmd/api
```

Or in `dap.lua`, add build flags:
```lua
buildFlags = "-gcflags='all=-N -l'",
```

#### "Breakpoint not hit in handler"

**Possible causes:**
1. Code not being executed (check request routing)
2. Optimizations removing debug info
3. Wrong file/line number

**Solution:**
- Verify request reaches handler with logging
- Add `buildFlags = "-gcflags='all=-N -l'"` to config
- Reload Neovim after setting breakpoints

---

### General DAP Issues

#### "No configuration found"

**Cause:** Wrong filetype or no configs for language

**Solution:**
```vim
" Check current filetype
:set filetype?

" Should be: typescript, javascript, go, etc.
" If wrong, set it:
:set filetype=typescript
```

#### "DAP UI doesn't open"

**Cause:** dapui not configured or listeners not set

**Solution:** Check `lua/plugins/dap.lua` has:
```lua
dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
```

#### "Breakpoints show as gray/not verified"

**Cause:** Debugger not attached yet

**Solution:**
- Breakpoints turn red after `:DapContinue`
- If still gray, check debugger connection
- Try `:DapToggleBreakpoint` again

---

## Quick Reference

### Node.js Workflows

**Quick Start (Launch):**
```
1. Set breakpoints
2. :DapContinue
3. Select "Launch pnpm dev"
```

**Quick Start (Attach):**
```
Terminal: pnpm dev -- --inspect=9229
Neovim:
  1. Set breakpoints
  2. :DapContinue
  3. Select "Attach to Node Process (Port)"
  4. Enter: 9229
```

**Debug Tests:**
```
1. Open test file
2. Set breakpoints
3. :DapContinue
4. Select "Debug Jest Tests" or "Debug Vitest Tests"
```

---

### Go Workflows

**Quick Start (Launch):**
```
1. Open cmd/api/main.go
2. Set breakpoints
3. :DapContinue
4. Select "Debug cmd/api/main.go"
```

**Quick Start (Attach):**
```
Terminal: dlv debug --headless --listen=:2345 --api-version=2 ./cmd/api/main.go
Neovim:
  1. Set breakpoints
  2. :DapContinue
  3. Select "Attach to Go Process (Port)"
  4. Enter: 2345
```

**Debug Tests:**
```
1. Open test file
2. Place cursor in test function
3. Set breakpoints
4. :DapContinue
5. Select "Debug test"
```

---

## Additional Resources

- **nvim-dap docs:** https://github.com/mfussenegger/nvim-dap
- **dap-go docs:** https://github.com/leoluz/nvim-dap-go
- **js-debug-adapter:** https://github.com/microsoft/vscode-js-debug
- **delve docs:** https://github.com/go-delve/delve

---

**Last Updated:** 2026-02-03
