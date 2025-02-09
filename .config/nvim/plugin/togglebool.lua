local function toggle_bool()
  local word = vim.fn.expand("<cword>")
  local toggle_word

  if word == "true" then
    toggle_word = "false"
  elseif word == "True" then
    toggle_word = "False"
  elseif word == "false" then
    toggle_word = "true"
  elseif word == "False" then
    toggle_word = "True"
  else
    return
  end

  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.fn.getline('.')

  local word_start = vim.fn.searchpos(word, 'bcn', cursor_row)[2]
  local word_end = vim.fn.searchpos(word, 'cen', cursor_row)[2]

  if cursor_col >= word_start and cursor_col <= word_end then
    local prefix = line:sub(1, word_start - 1)
    local suffix = line:sub(word_end + 1)
    local new_line = prefix .. toggle_word .. suffix
    vim.fn.setline('.', new_line)
  end
end

vim.api.nvim_create_user_command("ToggleBool", toggle_bool, {})
