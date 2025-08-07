return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,

    --@type CatppuccinOptions
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true,

      styles = {
        comments = { "italic" },
        loops = { "italic" },
        keywords = { "italic" },
        strings = {},
        variables = {},
      },

      integrations = {
        cmp = true,
        treesitter = true,
        flash = true,
        snacks = {
          enabled = true,
          indent_scope_color = "lavender",
        },
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        mason = true,
        fzf = true,
        alpha = true,
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
      end,
    },
  },
}
