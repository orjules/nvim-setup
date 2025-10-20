return {
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
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
      vim.lsp.config('clangd', {
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
        },
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })
      
      -- Python
      vim.lsp.config('pylsp', {
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
      
      -- Alternative Python LSP (uncomment if you prefer pyright)
      -- vim.lsp.config('pyright', {
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      -- })
      
      -- CMake
      vim.lsp.config('cmake', {
        capabilities = capabilities,
        on_attach = on_attach,
      })
      
      -- XML (for launch files)
      vim.lsp.config('lemminx', {
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
      
      -- YAML (for ROS2 config files)
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
            },
          },
        },
      })
      
      -- Rust
      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = true,
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
          'yamlls',      -- YAML (optional)
          'rust_analyzer', -- Rust
        },
        automatic_installation = true,
      })
    end,
  },
}
