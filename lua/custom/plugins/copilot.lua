return {
  -- GitHub Copilot main plugin
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- recommended if using copilot-cmp
        panel = { enabled = false },
      })
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "zbirenbaum/copilot.lua",
    },
    opts = {
      window = {
        layout = "float",
        relative = "editor",
        width = 0.6,
        height = 0.6,
      },
    },
    keys = {
      { "<leader>cc", function() require("CopilotChat").toggle() end, desc = "Copilot Chat" },
      { "<leader>cq", function() require("CopilotChat").quick() end,  desc = "Quick Chat" },
      { "<leader>cr", function() require("CopilotChat").reset() end,  desc = "Reset Chat" },
    },
  },
}
