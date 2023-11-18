local function text_format(symbol)
	local fragments = {}

	if symbol.references then
		local usage = symbol.references <= 1 and "usage" or "usages"
		local num = symbol.references == 0 and "no" or symbol.references
		table.insert(fragments, ("%s %s"):format(num, usage))
	end

	if symbol.definition then
		table.insert(fragments, symbol.definition .. " defs")
	end

	if symbol.implementation then
		table.insert(fragments, symbol.implementation .. " impls")
	end

	return table.concat(fragments, ", ")
end

local status_ok, symbol_usage = pcall(require, "symbol-usage")
if not status_ok then
	return
end

symbol_usage.setup({
	text_format = text_format,
})
