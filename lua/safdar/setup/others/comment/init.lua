local function plugin(install)
	install({
		"numToStr/Comment.nvim",
		keys = {
			{ "v", "gc" },
			{ "n", "gc" },
			{ "v", "gb" },
			{ "n", "gb" },
		},
		config = function()
			local ok, _ = pcall(require, "Comment")
			if not ok then
				require("safdar.utils").notify("Comment.nvim not found")
				return
			end
			require("Comment").setup()
		end,
	})
end
return { install = plugin }
