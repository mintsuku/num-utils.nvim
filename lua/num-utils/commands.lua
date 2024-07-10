local converter = require('num-utils.converter')
local M = {}

local function get_number_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  
  local start_idx = col
  while start_idx > 0 and line:sub(start_idx, start_idx):match("[%dxXoObB]") do
    start_idx = start_idx - 1
  end
  start_idx = start_idx + 1
  
  local end_idx = col
  while end_idx <= #line and line:sub(end_idx, end_idx):match("[%dxXoObB]") do
    end_idx = end_idx + 1
  end
  end_idx = end_idx - 1
  
  local num_str = line:sub(start_idx, end_idx)
  print("Debug: Number found - " .. num_str)  -- Debug print
  return num_str, start_idx, end_idx
end

local function replace_number_under_cursor(new_str)
  local line = vim.api.nvim_get_current_line()
  local num_str, start_idx, end_idx = get_number_under_cursor()
  if num_str and new_str then
    local new_line = line:sub(1, start_idx - 1) .. new_str .. line:sub(end_idx + 1)
    vim.api.nvim_set_current_line(new_line)
    print("Debug: Replaced " .. num_str .. " with " .. new_str)  -- Debug print
  else
    print("Invalid number or conversion")
  end
end

local function create_conversion_command(name, conversion_func)
  vim.api.nvim_create_user_command(name, function()
    local num_str = get_number_under_cursor()
    if num_str then
      local result = conversion_func(num_str)
      print("Debug: Conversion result - " .. tostring(result))  -- Debug print
      if result then
        replace_number_under_cursor(result)
      else
        print("Conversion failed")
      end
    else
      print("No valid number found under cursor")
    end
  end, {})
end

M.setup = function(opts)
  create_conversion_command('NumToHex', converter.to_hex)
  create_conversion_command('NumToBinary', converter.to_binary)
  create_conversion_command('NumToOctal', converter.to_octal)
  create_conversion_command('NumToDecimal', converter.to_decimal)

  print("All commands created")
end

return M
