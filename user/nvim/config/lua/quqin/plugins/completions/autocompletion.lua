return {
  -- Completion framework
  {

    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source
      "hrsh7th/cmp-buffer", -- Buffer source
      "hrsh7th/cmp-path", -- Path source
      "saadparwaiz1/cmp_luasnip", -- Snippet source

      "onsails/lspkind.nvim",

      {
        "L3MON4D3/LuaSnip",
        name = "luasnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },

      "rafamadriz/friendly-snippets",
      -- "folke/lazydev.nvim", -- LazyDev for Lua
    },

    config = function()
      local cmp = require "cmp"
      local lspkind = require "lspkind"

      -- Setup nvim-cmp
      cmp.setup {
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },

        window = {
          -- Completion window appearance
          completion = cmp.config.window.bordered {
            border = "rounded", -- Set the border to rounded corners
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
          },

          -- Documentation window appearance
          documentation = cmp.config.window.bordered {
            border = "rounded", -- Rounded borders for documentation
            winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpBorder", -- Highlight the documentation window
          },
        },

        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format { mode = "symbol_text", maxwidth = 50 }(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
          end,
        },

        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
          ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll docs down
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, -- Select next item with Ctrl + n
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }, -- Select previous item with Ctrl + p
          ["<M-Space>"] = cmp.mapping.complete(), -- Trigger completion manually with Alt + Space
          ["<C-e>"] = cmp.mapping.abort(), -- Abort/close completion menu
          ["<S-CR>"] = cmp.mapping.confirm { select = true }, -- Confirm selection with Shift + Enter
          ["<CR>"] = cmp.mapping.confirm { select = true }, -- Confirm selection with Enter
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          -- { name = "lazydev", group_index = 0 }, -- LazyDev source for Lua
        }, {
          { name = "buffer" },
        }),

        experimental = {
          ghost_text = true, -- Optional: Disable ghost text if you prefer a cleaner look
        },
      }
    end,
  },
}
