return {
  -- Mason for LSP management
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- Mason LSP config bridge
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'basedpyright',
          -- other LSP servers
        },
      }
    end,
  },

  -- LSP configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local lspconfig = require 'lspconfig'

      -- Basedpyright configuration
      lspconfig.basedpyright.setup {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'standard',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'workspace',
            },
          },
        },
      }
    end,
  },
}
