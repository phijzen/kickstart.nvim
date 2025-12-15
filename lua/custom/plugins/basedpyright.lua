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
        handlers = {
          function(server_name)
            vim.lsp.config(server_name, {})
          end,
          basedpyright = function()
            vim.lsp.config.basedpyright = {
              cmd = { 'basedpyright-langserver', '--stdio' },
              root_markers = { 'pyproject.toml', 'setup.py', '.git' },
              filetypes = { 'python' },
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
            vim.lsp.enable 'basedpyright'
          end,
        },
      }

      -- Set up LSP keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.definition, {
            buffer = bufnr,
            desc = 'Go to definition',
          })
        end,
      })
    end,
  },
}
