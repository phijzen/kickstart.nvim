vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { noremap = true, silent = true, buffer = event.buf }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

    vim.api.nvim_set_keymap('n', '<leader>td', ':lua require("neotest").run.run({ strategy = "dap" })<CR>', { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<leader>tr', ':lua require("neotest").run.run()<CR>', { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<leader>tn', ':lua require("neotest").summary.toggle()<CR>', { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<leader>tp', ':lua require("neotest").output.open()<CR>', { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<leader>tP', ':lua require("neotest").output_panel.toggle()<CR>', { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<leader>tl', ':lua require("neotest").run.run_last()<CR>', { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<leader>tf', ':lua require("neotest").run.run({ suite = vim.fn.expand("%:p") })', { noremap = true, silent = true })
  end,
})

return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      local versify = require 'versify'
      local config_path = versify.find_project_versify_config(vim.api.nvim_get_current_buf())

      local lsps = {
        {
          'basedpyright',
          {
            capabilities = capabilities,
            settings = {
              basedpyright = {
                analysis = {
                  diagnosticMode = 'workspace',
                  typeCheckingMode = 'strict',
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  autoImportCompletions = true,
                  diagnosticSeverityOverrides = {
                    reportMissingTypeStubs = 'none',
                    reportUnknownParameterType = 'none',
                  },
                },
              },
            },
          },
        },
        {
          'ruff',
          {
            init_options = {
              settings = {
                configuration = config_path,
                lint = {
                  extendSelect = { 'ANN201' },
                  ignore = { 'D100', 'D103', 'T201' },
                },
              },
            },
          },
        },
      }

      for _, lsp in pairs(lsps) do
        local name, config = lsp[1], lsp[2]
        if config then
          vim.lsp.config(name, config)
        end
        vim.lsp.enable(name)
      end
    end,
  },
}
