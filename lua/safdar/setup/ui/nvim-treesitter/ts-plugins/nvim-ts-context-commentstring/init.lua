local function plugin(install)
	install({
		"JoosepAlviste/nvim-ts-context-commentstring",
		keys = "gc",
		config = function()
			-- TODO: work on this type of nodes injected in js

			--[[
			    <div class='${data.className}'>
				    Your favorite color is now ${data.color}
				</div>
			`; ]]

			require("nvim-treesitter.configs").setup(
			{
			--- this gets done automagically now
			-- 	context_commentstring = {
			-- 		enable = true,
			-- 		enable_autocmd = false,
			-- 	},
			}
			)
		end,
	})
end
return { install = plugin }
