-----------------------------------------------------------
-- Aerial (tag viewer) configuration file
---------------------------------------------------------

-- Plugin: aerial
-- url: https://github.com/stevearc/aerial.nvim

local status_ok, aerial = pcall(require, "aerial")
if not status_ok then
	return
end

aerial.setup({
	ignore = {
		-- List of filetypes to ignore.
		filetypes = {
			"markdown",
		},
	},
})
