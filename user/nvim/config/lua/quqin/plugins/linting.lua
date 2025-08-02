return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local lint = require("lint")

		-- Linters by filetype
		lint.linters_by_ft = {
			c = { "cpplint" },
			lua = { "luacheck" },
		}

		-- Optional: explicitly define the cmd path (only needed if not in $PATH)
		lint.linters.luacheck.cmd = "luacheck"
		lint.linters.cpplint.cmd = "cpplint"

		-- Properly merged arguments
		lint.linters.luacheck.args = {
			"--globals",
			"vim",
			"--globals",
			"LazyVim",
		}

		lint.linters.cpplint.args = {
			"--filter=build/include_subdir",
			"--filter=whitespace/parens",
			"--filter=whitespace/braces",
			"--filter=whitespace/comments",
		}

		-- Auto-trigger linting
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Manual trigger
		vim.keymap.set("n", "<leader>fl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
