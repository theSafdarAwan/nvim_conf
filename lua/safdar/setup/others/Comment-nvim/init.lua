local function plugin(install)
	install({
		"numToStr/Comment.nvim",
		keys = {
			{ mode = "v", "gc" },
			{ "gc" },
			{ mode = "v", "gb" },
			{ "gb" },
		},
		config = function()
			local ok, _ = pcall(require, "Comment")
			if not ok then
				require("safdar.utils").notify("Comment.nvim not found")
				return
			end
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	})
end
return { install = plugin }
