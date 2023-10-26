local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local default_cmp_sources = cmp.config.sources({
	{ name = "nvim_lsp_signature_help" },
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{ name = "luasnip" },
	{ name = "buffer" },
	{ name = "path" },
})

local kind_icons = {
	Text = "",
	Method = "",
	Function = "󰊕",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "󰯲",
	Interface = "",
	Module = "󰕳",
	Property = "",
	Unit = "",
	Value = "󱂌",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "󰉺",
}

local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 20
local MIN_LABEL_WIDTH = 20

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	sources = default_cmp_sources,
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
			-- Making a fixed width for the auto-completion
			local label = vim_item.abbr
			local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
			if truncated_label ~= label then
				vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
			elseif string.len(label) < MIN_LABEL_WIDTH then
				local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
				vim_item.abbr = label .. padding
			end

			local lspkind_ok, lspkind = pcall(require, "lspkind")
			if lspkind_ok then
				-- Build structure from lspkind...
				local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 100 })(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })
				kind.kind = " " .. (strings[1] or "") .. " "
				local source_name = ({
					nvim_lsp_signature_help = "[LSP]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					luasnip = "[LuaSnip]",
					buffer = "[Buffer]",
				})[entry.source.name]
				kind.menu = "    (" .. (strings[2] or "") .. ")" .. " " .. source_name
				return kind
			else
				-- fallback...
				vim_item.kind = string.format("%s %s", vim_item.kind, kind_icons[vim_item.kind]) -- This concatonates the icons with the name of the item kind
				vim_item.menu = ({
					nvim_lsp_signature_help = "[LSP]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					luasnip = "[LuaSnip]",
					buffer = "[Buffer]",
				})[entry.source.name]
				return vim_item
			end
		end,
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		-- NOTE: after checking, without border is more beautiful...
		completion = {
			scrollbar = "║",
		},
		documentation = { -- rounded border; thin-style scrollbar
			border = "rounded",
			scrollbar = "║",
		},
	},
	experimental = {
		ghost_text = true,
	},

	-- Disable during writing comment
	enabled = function()
		local context_status_ok, context = pcall(require, "cmp.config.context")
		if not context_status_ok then
			return true -- NOTE: by default, we should always apply auto-completion
		end

		-- Disable vimwiki filetype
		if vim.bo.filetype == "vimwiki" then
			return false
		end

		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,

	-- Open near cursor
	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},
})

-- NOTE: integration with other package => should put it based on priority (lower means lower prio)
-- Autopair on auto-completion...
local cmp_autopair_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Spell suggest
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
