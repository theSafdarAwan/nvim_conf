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
			{ name = "nvim_lsp", max_item_count = 15, priority = 1 },
			{ name = "neorg", keyword_length = 2, priority = 1 },
			{
				name = "luasnip",
				keyword_length = 2,
				priority = 2,
			},
			{
				name = "buffer",
				keyword_length = 2,
				priority = 3,
			},
			{ name = "nvim_lsp_signature_help", group_index = 1, priority = 1 },
			{ name = "nvim_lua", keyword_length = 2, priority = 2 },
			{ name = "dictionary", keyword_length = 2, priority = 4, max_item_count = 4 },
			{ name = "emoji", priority = 1 },
			{
				name = "cmp_tabnine",
				keyword_length = 2,
				priority = 2,
				max_item_count = 10,
			},
		},
	})

	local vim = vim
	-- the reason i use file extension rather then file types is that
	-- file types like norg won't have filetype set if the plugin for norg
	-- isn't loaded. Which sets the filetype.
	local ft_extensions = {
		["html"] = "html",
		["norg"] = "norg",
		["md"] = "md",
	}
	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = vim.api.nvim_create_augroup("cmp-dictionary cmp source autocmd", { clear = true }),
		callback = function()
			-- This function will remove the cmp-dictionary from source list of cmp if file
			-- extension is not not listed in the ft_extensions list
			if not ft_extensions[vim.fn.expand("%:e")] then
				local sources = cmp.get_config().sources
				for i = #sources, 1, -1 do
					if sources[i].name == "dictionary" then
						table.remove(sources, i)
						break
					end
				end
				cmp.setup.buffer({ sources = sources })
			end
		end,
	})
end

return { config = config }
