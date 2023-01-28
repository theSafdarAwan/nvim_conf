local set_map = require("safdar.utils").set_map

vim._last_find_tbl = { pattern = nil, key = nil }

local api = vim.api
local fn = vim.fn

-- replace the default nvim map gm for rather the half of the screen to half of
-- the current line text
set_map({ "n", "v" }, "gm", function()
	local cur_line = #api.nvim_get_current_line()
	local middle = math.floor(cur_line / 2)
	local pos = api.nvim_win_get_cursor(0)[2]

	if pos == middle then
		return
	end

	local key = "l"
	local move
	if pos > middle then
		key = "h"
		move = pos - middle
	elseif pos < middle then
		move = middle - pos
	end

	if not move then
		return
	end

	fn.feedkeys(move)
	api.nvim_feedkeys(key, "m", true)
end)

----------------------------------------------------------------------
--        replace find command to find two characters rather        --
--                             then one                             --
----------------------------------------------------------------------

local function string_map(str, pattern)
	local loc_tbl = {}
	local last_pos
	local idx = loc_tbl[#loc_tbl] or 1
	while true do
		last_pos = string.find(str, pattern, idx, true)
		if idx == last_pos or not last_pos then
			break
		end
		table.insert(loc_tbl, last_pos)
		idx = loc_tbl[#loc_tbl] + 2
	end
	return loc_tbl
end

local function get_pos(pattern, direction)
	local cursor_pos = api.nvim_win_get_cursor(0)[2]
	local cur_line = api.nvim_get_current_line()
	local all_indicies = string_map(cur_line, pattern)

	local target_pos
	if direction == "h" then
		for key, val in ipairs(all_indicies) do
			if val > cursor_pos then
				target_pos = all_indicies[key - 1] or all_indicies[key]
				break
			end
		end
	elseif direction == "l" then
		for key, val in ipairs(all_indicies) do
			if val > cursor_pos then
				target_pos = val
				-- if the cursor is already on one occurrence then move to the next one
				if cursor_pos == val - 1 then
					target_pos = all_indicies[key + 1]
				end
				break
			end
		end
	end
	return { target_pos = target_pos or nil, cursor_pos = cursor_pos }
end

local function get_chars()
	local chars = ""
	while true do
		local c = fn.getchar(0)
		chars = chars .. fn.nr2char(c)
		if #chars > 1 then
			break
		end
	end
	return chars
end

local function move_to_char_pos(key)
	local last_find_tbl = vim._last_find_tbl
	if not last_find_tbl.pattern and key == "," or key == ";" and not last_find_tbl.pattern then
		return
	end

	local direction
	if key == "f" or last_find_tbl.key == "F" and key == "," then
		direction = "l"
	else
		direction = "h"
	end

	local chars_pattern
	if key == "f" or key == "F" then
		chars_pattern = get_chars()
		last_find_tbl.key = key
		last_find_tbl.pattern = chars_pattern
	else
		chars_pattern = vim._last_find_tbl.pattern
	end
	local pos = get_pos(chars_pattern, direction)

	if not pos.target_pos then
		require("safdar.utils").notify(chars_pattern .. " pattern not found")
		return
	end

	local go_to_pos
	if key == "f" or last_find_tbl.key == "F" and key == "," then
		go_to_pos = pos.target_pos - pos.cursor_pos - 1
	else
		go_to_pos = pos.cursor_pos - pos.target_pos + 1
	end

	if go_to_pos < 1 then
		return
	end

	fn.feedkeys(go_to_pos)
	api.nvim_feedkeys(direction, "m", true)
end

local find_keys_tbl = {
	"f",
	"F",
	",",
	";",
}

-- TODO: map the whole string with indices of pattern and then get position for
-- the target
-- or maybe use regular expression like match till the next punctuation and then use
-- that as the target_pos

for _, key in ipairs(find_keys_tbl) do
	set_map("n", key, function()
		move_to_char_pos(key)
	end)
end
