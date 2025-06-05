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
