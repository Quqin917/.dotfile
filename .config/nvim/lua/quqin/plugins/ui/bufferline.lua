local buffers_offsets = {
  { filetype = "neo-tree", text = "Files", separator = true },
  { filetype = "spectre_panel", text = "Search & Replace", separator = true },
  { filetype = "git", text = "Git", separator = true },
  { filetype = "fugitive", text = "Git", separator = true },
  { filetype = "Outline", text = "Outline", separator = true },
}

local buffers_keys = {
  { "<leader>bl", false },
  { "<leader>br", false },
  { "<leader>bd", "<cmd>bd<cr>", desc = "Close Current Buffers" },
  { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
  {
    "<leader>ba",
    function()
      require("bufferline").close_others()
      require("mini.bufremove").delete(0, false)
    end,
    desc = "Close All Buffers",
  },
  { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffers to the Left" },
  { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffers to the Right" },
  { "<leader>b<", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Forward" },
  { "<leader>b>", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffers Backward" },
}

local function create_buffer_highlights(colors)
  return {
    background = { fg = colors.bg }, -- Cyberdream's background color
    tab_selected = { fg = colors.yellow }, -- Example for tab selection
    buffer_selected = { fg = colors.purple }, -- Example for selected buffer
    numbers_selected = { fg = colors.cyan }, -- Example for selected numbers
    numbers = { fg = colors.white }, -- Regular number color
    trunc_marker = { fg = colors.red }, -- Example for truncation marker
    diagnostic = { fg = colors.blue }, -- Example diagnostic color
    info = { fg = colors.cyan }, -- Info color (typically cyan or blue)
    hint = { fg = colors.green }, -- Hint color
    warning = { fg = colors.orange }, -- Warning color
    error = { fg = colors.red }, -- Error color
  }
end

local buffer_options = {
  mode = "buffers",
  indicator = { style = "none" },
  max_name_length = 48,

  buffer_close_icon = "󰅖 ",
  close_icon = " ", -- Customize the close icon (this uses the 'Font Awesome' icon)
  left_trunc_marker = "󰜱", -- Left truncation marker (you can customize this)
  right_trunc_marker = "󰜴", -- Right truncation marker (you can customize this)

  show_buffer_close_icons = false,
  show_close_icon = true,

  always_show_bufferline = true,

  hover = {
    enabled = true,
    delay = 200,
    reveal = { "close" },
  },

  diagnostics = "nvim_lsp",
  diagnostics_indicator = function(_, _, diag)
    local icons = require("lazyvim.config").icons.diagnostics
    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
      .. (diag.warning and icons.Warn .. diag.warning or "")
    return vim.trim(ret)
  end,

  numbers = function(opts) return opts.ordinal end,

  offsets = buffers_offsets,
}

return {
  "akinsho/bufferline.nvim",
  event = { "BufRead", "BufNewFile" },
  version = "*",
  dependencies = {
    --"nvim-tree/nvim-web-devicons",
    "echasnovski/mini.bufremove",
  },

  keys = buffers_keys,

  config = function()
    local bufferline = require "bufferline"

    bufferline.setup {
      options = {
        buffer_options,

        style_preset = {
          bufferline.style_preset.minimal,
          bufferline.style_preset.no_italic,
        },
      },

      highlights = create_buffer_highlights(require "catppuccin"),
    }
  end,
}
