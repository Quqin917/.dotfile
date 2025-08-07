return {
	"goolord/alpha-nvim",
	event = "VimEnter",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local fortune = require("alpha.fortune")

		local ascii = require("quqin.plugins.art.ascii")

		-- set header
		local current_ascii = ascii.get()

		dashboard.section.header.val = current_ascii
		dashboard.section.header.opts = {
			position = "center",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "  > Find file", ":lua require('fzf-lua').files({ file_icons = true })<CR>"),
			dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
		}

		dashboard.section.footer.val = fortune() or "Hello!"

		local uv = vim.uv or vim.loop
		local timer = uv.new_timer()

		timer:start(1250, 1250, function()
			vim.schedule(function()
				local ok, ft = pcall(vim.api.nvim_get_option_value, "filetype", { buf = 0 })
				if not ok or ft ~= "alpha" then
					timer:stop()
					timer:close()
					return
				end

				if ascii and type(ascii.next) == "function" then
					local next_ascii = ascii.next()
					if next_ascii then
						if current_ascii ~= next_ascii then
							dashboard.section.header.val = next_ascii
							pcall(vim.cmd.AlphaRedraw)
							current_ascii = next_ascii
						end
					end
				end
			end)
		end)

		alpha.setup(dashboard.config)

		-- Redraw on VimResize to re-center the ASCII art
		vim.cmd([[
      autocmd VimResized * lua require'alpha'.redraw()
    ]])

		vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])
	end,
}
