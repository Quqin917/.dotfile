return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",

		{ "antosha417/nvim-lsp-file-operations" },
		{ "folke/neodev.nvim", opts = {} },
	},

	opts = { inlay_hints = { enabled = true } },

	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		-- Default capabilities (including completion capabilities)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Setup LSP servers via mason-lspconfig
		mason_lspconfig.setup({
			handlers = {
				-- Default handler for all installed servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Custom config for clangd
				["clangd"] = function()
					lspconfig.clangd.setup({
						capabilities = capabilities,
						cmd = { "clangd", "--icons", "--clang-format-style=file" },
					})
				end,
			},
		})

		-- LSP navigation keymaps using fzf-lua
		vim.keymap.set(
			"n",
			"gd",
			"<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>",
			{ desc = "Goto Definition" }
		)
		vim.keymap.set(
			"n",
			"gr",
			"<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<cr>",
			{ desc = "References" }
		)
		vim.keymap.set(
			"n",
			"gI",
			"<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
			{ desc = "Goto Implementation" }
		)
		vim.keymap.set(
			"n",
			"gy",
			"<cmd>FzfLua lsp_typedefs jump1=true ignore_current_line=true<cr>",
			{ desc = "Goto Type Definition" }
		)
	end,
}
