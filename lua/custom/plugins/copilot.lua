return {
    {
      "github/copilot.vim", -- BEGIN: Change plugin source
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        -- Configuration for github/copilot.vim may differ
        vim.g.copilot_no_tab_map = true
        vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<Tab>")', { expr = true, silent = true })
        vim.api.nvim_set_keymap("i", "<M-]>", "<Plug>(copilot-next)", {})
        vim.api.nvim_set_keymap("i", "<M-[>", "<Plug>(copilot-previous)", {})
        vim.api.nvim_set_keymap("i", "<C-]>", "<Plug>(copilot-dismiss)", {})
      end, -- END: Change plugin source
    },
  }