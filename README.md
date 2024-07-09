# num-utils.nvim


A lightweight Neovim plugin for quick number conversions between decimal, hexadecimal, binary, and octal formats.

## Features

- Convert numbers between decimal, hexadecimal, binary, and octal formats
- Works on numbers under the cursor
- Supports conversion of numbers already in different formats

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "mintsuku/num-utils.nvim",
  config = function()
    require("num-utils").setup()
  end
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "mintsuku/num-utils.nvim",
  config = function()
    require("num-utils").setup()
  end
}
```

## Usage

Place your cursor on a number and use one of the following commands:

- `:NumToHex` - Convert to hexadecimal
- `:NumToBinary` - Convert to binary
- `:NumToOctal` - Convert to octal
- `:NumToDecimal` - Convert to decimal

### Recommended Keybindings

Add these to your Neovim configuration for quick access:

```lua
vim.keymap.set("n", "<leader>nh", ":NumToHex<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>nb", ":NumToBinary<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>no", ":NumToOctal<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>nd", ":NumToDecimal<CR>", {noremap = true, silent = true})
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## TODO

- [ ] Add support for floating-point numbers
- [ ] Implement visual mode selection for converting multiple numbers at once
- [ ] Add configuration options for output format (e.g., uppercase/lowercase for hex)
- [ ] Create a popup menu for selecting conversion type
- [ ] Add support for custom number bases
- [ ] Implement undo/redo functionality for conversions

## License

**MIT**
