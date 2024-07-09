local M = {}

M.to_hex = function(num)
  return string.format("0x%X", num)
end

M.to_binary = function(num)
  local binary = ""
  local n = num
  while n > 0 do
    binary = tostring(n % 2) .. binary
    n = math.floor(n / 2)
  end
  return "0b" .. (binary ~= "" and binary or "0")
end

M.to_octal = function(num)
  return string.format("0o%o", num)
end

return M
