return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local wk = require("which-key")

		wk.setup({
			plugins = {
				marks = true,
				registers = true,
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			win = {
				no_overlap = false, -- Adjust if necessary
				border = "single", -- Optional: Add borders for visual appeal
			},
			icons = {
				mappings = true,
				colors = true, -- This enables colorized icons
			},
			layout = {
				spacing = 2, -- Adjust spacing for a more open look
				align = "center", -- Optional: Align the content for visual balance
			},
		})

		local function create_goto_keymap(number)
			return {
				"<leader>" .. number,
				function()
					require("bufferline").go_to(number, true)
				end,
				desc = function()
					local lazy = require("bufferline.lazy")
					local state = lazy.require("bufferline.state")
					local element = state.components[number]
					return element and ("Go to " .. element.name) or "Go to -"
				end,
			}
		end

		wk.add({
			{
				create_goto_keymap(1),
				create_goto_keymap(2),
				create_goto_keymap(3),
				create_goto_keymap(4),
				create_goto_keymap(5),
			},
			{ prefix = "<leader>" },
		})
	end,

	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Show Help Keybind",
		},
	},
}
