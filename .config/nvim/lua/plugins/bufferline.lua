return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local bufferline = require('bufferline')
      bufferline.setup({
        highlights = {
          buffer_selected = { italic = true, bold = true },
        },
        options = {
          mode = "buffers",
          style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
        }
      })
    end
  }
}
