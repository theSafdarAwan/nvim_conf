local function config()
	local icons = require("safdar.setup.ui.icons")
	local theme = {
		fill = "Normal",
		-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
		head = "TabLine",
		current_tab = "TabLineSel",
		tab = "TabLine",
		win = "TabLine",
		tail = "TabLine",
	}
	require("tabby.tabline").set(function(line)
		local vim_icon = {
			{ " " .. icons.misc.Vim .. " ", hl = theme.head },
			line.sep(icons.status_line.triangle.acute.left, theme.head, theme.fill),
		}
		local tabs_style = line.tabs().foreach(function(tab)
			local hl = tab.is_current() and theme.current_tab or theme.tab
			-- remove the windows number info from the name
			local name = tab.name()
			local last_idx = string.find(name, "%[")
			if last_idx and last_idx > 1 then
				name = string.sub(name, 1, last_idx - 1)
			end
			return {
				line.sep(icons.status_line.triangle.acute.right, hl, theme.fill),
				tab.is_current() and "" or "",
				tab.number(),
				name,
				-- tab.close_btn(""),
				line.sep(icons.status_line.triangle.acute.left, hl, theme.fill),
				hl = hl,
				margin = " ",
			}
		end)
		local empty_space_after_tabs = line.spacer()
		local list_cur_tab_wins = line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			return {
				line.sep(icons.status_line.triangle.acute.right, theme.win, theme.fill),
				win.is_current() and icons.misc.CircleWithDot or icons.misc.HallowCircle,
				win.buf_name(),
				line.sep(icons.status_line.triangle.acute.left, theme.win, theme.fill),
				hl = theme.win,
				margin = " ",
			}
		end)
		local wins_icon = {
			line.sep(icons.status_line.triangle.acute.right, theme.tail, theme.fill),
			{ "  ", hl = theme.tail },
		}

		return {
			vim_icon,
			tabs_style,
			empty_space_after_tabs,
			list_cur_tab_wins,
			wins_icon,
			hl = theme.fill,
		}
	end)
end

return { config = config }
