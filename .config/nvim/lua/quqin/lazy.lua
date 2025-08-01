-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup {
  spec = {
    -- Parent directory
    { import = "quqin.themes" },
    { import = "quqin.plugins" },

    -- Child directory from parent
    { import = "quqin.plugins.lsp" },
    { import = "quqin.plugins.ui" },
    { import = "quqin.plugins.completions" },
  },

  -- Generated lazy-lock.json at the
  lockfile = vim.fn.expand "~/.dotfile/.config/nvim" .. "/lazy-lock.json",

  checker = {
    enabled = true,
    notify = false,
  },

  change_detection = {
    notify = true,
  },
}
