return {
  "saifulapm/commasemi.nvim",
  event = "VeryLazy",
  keys = {
    { ",,", "<cmd>SemiToggle<cr>", mode = { "n", "x" }, desc = "Toggle semicolon" },
    { ",", "<cmd>CommaToggle<cr>", mode = { "n", "x" }, desc = "Toggle comma" },
  },
  opts = {
    keymaps = false,
    commands = true,
  },
}
