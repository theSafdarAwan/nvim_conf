local set_map = require("safdar.utils").set_map

local api = vim.api
local fn = vim.fn

-- replace the default nvim map gm for rather the half of the screen to half of
-- the current line text
set_map({ "n", "v" }, "gm", function()
	local cur_line = #api.nvim_get_current_line()
	local middle = math.floor(cur_line / 2)
	local position = api.nvim_win_get_cursor(0)[2]

	if position == middle then
		return
	end

	local key = "l"
	local move
	if position > middle then
		key = "h"
		move = position - middle
	elseif position < middle then
		move = middle - position
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

-- to remember the last pattern and the command when using the ; and , command
vim._previous_find_info = { pattern = nil, key = nil }

-- how many characters to find for
vim.quick_movement_find_chars_length = 2

local function reverse_tbl(tbl)
	local transformed_tbl = {}
	local idx = #tbl
	while true do
		table.insert(transformed_tbl, tbl[idx])
		if idx < 1 then
			break
		end
		idx = idx - 1
	end
	return transformed_tbl
end

-- maps the occurrences of the pattern in a string
local function string_map(str, pattern)
	local loc_tbl = {}
	local last_position
	local idx = loc_tbl[#loc_tbl] or 1
	while true do
		last_position = string.find(str, pattern, idx, true)
		if idx == last_position or not last_position then
			break
		end
		table.insert(loc_tbl, last_position)
		idx = loc_tbl[#loc_tbl] + 2
	end
	return loc_tbl
end

local function get_position(pattern, direction)
	local cursor_position = api.nvim_win_get_cursor(0)[2]
	local cur_line = api.nvim_get_current_line()
	local all_occurrences = string_map(cur_line, pattern)

	local target_position
	if direction == "l" then
		for key, val in ipairs(all_occurrences) do
			if val > cursor_position then
				target_position = val
				-- if the cursor is already on one occurrence then move to the next one
				if cursor_position == val - 1 then
					target_position = all_occurrences[key + 1]
				end
				break
			end
		end
	elseif direction == "h" then
		all_occurrences = reverse_tbl(all_occurrences)
		for key, val in ipairs(all_occurrences) do
			if val < cursor_position then
				target_position = val
				-- if the cursor is already on one occurrence then move to the previous one
				if cursor_position == val + 1 then
					target_position = all_occurrences[key - 1]
				end
				break
			end
		end
	end

	return { target_position = target_position, cursor_position = cursor_position }
end

local function get_chars()
	local chars = ""
	while true do
		local c = fn.getchar(0)
		chars = chars .. fn.nr2char(c)
		if #chars == vim.quick_movement_find_chars_length then
			break
		end
	end
	return chars
end

local function notify(chars_pattern)
	api.nvim_notify(chars_pattern .. " pattern not found", vim.log.levels.WARN, {})
end

local function move_to_char_position(key)
	local previous_find_info = vim._previous_find_info
	-- if no find command was executed previously then there's no last pattern for
	-- , or ; so return
	if not previous_find_info.pattern and key == "," or key == ";" and not previous_find_info.pattern then
		return
	end

	-- to determine which direction to go
	local direction_l = key == "f"
		or previous_find_info.key == "F" and key == ","
		or previous_find_info.key == "f" and key == ";"
	local direction_h = key == "F"
		or previous_find_info.key == "f" and key == ","
		or previous_find_info.key == "F" and key == ";"

	local direction
	if direction_h then
		direction = "h"
	elseif direction_l then
		direction = "l"
	else
		notify(previous_find_info.pattern)
		return
	end

	local chars_pattern
	if key == "f" or key == "F" then
		-- if find command is executed then add the pattern and the key to the
		-- vim._previous_find_info table.
		chars_pattern = get_chars()
		previous_find_info.key = key
		previous_find_info.pattern = chars_pattern
	else
		-- if f or F command wasn't pressed then search for the vim._previous_find_info.pattern
		-- for , or ; command
		chars_pattern = previous_find_info.pattern
	end
	local position = get_position(chars_pattern, direction)

	if not position.target_position then
		notify(chars_pattern)
		return
	end

	-- to determine how much away the target position is
	local target_distance
	if direction_l then
		target_distance = position.target_position - position.cursor_position - 1
	elseif direction_h then
		target_distance = position.cursor_position - position.target_position + 1
	end

	fn.feedkeys(target_distance)
	api.nvim_feedkeys(direction, "m", true)
end

local find_keys_tbl = {
	"f",
	"F",
	";",
	",",
}

for _, key in ipairs(find_keys_tbl) do
	set_map({ "n", "v" }, key, function()
		move_to_char_position(key)
	end)
end
