return {
	"rmagatti/auto-session",
	lazy = false,
	init = function()
		vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end,

	keys = {
		{ "<leader>sa", "<CMD>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
		{ "<leader>ss", "<CMD>SessionSave<CR>", desc = "[S]ave [S]ession" },
		{
			"<leader>sf",
			"<CMD>Autosession search<CR>",
			desc = "[S]essions [F]ind",
		},
		{
			"<leader>sd",
			"<CMD>Autosession delete<CR>",
			desc = "[S]earch [D]elete",
		},
	},

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		bypass_session_save_file_types = {
			"",
			"no-neck-pain",
			"neo-tree",
			"noice",
			"notify",
			"fugitive",
			"neotest-summary",
		},
	},
}
