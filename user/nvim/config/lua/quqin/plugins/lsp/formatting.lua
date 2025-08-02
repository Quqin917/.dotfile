return {
  "stevearc/conform.nvim",
  --  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local conform = require("conform")

    -- Setup conform.nvim with formatters by filetype
    conform.setup({
      formatters_by_ft = {
        C = { "clang-format" },
        lua = { "stylua" },
      },

      -- Formatting options
      format_after_save = {
        lsp_fallback = true, -- LSP-based formatting fallback
        async = true, -- Asynchronous formatting
        timeout_ms = 500, -- Timeout setting
      },

      -- Keymap to format the file with the specified settings
      vim.keymap.set({ "n", "v" }, "<leader>bf", function()
        conform.format({
          lsp_fallback = true, -- Use LSP fallback if available
          async = false, -- Synchronous formatting on demand
          timeout_ms = 500, -- Timeout setting
        })
      end, { desc = "Format file" }),
    })
  end,
}
