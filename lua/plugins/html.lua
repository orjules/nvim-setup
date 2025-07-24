-- ~/.config/nvim/lua/plugins/html.lua
return {
  -- Treesitter for syntax highlighting and more
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",  -- Ensures you have the latest version of parsers
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "html", "css", "javascript", "typescript" },  -- Install these parsers
        highlight = {
          enable = true, -- Enable highlighting for HTML, CSS, JS, etc.
        },
      }
    end,
  },

  -- Auto-close and rename HTML tags
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter" },
    config = function()
      require('nvim-ts-autotag').setup() -- Directly call the setup function
    end,
  },

  -- Emmet for fast HTML and CSS autocompletion
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" }
  }
}


