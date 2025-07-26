return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },

  config = function()
    local oil = require("oil")

    -- helper function to parse output
    local function parse_output(proc)
      local result = proc:wait()
      local ret = {}
      if result.code == 0 then
        for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
          -- Remove trailing slash
          line = line:gsub("/$", "")
          ret[line] = true
        end
      end
      return ret
    end

    -- build git status cache
    local function new_git_status()
      return setmetatable({}, {
        __index = function(self, key)
          local ignore_proc = vim.system(
            { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
            {
              cwd = key,
              text = true,
            }
          )
          local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
            cwd = key,
            text = true,
          })
          local ret = {
            ignored = parse_output(ignore_proc),
            tracked = parse_output(tracked_proc),
          }

          rawset(self, key, ret)
          return ret
        end,
      })
    end
    local git_status = new_git_status()

    -- Clear git status cache on refresh
    local refresh = require("oil.actions").refresh
    local orig_refresh = refresh.callback
    refresh.callback = function(...)
      git_status = new_git_status()
      orig_refresh(...)
    end

    oil.setup({
      default_file_explorer = true, -- Make the default file for neovim
      delete_to_trash = true, -- Deletion is moves to trash rather than deleted
      skip_confirm_for_simple_edits = true,
      natural_order = true,

      columns = { "icon" },

      view_options = {
        show_hidden = true,

        is_always_hidden = function(name, _)
          return name == ".."
        end,

        is_hidden_file = function(name, bufnr)
          local dir = oil.get_current_dir(bufnr)
          local is_dotfile = vim.startswith(name, ".") and name ~= ".."

          if not dir then
            return is_dotfile
          end

          if is_dotfile then
            return not git_status[dir].tracked[name]
          else
            return git_status[dir].ignored[name]
          end
        end,
      },

      win_options = {
        wrap = true,
      },

      keymaps = {
        ["gd"] = {
          desc = "Toggle detail view",
          callback = function()
            detail = not detail
            if detail then
              oil.set_columns({ "icon", "permissions", "size", "mtime" })
            else
              oil.set_columns({ "icon" })
            end
          end,
        },
        ["gh"] = {
          desc = "Toogle git tracked hidden files",
          callback = function()
            git_status = new_git_status()
            require("oil").actions.refresh()
          end,
        },
      },

      vim.keymap.set("n", "`", oil.toggle_float, { desc = "Open parent directory" }),
    })
  end,
}
