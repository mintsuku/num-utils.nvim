local converter = require('num-utils.converter')

local M = {}

local function get_number_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local num_str = line:match("%d+", col + 1)
  return tonumber(num_str)
end

local function replace_number_under_cursor(new_str)
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local start_idx, end_idx = line:find("%d+", col + 1)
  if start_idx and end_idx then
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
