local colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "mocha"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

-- Integration with other plugins
local catppuccin_status_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status_ok then
	return
end

-- TOKYO NIGHT REFERENCE --
-- local colorscheme = "tokyonight"
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_transparent = false
-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_lualine_bold = true
