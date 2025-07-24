return {
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      
      -- Add cmp capabilities to LSP
      local capabilities = cmp_nvim_lsp.default_capabilities()
      
      -- Common on_attach function for all LSPs
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }
        
        -- LSP keybindings
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end
      
      -- C++ (clangd)
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })
      
      -- Python
      lspconfig.pylsp.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = {'W391'},
                maxLineLength = 100,
              },
              pylint = { enabled = false },
              flake8 = { enabled = false },
            },
          },
        },
      })
      
      -- Alternative Python LSP (often better, uncomment if you prefer)
      -- lspconfig.pyright.setup({
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      -- })
      
      -- CMake
      lspconfig.cmake.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      
      -- XML (for launch files)
      lspconfig.lemminx.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          xml = {
            server = {
              workDir = "~/.cache/lemminx",
            },
          },
        },
      })
      
    end,
  },
  
  -- Mason for easy LSP server management
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = function()
      require('mason').setup()
    end,
  },
  
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'clangd',      -- C++
          'pylsp',       -- Python (or 'pyright')
          'cmake',       -- CMake
          'lemminx',     -- XML
        },
        automatic_installation = true,
      })
    end,
  },
}
