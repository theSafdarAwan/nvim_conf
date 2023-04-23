local function config()
	local icons = require("safdar.setup.ui.icons")
	local theme = {
		fill = "Normal",
		-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
		head = "TabLine",
		group_icon_hl = { fg = "#21273a", bg = "#7aa2f7" },
		current_tab = { fg = "#7aa2f7", bg = "#21273a" },
		tab = "TabLine",
		win = "TabLine",
		tail = "TabLine",
	}
	require("tabby.tabline").set(function(line)
		local vim_icon = {
			{ " " .. icons.misc.Vim .. " ", hl = theme.group_icon_hl },
			line.sep(icons.misc.ColumnBarThin, theme.fill, theme.head),
		}
		local tabs_style = line.tabs().foreach(function(tab)
			local hl = tab.is_current() and theme.current_tab or theme.tab
			local name = tab.name()
			-- remove the windows number info from the name
			local last_idx = string.find(name, "%[")
			if last_idx and last_idx > 1 then
				name = string.sub(name, 1, last_idx - 1)
			end
			return {
				line.sep(icons.misc.ColumnBarThin, theme.fill, hl),
				tab.is_current() and icons.misc.CircleWithDot or icons.misc.Pentagon,
				tab.number(),
				name,
				-- tab.close_btn(""),
				line.sep("", theme.fill, hl),
				hl = hl,
				margin = " ",
			}
		end)
		local empty_space_after_tabs = line.spacer()
		local list_cur_tab_wins = (function()
			local wins = line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
				return {
					line.sep(icons.misc.ColumnBarThin, theme.fill, theme.win),
					win.is_current() and icons.misc.CircleWithDot or icons.misc.HallowCircle,
					win.buf_name(),
					line.sep(icons.misc.ColumnBarThin, theme.fill, theme.win),
					hl = theme.win,
					margin = " ",
				}
			end)
			-- TODO: calculate how many windows can we fit in the current window
			local ui_width = vim.api.nvim_list_uis()[1]
			-- how many widows should we show
			local max_wins = 2
			if #wins >= max_wins then
				local tbl = {}
				for i = 1, max_wins do
					tbl[#tbl + 1] = wins[i]
					if i == max_wins then
						break
					end
				end
				table.insert(tbl, 1, {
					line.sep(icons.misc.ColumnBarThin, theme.fill, theme.win),
					"",
					icons.ui.Plus .. " " .. #wins - max_wins,
					line.sep(icons.misc.ColumnBarThin, theme.fill, theme.win),
					hl = theme.win,
					margin = " ",
				})
				wins = tbl
			end
			return wins
		end)()
		local wins_icon = {
			line.sep("", theme.fill, theme.tail),
			{ " " .. icons.ui.Files .. " ", hl = theme.group_icon_hl },
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
