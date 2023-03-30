local api = vim.api
local bo = vim.bo
local create_autocmd = api.nvim_create_autocmd
local cmd = vim.api.nvim_command

local delay_auto_save = 10

-- create the autosave augroup and Initialization of the autosave_queued and
-- autosave_block variables
local auto_save = api.nvim_create_augroup("autosave", { clear = true })
local auto_save_queued = "autosave_queued"
local auto_save_block = "autosave_block"

api.nvim_create_autocmd("BufReadPre", {
	group = auto_save,
	callback = function(buf_info)
		api.nvim_buf_set_var(buf_info.buf, auto_save_queued, false)
		api.nvim_buf_set_var(buf_info.buf, auto_save_block, false)
	end,
})

--- validates if current the buftype, filetype or dir name is the ignored.
---@param opts table
---@field opts.data table of type to check for ignoring either, buf or file types or dir name.
---@field opts.type string type of the opts.data.
local function validater(opts)
	local status = true
	if not opts.type then
		vim.notify("auto-save: no type provided to validate", vim.log.levels.WARN, {})
		return
	end
	if opts.type.dir then
		local path_expanded = vim.fn.expand("%:p")
		local path_split = vim.split(path_expanded, "/", { plain = false, trimempty = true })
		local path = path_split[#path_split - 1]
		for _, v in ipairs(opts.data) do
			if v == path then
				status = false
				break
			else
				status = true
			end
		end
	end

	if opts.type.buf then
		for _, value in ipairs(opts.data) do
			if bo.buftype == value then
				status = false
			end
		end
	end

	if opts.type.ft then
		for _, value in ipairs(opts.data) do
			if bo.filetype == value then
				status = false
			end
		end
	end

	return status
end

-- autosave function
local function auto_save_fn(buf_info)
	local ok, queued = pcall(api.nvim_buf_get_var, buf_info.buf, auto_save_queued)
	if not ok then
		return
	end

	if #api.nvim_buf_get_name(0) < 1 then
		return
	end

	if not queued then
		local excluded = {
			dir = { "wezterm", "alacritty" },
			ft = { "TelescopePrompt", "harpoon" },
			buf = { "prompt" },
		}

		local status = true
		for k, v in pairs(excluded) do
			local valid = validater({ type = { [k] = true }, data = v })
			if not valid then
				status = false
				break
			end
		end

		if bo.modifiable and status then
			cmd("silent write")
			-- print("saved at " .. vim.fn.strftime("%I:%M:%S"))
			api.nvim_buf_set_var(buf_info.buf, auto_save_queued, true)
			-- fn.timer_start(1500, function()
			-- 	cmd("echon ''")
			-- end)
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
				-- check if buffers is still valid
				if api.nvim_buf_is_valid(buf_info.buf) then
					api.nvim_buf_set_var(buf_info.buf, auto_save_queued, false)
					api.nvim_buf_set_var(buf_info.buf, auto_save_block, false)
				end
			end

			vim.defer_fn(defer_block_fn, delay_auto_save)
		end
	end
end

-- save changes on these events
create_autocmd({ "CursorMoved", "ModeChanged", "CursorHold" }, {
	group = auto_save,
	callback = function(buf_info)
		auto_save_fn(buf_info)
	end,
})
