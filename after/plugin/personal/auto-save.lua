local utils = require("safdar.core.utils")
local vim = utils.vim
local api = utils.api
local create_autocmd = api.nvim_create_autocmd
local command = utils.command
local b = utils.bo
local cmd = utils.cmd
local fn = utils.fn
local delay_auto_save = 10

-- create the autosave augroup and Initialization of the autosave_queued and
-- autosave_block variables
local auto_save = api.nvim_create_augroup("autosave", { clear = true })
local auto_save_queued = "autosave_queued"
local auto_save_block = "autosave_block"

api.nvim_create_autocmd("BufRead", {
	group = auto_save,
	callback = function(buf_info)
		api.nvim_buf_set_var(buf_info.buf, auto_save_queued, false)
		api.nvim_buf_set_var(buf_info.buf, auto_save_block, false)
	end,
})

-- validate excluded buftype's and filetype's and dir names from autosaving if
-- included then will return tabl with the type name and the type value
local function validater(opts)
	local ok = true
	local type
	-- dir name validate
	if opts.type == "dir" then
		local path_expanded = vim.fn.expand("%:p")
		local path_split = vim.split(path_expanded, "/", { plain = false, trimempty = true })
		local last_item_idx
		for _, _ in ipairs(path_split) do
			-- table second last element which is the path first is the file name
			last_item_idx = #path_split - 1
		end
		local path = path_split[last_item_idx]
		for _, v in ipairs(opts.data) do
			if v == path then
				ok = false
				break
			else
				ok = true
			end
		end
		type = "dir"
	else
		-- validate buftype and filetype
		local buf_info_type
		if opts.type == "buf" then
			buf_info_type = b.buftype
			type = "buf"
		else
			buf_info_type = b.filetype
			type = "ft"
		end
		for _, value in ipairs(opts.data) do
			if buf_info_type == value then
				ok = false
			end
		end
	end
	return { type = type, value = ok }
end

-- autosave function
local function auto_save_fn(buf_info)
	local ok, queued = pcall(api.nvim_buf_get_var, buf_info.buf, auto_save_queued)
	if not ok then
		return
	end

	if not queued then
		local excluded = {
			dir = { "wezterm", "alacritty" },
			ft = { "TelescopePrompt", "harpoon" },
			buf = { "prompt" },
		}

		local ft_val
		local buf_val
		local dir_val

		for k, v in pairs(excluded) do
			local valid = validater({ type = tostring(k), data = v })
			if type(valid) == "table" then
				if valid.type == "buf" then
					buf_val = valid.value
				elseif valid.type == "dir" then
					dir_val = valid.value
				else
					ft_val = valid.value
				end
			end
		end

		-- check if the buf is modifiable and then validate buf does not have any of
		-- the excluded filetypes or buftypes
		if b.modifiable and ft_val and buf_val and dir_val then
			command("silent update")
			-- print("saved at " .. vim.fn.strftime("%H:%M:%S"))
			api.nvim_buf_set_var(buf_info.buf, auto_save_queued, true)
			fn.timer_start(1500, function()
				cmd("echon ''")
			end)
		end

		local function defer_fn()
			if api.nvim_buf_is_valid(buf_info.buf) then
				api.nvim_buf_set_var(buf_info.buf, auto_save_queued, false)
			end
		end

		vim.defer_fn(defer_fn, delay_auto_save)
		local block = api.nvim_buf_get_var(buf_info.buf, auto_save_block)
		if not block then
			api.nvim_buf_set_var(buf_info.buf, auto_save_block, true)
			local function defer_block_fn()
				-- check if the buffer valid
				-- because buffer may disappear after delay
				if api.nvim_buf_is_valid(buf_info.buf) then
					api.nvim_buf_set_var(buf_info.buf, auto_save_queued, false)
					api.nvim_buf_set_var(buf_info.buf, auto_save_block, false)
				end
			end

			vim.defer_fn(defer_block_fn, delay_auto_save)
		end
	end
end

-- register autocmd to autosave on these events
create_autocmd({ "TextChanged", "ModeChanged", "CursorHold" }, {
	group = auto_save,
	callback = function(buf_info)
		auto_save_fn(buf_info)
	end,
})
