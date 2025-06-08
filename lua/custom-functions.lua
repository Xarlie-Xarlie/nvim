-- Custom QuickFix Toggle
function QuickFixToggle()
  local quickfix_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      quickfix_open = true
      break
    end
  end
  if quickfix_open then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end

-- Custom Live Grep
function CustomLiveGrep()
  local include_glob = vim.fn.input("Include Glob (e.g., '*.ex* *.lock*'): ")
  local exclude_glob = vim.fn.input("Exclude Glob (e.g., '*.exs* *.tmp*'): ")
  local glob_pattern = {}

  for pattern in include_glob:gmatch("%S+") do
    table.insert(glob_pattern, pattern)
  end

  for pattern in exclude_glob:gmatch("%S+") do
    table.insert(glob_pattern, "!" .. pattern)
  end
  print("Glob Pattern: " .. vim.inspect(glob_pattern))

  require("telescope.builtin").live_grep({ glob_pattern = glob_pattern })
end

-- Custom LazyGit Toggle
function CustomLazyGitToggle()
  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = vim.o.columns,
      height = vim.o.lines,
    },
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  })
  lazygit:toggle()
end

-- Quick Chat with Copilot
function CustomQuickChat()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, {
      selection = require("CopilotChat.select").buffer
    })
  end
end

-- Custom Generate Pull Request
function CustomGeneratePullRequest()
  local commit_count = vim.fn.input("Number of commits to include: ")

  local pull_request_prompt = [[
Please generate a pull request description, in pt-br, based on the changes made in the code.
Use the pull request template structure.
Summarize the commits to create a comprehensive PR description.

In the section '### Principais pontos a serem revisados', mark everygthing with an x.
]]

  if commit_count ~= "" then
    require("CopilotChat").ask(pull_request_prompt,
      {
        context = {
          string.format(
            "system:`git log --stat --patch -n %s`",
            commit_count
          ),
          "file:`.github/pull_request_template.md`" },
      }
    )
  else
    print("Number of commits are required.")
  end
end
