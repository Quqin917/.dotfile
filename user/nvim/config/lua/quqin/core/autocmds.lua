local autocmd = vim.api.nvim_create_autocmd

-- restore cursor position
autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("Restore-Position", {}),
	pattern = "*",
	callback = function(args)
		local row = vim.api.nvim_buf_get_mark(args.buf, '"')[1]

		if row > 0 and row <= vim.api.nvim_buf_line_count(args.buf) then
			vim.api.nvim_feedkeys([[g`"]], "nx", false)
		end
	end,
})

autocmd({ "BufReadPost", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("Stay Centered", {}),
	callback = function(args)
		local ft = vim.bo.filetype
		if ft ~= "NvimTree" and ft ~= "toggleterm" then
			vim.cmd("normal! zz")
		end
	end,
})

autocmd("VimEnter", {
	command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
	command = ":silent !kitty @ set-spacing padding=20 margin=10",
})

-- Remove search highlight
autocmd("CmdlineLeave", {
	pattern = { "/", "?", ":" },
	callback = function(_)
		vim.cmd("set hlsearch!")
	end,
})
