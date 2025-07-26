return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local lualine = require("lualine")

    local customTheme = require("lualine.themes.nightfly")
    customTheme.normal.c.bg = "None"

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = customTheme,
      },
    })
  end,
}
