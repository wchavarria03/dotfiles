local M = {}
local merge_tb = vim.tbl_deep_extend

M.mapKey = function(context, mode, lhs, rhs, opts)
	local local_desc = { desc = (context or 'General') .. ': ' .. (opts.desc or '_XXX_') }

	vim.keymap.set(mode, lhs, rhs, merge_tb('force', opts, local_desc))
end

M.fun = function(t)
	local f = t[1]
	local args = { unpack(t, 2) }
	return function()
		return f(unpack(args))
	end
end

M.fn = function(f, ...)
	local args = { ... }
	return function(...)
		return f(unpack(args), ...)
	end
end

return M
