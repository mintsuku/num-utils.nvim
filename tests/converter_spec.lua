local converter = require("num-utils.converter")

describe("num-utils converter", function()
  it("converts decimal to hex", function()
    assert(converter.to_hex(10) == "0xA", "Expected 0xA, got " .. converter.to_hex(10))
    assert(converter.to_hex(255) == "0xFF", "Expected 0xFF, got " .. converter.to_hex(255))
  end)

  it("converts decimal to binary", function()
    assert(converter.to_binary(10) == "0b1010", "Expected 0b1010, got " .. converter.to_binary(10))
    assert(converter.to_binary(255) == "0b11111111", "Expected 0b11111111, got " .. converter.to_binary(255))
  end)

  it("converts decimal to octal", function()
    assert(converter.to_octal(10) == "0o12", "Expected 0o12, got " .. converter.to_octal(10))
    assert(converter.to_octal(255) == "0o377", "Expected 0o377, got " .. converter.to_octal(255))
  end)
end)
