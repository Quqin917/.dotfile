    require"catppuccin".setup{
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true,

      styles = {
        comments = { "italic" },
        loops = { "italic" },
        keywords = { "italic" },
        strings = {},
        variables = {},
      },

      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.overlay0 },
          NeoTreeDotfile = { fg = colors.overlay0 },
          NeoTreeMessage = { fg = colors.surface2 },
          SnacksPickerListCursorLine = { bg = "#223547" },
          SnacksPickerSelected = { fg = colors.lavender },

          Cursor = { bg = "NONE", fg = colors.lavender }, -- No background, lavender foreground for cursor
          CursorLine = { bg = "None", fg = "None" },
        }
      end
    }

vim.cmd.colorscheme "catppuccin"
