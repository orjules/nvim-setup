return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {}, -- This will call require("which-key").setup({})
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
