return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local lint = require("lint")

		-- Define linters by filetype
		lint.linters_by_ft = {
			c = { "cpplint" },
			lua = { "luacheck" },
		}

		-- Use Mason-installed versions if not in PATH
		lint.linters.luacheck.cmd = vim.fn.stdpath("data") .. "/mason/bin/luacheck"
		lint.linters.cpplint.cmd = vim.fn.stdpath("data") .. "/mason/bin/cpplint"

		-- Directly tell luacheck that this "variable" is a global variable
		lint.linters.luacheck.args = { "--globals", "vim" }
		lint.linters.luacheck.args = { "--globals", "LazyVim" }

		-- Add the filter option to disable the 'build/include_subdir' warning in cpplint
		lint.linters.cpplint.args = { "--filter=build/include_subdir" }

		lint.linters.cpplint.args = { "--filter=whitespace/parens" }
		lint.linters.cpplint.args = { "--filter=whitespace/braces" }
		lint.linters.cpplint.args = { "--filter=whitespace/comments" }

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
