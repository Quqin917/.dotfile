opt = vim.o

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.softtabstop = 2
opt.expandtab = true -- expand tab to spaces

opt.background = "dark"
opt.winborder = "rounded"
vim.opt.clipboard:append "unnamedplus"

opt.swapfile = false

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

vim.opt.runtimepath:append( vim.fn.stdpath("config") .. "/lua")

require 'mappings'

vim.pack.add({
  "https://github.com/catppuccin/nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
 	"https://github.com/neovim/nvim-lspconfig",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/folke/which-key.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
})

require "themes.catppuccin"

local ts = { "lua", "c", "cpp", }
require"nvim-treesitter".install = ts

local lspServer = { "lua_ls", "clangd" }
vim.lsp.enable( lspServer )

require"nvim-treesitter".setup {
  highlight = { enable = true },
}

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(_)
    require"nvim-treesitter".update()
  end,
})

require"treesitter-context".setup {
  max_lines = 3,
  multiline_threshold = 1,
  seperator = "-",
  min_window_height = 20,
  line_numbers = true,
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local filetype = args.match
    local language = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(language) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end
  end,
})

require"oil".setup({})
vim.keymap.set("n", "`", require"oil".toggle_float, { desc = "Open parent directory" })

vim.cmd(":hi statusline guibg=NONE")
