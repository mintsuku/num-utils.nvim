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

M.to_hex = function(num)
  if type(num) == "string" and is_hex(num) then return num end
  local decimal = M.to_decimal(num)
  if not decimal then return nil end
  return string.format("0x%X", decimal)
end

M.to_binary = function(num)
  if type(num) == "string" and is_binary(num) then return num end
  local n = M.to_decimal(num)
  if not n then return nil end
  local binary = ""
  if n == 0 then return "0b0" end
  while n > 0 do
    binary = tostring(n % 2) .. binary
    n = math.floor(n / 2)
  end
  return "0b" .. binary
end

M.to_octal = function(num)
  if type(num) == "string" and is_octal(num) then return num end
  local decimal = M.to_decimal(num)
  if not decimal then return nil end
  return string.format("0o%o", decimal)
end

return M
