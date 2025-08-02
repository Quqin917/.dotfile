return {
	{
		"numToStr/Comment.nvim",
		name = "comment.nvim",
		opts = {
			-- Add a space between word and comment
			padding = true,

			-- Toggle mappings in NORMAL mode
			toggler = {
				line = "gcc",
				block = "gbc",
			},

			-- Operator-pending mappings in NORMAL or VISUAL mode
			opleader = {
				line = "gc",
				block = "gb",
			},

			-- Extra mappings
			extra = {
				above = "gcO",
				below = "gco",
				eol = "gcA",
			},

			pre_hook = nil,
			post_hook = nil,
		},
	},
}
