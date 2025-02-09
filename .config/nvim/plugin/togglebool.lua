--[[
local function toggle_bool()
  local word = vim.fn.expand('<cword>')
  local toggle_word

  if word == 'true' then
    toggle_word = 'false'
  elseif word == 'True' then
    toggle_word = 'False'
  elseif word == 'false' then
    toggle_word = 'true'
  elseif word == 'False' then
    toggle_word = 'True'
  else
    return
  end

  local line = vim.fn.getline('.')

  -- 构建匹配模式,确保只匹配完整单词
  local escaped_word = vim.fn.escape(word, '\\') -- 转义特殊字符
  local pattern = '\\<' .. escaped_word .. '\\>'

  -- 使用 matchstrpos 获取匹配的位置
  local match_info = vim.fn.matchstrpos(line, pattern)
  local match_start = match_info[2] -- 0-based 字节索引
  local match_end = match_info[3]   -- 0-based 字节索引

  -- 调整索引以适应 Lua 字符串的 1-based 索引
  local lua_start = match_start + 1
  local lua_end = match_end

  local cursor_col = vim.fn.col('.') - 1
  if cursor_col >= match_start and cursor_col <= match_end then
    -- 构建新的行内容
    local prefix = line:sub(1, lua_start - 1)
    local suffix = line:sub(lua_end + 1)
    local new_line = prefix .. toggle_word .. suffix

    vim.fn.setline('.', new_line)
  end

  local next_start, next_end
  while match_info[1] ~= -1 do
    -- 查找下一个匹配项，注意这里的 match_info[3] 是上次匹配的结束位置
    match_info = vim.fn.matchstrpos(line, pattern, match_info[3] + 1)

    -- 如果找到了下一个匹配项
    if match_info[1] ~= -1 then
      next_start = match_info[2]
      next_end = match_info[3]

      -- 如果光标在当前匹配项范围内，执行替换
      if cursor_col >= next_start and cursor_col <= next_end then
        local prefix = line:sub(1, next_start)
        local suffix = line:sub(next_end + 1)
        local new_line = prefix .. toggle_word .. suffix
        vim.fn.setline('.', new_line)
        break
      end
    else
      -- 如果没有找到匹配项，跳出循环，避免死循环
      break
    end
  end
end

vim.api.nvim_create_user_command('ToggleBool', toggle_bool, {})
]]

local function toggle_bool()
  local word = vim.fn.expand('<cword>')
  local toggle_word

  -- 判断当前单词的翻转结果
  if word == 'true' then
    toggle_word = 'false'
  elseif word == 'True' then
    toggle_word = 'False'
  elseif word == 'false' then
    toggle_word = 'true'
  elseif word == 'False' then
    toggle_word = 'True'
  else
    return
  end

  local line = vim.fn.getline('.')

  -- 构建匹配模式,确保只匹配完整单词
  local escaped_word = vim.fn.escape(word, '\\') -- 转义特殊字符
  local pattern = '\\<' .. escaped_word .. '\\>' -- 单词边界匹配

  -- 使用 matchstrpos 获取匹配的位置
  local match_info = vim.fn.matchstrpos(line, pattern)
  local match_start = match_info[2] -- 0-based 字节索引
  local match_end = match_info[3]   -- 0-based 字节索引

  -- 调整索引以适应 Lua 字符串的 1-based 索引
  local lua_start = match_start + 1
  local lua_end = match_end

  -- 获取光标的当前列
  local cursor_col = vim.fn.col('.') - 1 -- 0-based

  -- 如果光标在当前匹配项范围内，直接替换
  if cursor_col >= match_start and cursor_col <= match_end then
    -- 构建新的行内容
    local prefix = line:sub(1, lua_start - 1)
    local suffix = line:sub(lua_end + 1)
    local new_line = prefix .. toggle_word .. suffix
    vim.fn.setline('.', new_line)
    return
  end

  -- 如果光标不在当前匹配项，尝试查找下一个匹配项
  local found_match = false
  while match_info[1] ~= -1 do
    -- 查找下一个匹配项，注意这里的 match_info[3] 是上次匹配的结束位置
    match_info = vim.fn.matchstrpos(line, pattern, match_info[3] + 1)

    -- 如果找到了下一个匹配项
    if match_info[1] ~= -1 then
      local next_start = match_info[2]
      local next_end = match_info[3]

      -- 如果光标在当前匹配项范围内，执行替换
      if cursor_col >= next_start and cursor_col <= next_end then
        local prefix = line:sub(1, next_start)
        local suffix = line:sub(next_end + 1)
        local new_line = prefix .. toggle_word .. suffix
        vim.fn.setline('.', new_line)
        found_match = true
        break
      end
    else
      -- 没有匹配项时跳出循环，避免死循环
      break
    end
  end

  -- 如果没有找到有效匹配项，什么都不做
  if not found_match then
    return
  end
end

vim.api.nvim_create_user_command('ToggleBool', toggle_bool, {})
