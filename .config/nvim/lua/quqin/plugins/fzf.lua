return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	keys = {
		{ "<leader>:", "<CMD>lua require('fzf-lua').command_history()<CR>", desc = "Command History" },
		{ "<leader>fb", "<CMD>lua require('fzf-lua').buffers()<CR>", desc = "Buffers" },
		{ "<leader><leader>", "<CMD>lua require('fzf-lua').files({ case_mode = 'smart' })<CR>", desc = "Find Files" },

		{
			"<leader>ff",
			"<CMD>lua require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h'), case_mode = 'smart' })<CR>",
			desc = "Find Files CWD",
		},
		{
			"<leader>/",
			"<CMD>lua require('fzf-lua').grep({ case_mode = 'smart' })<CR><CR>",
			desc = "Grep CWD",
		},

		{
			"<leader>fn",
			"<CMD>lua require('fzf-lua').grep({ search = '\\v(function\\s+\\w+\\s*\\()', input = 'buffer', case_mode = 'smart' })<CR>",
			desc = "Find Function in Buffer",
		},

		{
			"<leader>fc",
			"<CMD>lua require('fzf-lua').files({ case_mode = 'smart', cwd = '~/.config/nvim/' })<CR>",
			desc = "Find Config Files",
		},
	},

	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
			winopts = {
				fullscreen = true,

				preview = {
					vertical = "down:90%",
				},
			},
		})
	end,
}
