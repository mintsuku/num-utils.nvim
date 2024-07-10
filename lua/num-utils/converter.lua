local M = {}

local function is_hex(str)
  return str:match("^0x%x+$") ~= nil
end

local function is_binary(str)
  return str:match("^0b[01]+$") ~= nil
end

local function is_octal(str)
  return str:match("^0o[0-7]+$") ~= nil
end

M.to_decimal = function(str)
  if is_hex(str) then
    return tonumber(str:sub(3), 16)
  elseif is_binary(str) then
    return tonumber(str:sub(3), 2)
  elseif is_octal(str) then
    return tonumber(str:sub(3), 8)
  else
    return tonumber(str)
  end
end

M.to_hex = function(str)
  local num = M.to_decimal(str)
  if num then
    return string.format("0x%X", num)
  end
  return nil
end

M.to_binary = function(str)
  local num = M.to_decimal(str)
  if not num then return nil end
  if num == 0 then return "0b0" end
  local binary = ""
  while num > 0 do
    binary = tostring(num % 2) .. binary
    num = math.floor(num / 2)
  end
  return "0b" .. binary
end

M.to_octal = function(str)
  local num = M.to_decimal(str)
  if num then
    return string.format("0o%o", num)
  end
  return nil
end

return M
