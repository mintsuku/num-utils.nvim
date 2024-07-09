local M = {}

if vim.g.loaded_num_utils then
  return M
end
vim.g.loaded_num_utils = true

M.setup = function(opts)
  require('num-utils.commands').setup(opts)
end

return M
