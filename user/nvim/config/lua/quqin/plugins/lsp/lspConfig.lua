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

    lspconfig.lua_ls.setup {
      runtime = {
        path = vim.split(package.path, ';'),
      },
      Diagnostic = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }

		-- Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

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
