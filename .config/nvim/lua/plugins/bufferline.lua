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
          themable = true,
          numbers = 'ordinal',
          close_command = "bdelete! %d",
          right_mouse_command = false,
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          buffer_close_icon = '󰅖',
          modified_icon = '● ',
          close_icon = ' ',
          left_trunc_marker = ' ',
          right_trunc_marker = ' ',
        }
      })
    end
  }
}
