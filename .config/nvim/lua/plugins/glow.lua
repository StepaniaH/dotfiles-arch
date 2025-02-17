return {
  {
    "ellisonleao/glow.nvim",
    enabled = true,
    cmd = "Glow",
    config = function()
      require('glow').setup({
        border = "rounded", -- or 'single', 'double', 'shadow', 'none'
        style = "dark",     -- filled automatically with your current editor background, you can override using glow json style
        pager = false,
        width_ratio = 0.7,  -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
        height_ratio = 0.7,
      })
    end
  }
}
