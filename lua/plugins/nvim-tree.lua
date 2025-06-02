vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File Explorer" })

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      local mappings = {
        ["l"] = { api.node.open.edit, opts "Open" },
        ["o"] = { api.node.open.edit, opts "Open" },
        ["<CR>"] = { api.node.open.edit, opts "Open" },
        ["v"] = { api.node.open.vertical, opts "Open: Vertical Split" },
        ["h"] = { api.node.navigate.parent_close, opts "Close Directory" },
        ["C"] = { api.tree.change_root_to_node, opts "CD" },
      }

      for key, value in pairs(mappings) do
        vim.keymap.set("n", key, value[1], value[2])
      end
    end

    require("nvim-tree").setup({
      on_attach = on_attach,
      sort = {
        sorter = "name",
        folders_first = true,
      },
      view = {
        width = 40,
        side = "left",
      },
      renderer = {
        group_empty = false,
        highlight_git = "name",
        highlight_opened_files = "none",
        root_folder_label = ":~:s?$?/..?",
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          show = {
            git = false,
          }
        }
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", "\\.cache" },
      },
      git = {
        enable = true,
        show_on_dirs = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
        },
        open_file = {
          quit_on_open = false,
          window_picker = {
            enable = true,
          },
        },
      },
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
          vim.cmd "quit"
        end
      end
    })
  end,
}
