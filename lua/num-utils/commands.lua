local converter = require('num-utils.converter')
local M = {}

local function get_number_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  
  -- Search backwards
  local start_idx = col
  while start_idx > 0 and line:sub(start_idx, start_idx):match("%d") do
    start_idx = start_idx - 1
  end
  start_idx = start_idx + 1
  
  -- Search forwards
  local end_idx = col + 1
  while end_idx <= #line and line:sub(end_idx, end_idx):match("%d") do
    end_idx = end_idx + 1
  end
  end_idx = end_idx - 1
  
  -- Extract the number
  local num_str = line:sub(start_idx, end_idx)
  return tonumber(num_str), start_idx, end_idx
end

local function replace_number_under_cursor(new_str)
  local line = vim.api.nvim_get_current_line()
  local num, start_idx, end_idx = get_number_under_cursor()
  if num then
    local new_line = line:sub(1, start_idx - 1) .. new_str .. line:sub(end_idx + 1)
    vim.api.nvim_set_current_line(new_line)
  end
end

M.setup = function(opts)
  vim.api.nvim_create_user_command('NumToHex', function()
    local num = get_number_under_cursor()
    if num then
      replace_number_under_cursor(converter.to_hex(num))
    end
  end, {})

  vim.api.nvim_create_user_command('NumToBinary', function()
    local num = get_number_under_cursor()
    if num then
      replace_number_under_cursor(converter.to_binary(num))
    end
  end, {})

  vim.api.nvim_create_user_command('NumToOctal', function()
    local num = get_number_under_cursor()
    if num then
      replace_number_under_cursor(converter.to_octal(num))
    end
  end, {})

  print("All commands created")
end

return M
