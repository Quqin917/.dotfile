return {
  "fladson/vim-kitty",
  ft = "kitty",

  -- enable plugins if its in ~/.config/kitty
  -- enabled = function()
  -- 	return vim.fn.expand("%:p:h"):match("^" .. vim.fn.expand("~") .. "/.config/kitty") ~= nil
  -- end,
}
