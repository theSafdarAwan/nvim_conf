local function plugin(install)
	install({
		"nvim-neorg/neorg",
		opt = true,
		setup = function()
			local lazy_load = {
				name = "neorg",
				on_load = {
					-- cmd = "Neorg gtd capture",
					config = function()
						require("safdar.setup.writing.neorg.config").config()
					end,
				},
				-- keymap = {
				-- 	keys = { "gtc" },
				-- },
				autocmd = {
					ft_ext = "norg",
				},
			}
			require("lazy-loader").load(lazy_load)
		end,
		run = ":Neorg sync-parsers", -- This is the important bit!
	})
	install({ "nvim-neorg/neorg-telescope", after = "neorg" })
end

return { install = plugin }
