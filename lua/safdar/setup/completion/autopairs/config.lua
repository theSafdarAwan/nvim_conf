local config = function()
	local status_ok, npairs = pcall(require, "nvim-autopairs")
	if not status_ok then
		vim.notify("nvim-autopairs not found")
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

	local cmp = require("cmp")
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
