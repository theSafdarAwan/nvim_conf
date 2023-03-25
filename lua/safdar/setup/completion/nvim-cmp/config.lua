local config = function()
	-- luasnip setup
	local border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
	-- local border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" }
	-- local border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	local cmp = require("cmp")

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		completion = {
			keyword_length = 1,
		},
		window = {
			documentation = {
				border = border,
				max_width = 80,
				max_hight = 30,
				winhighlight = "FloatBorder:TelescopeBorder",
			},
			completion = {
				border = border,
				col_offset = 30,
				side_padding = 0,
				winhighlight = "FloatBorder:TelescopeBorder",
			},
		},
		experimental = { ghost_text = true },
		formatting = {
			format = function(entry, vim_item)
				-- load lspkind icons
				local icons = require("safdar.setup.ui.lspkind").icons
				vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

				vim_item.menu = ({
					nvim_lsp = "(LSP)",
					emoji = "(Emoji)",
					path = "(Path)",
					calc = "(Calc)",
					cmp_tabnine = "(Tabnine)",
					vsnip = "(Snippet)",
					luasnip = "(Snippet)",
					buffer = "(Buffer)",
				})[entry.source.name]

				return vim_item
			end,
		},
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-u>"] = cmp.mapping.scroll_docs(-2),
			["<C-d>"] = cmp.mapping.scroll_docs(2),
			-- ["<C-l>"] = cmp.mapping.complete(),
			["<C-x>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
			["<S-Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		},
		sources = { -- different source for the completion
			{
				name = "nvim_lsp",
				max_item_count = 15,
			},
			{
				name = "neorg",
				keyword_length = 2,
			},
			{
				name = "luasnip",
				keyword_length = 2,
			},
			{
				name = "buffer",
				keyword_length = 2,
			},
			{
				name = "nvim_lua",
				keyword_length = 2,
			},
			{
				name = "emoji",
			},
			{
				name = "cmp_tabnine",
				keyword_length = 2,
				max_item_count = 10,
			},
		},
	})

	-- set the source autocmd for the cmp-dictionary source
	require("safdar.setup.completion.nvim-cmp-dictionary.config").dict_source_autocmd()
end

return { config = config }
