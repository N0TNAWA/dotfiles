return {
  'nvimdev/indentmini.nvim',
  enabled = true,
  config = function()
    require("indentmini").setup() -- use default config
  end,
}
