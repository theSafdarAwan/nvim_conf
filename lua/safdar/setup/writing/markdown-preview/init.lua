local function plugin(install)
	install({
		"iamcco/markdown-preview.nvim",
		opt = true,
		setup = function()
			local md_preview = {
				name = "markdown-preview.nvim",
				on_load = {
					reload_buffer = true,
					config = function()
						require("safdar.setup.writing.markdown-preview.config").config()
					end,
				},
				autocmd = {
					ft = "markdown",
					keymap = {
						keys = { "<leader>mp" },
					},
				},
			}
			require("lazy-loader").load(md_preview)
		end,
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
end

return { install = plugin }
