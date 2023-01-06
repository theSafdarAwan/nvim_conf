local function plugin(install)
	install({
		"nvim-neorg/neorg",
		opt = true,
		setup = function()
			local lazy_load = {
				name = "neorg",
				on_load = {
					-- cmd = "Neorg gtd capture",
				},
				cmds = {
					"Neorg*",
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
		-- NOTE: at the moment cant do the commands when lazy loading
		-- plugin with lazy-loader.
		-- run = ":Neorg sync-parsers", -- This is the important bit!
		config = function()
			require("safdar.setup.writing.neorg.config").config()
		end,
	})
	install({ "nvim-neorg/neorg-telescope", after = "neorg" })
end

return { install = plugin }
