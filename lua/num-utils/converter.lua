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

local function to_decimal_string(str)
  if is_hex(str) then
    return tostring(tonumber(str:sub(3), 16))
  elseif is_binary(str) then
    return tostring(tonumber(str:sub(3), 2))
  elseif is_octal(str) then
    return tostring(tonumber(str:sub(3), 8))
  else
    return str
  end
end

M.to_decimal = function(str)
  return tonumber(to_decimal_string(str))
end

M.to_hex = function(str)
  if is_hex(str) then return str end
  local decimal = tonumber(to_decimal_string(str))
  if not decimal then return nil end
  return string.format("0x%X", decimal)
end

M.to_binary = function(str)
  if is_binary(str) then return str end
  local decimal = tonumber(to_decimal_string(str))
  if not decimal then return nil end
  if decimal == 0 then return "0b0" end
  local binary = ""
  while decimal > 0 do
    binary = tostring(decimal % 2) .. binary
    decimal = math.floor(decimal / 2)
  end
  return "0b" .. binary
end

M.to_octal = function(str)
  if is_octal(str) then return str end
  local decimal = tonumber(to_decimal_string(str))
  if not decimal then return nil end
  return string.format("0o%o", decimal)
end

return M
