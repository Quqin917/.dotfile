local map = vim.keymap.set

-- Better navigation for Up and Down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move window using ctrl
map("n", "<C-h>", "<C-w>h", { desc = "Left Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Right Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Down Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Up Window", remap = true })

-- Better lazy and mason menu
map({ "n", "i", "v" }, "<C-i>", "<CMD> Lazy <CR>")

-- Better quit and save file mapping
map({ "n", "i", "v" }, "<C-s>", "<CMD> w<CR>")
map({ "n", "i", "v" }, "<A-s>", "<CMD> wq<CR>")
map("n", "<leader>q", "<CMD> q<CR>", { desc = "Quit" })

map({ "n", "i", "v" }, "<A-p>", "<CMD> NoNeckPain <CR>")
