local converter = require('num-utils.converter')
local M = {}

local function get_number_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1

  local function is_number_char(char)
    return char:match("[%dxXoObBaA-fF]") ~= nil
  end

  local start = col
  while start > 1 and is_number_char(line:sub(start - 1, start - 1)) do
    start = start - 1
  end

  local finish = col
  while finish <= #line and is_number_char(line:sub(finish, finish)) do
    finish = finish + 1
  end

  local number_str = line:sub(start, finish - 1)

  if number_str:match("^%d+$") or 
     number_str:match("^0x%x+$") or 
     number_str:match("^0b[01]+$") or 
     number_str:match("^0o[0-7]+$") then
    return number_str, start, finish - 1
  end

  return nil, nil, nil
end

local function replace_number_under_cursor(new_str)
  local line = vim.api.nvim_get_current_line()
  local num_str, start_idx, end_idx = get_number_under_cursor()
  if num_str and new_str and start_idx and end_idx then
    local new_line = line:sub(1, start_idx - 1) .. new_str .. line:sub(end_idx + 1)
    vim.api.nvim_set_current_line(new_line)
  end
end

local function create_conversion_command(name, conversion_func)
  vim.api.nvim_create_user_command(name, function()
    local num_str, _, _ = get_number_under_cursor()
    if num_str then
      local result = conversion_func(num_str)
      if result then
        replace_number_under_cursor(result)
      end
    end
  end, {})
end

M.setup = function(opts)
  create_conversion_command('NumToHex', converter.to_hex)
  create_conversion_command('NumToBinary', converter.to_binary)
  create_conversion_command('NumToOctal', converter.to_octal)
  create_conversion_command('NumToDecimal', converter.to_decimal)
end

return M
