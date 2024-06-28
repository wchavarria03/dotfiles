local M = {}
local merge_tb = vim.tbl_deep_extend

M.mapKey = function(context, mode, lhs, rhs, opts)
  local local_desc = { desc = (context or 'General') .. ': ' .. (opts.desc or '_XXX_') }

  vim.keymap.set(mode, lhs, rhs, merge_tb('force', opts, local_desc))
end

return M
