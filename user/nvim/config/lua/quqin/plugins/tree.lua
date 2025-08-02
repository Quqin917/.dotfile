-- local parser_install_dir = vim.fn_stdpath("cache") .. "/treesitter"
-- vim.fn.mkdir(parser_install_dir, "p")
-- vim.opt.runtimepath:append(parser_install_dir)

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",

	opts = {
		auto_install = false,
		ensure_installed = {},

		highlight = {
			enabled = true,

			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
	},
}
