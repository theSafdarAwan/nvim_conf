local config = function()
	local autopairs_status, npairs = pcall(require, "nvim-autopairs")
	if not autopairs_status then
		require("safdar.utils").notify("nvim-autopairs not installed")
		return
	end

	local cmp_status, cmp = pcall(require, "cmp")
	if not cmp_status then
		require("safdar.utils").notify("cmp not installed")
		return
	end

	npairs.setup({
		check_ts = true,
		map_c_w = true,
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", "\"", "'" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,%;] ]], "%s+", ""),
			end_key = "l",
			offset = -2,
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "Search",
			highlight_grey = "Comment",
		},
		disable_filetype = { "TelescopePrompt", "vim" },
		enable_check_bracket_line = false,
		-- ignored_next_char = "[%w%.]",
	})

	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	local rule = require("nvim-autopairs.rule")
	local cond = require("nvim-autopairs.conds")
	npairs.add_rules({
		----------------------------------------------------------------------
		--                  Add spaces between parentheses                  --
		--                         (|) space ( | )                          --
		--                           ( | ) ) ( )|                           --
		----------------------------------------------------------------------
		rule(" ", " "):with_pair(function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return vim.tbl_contains({ "()", "[]", "{}" }, pair)
		end),
		rule("( ", " )")
			:with_pair(function()
				return false
			end)
			:with_move(function(opts)
				return opts.prev_char:match(".%)") ~= nil
			end)
			:use_key(")"),
		rule("{ ", " }")
			:with_pair(function()
				return false
			end)
			:with_move(function(opts)
				return opts.prev_char:match(".%}") ~= nil
			end)
			:use_key("}"),
		rule("[ ", " ]")
			:with_pair(function()
				return false
			end)
			:with_move(function(opts)
				return opts.prev_char:match(".%]") ~= nil
			end)
			:use_key("]"),
	})
end

return { config = config }
