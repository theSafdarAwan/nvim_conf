local function config()
	local ok, tabnine = pcall(require, "cmp_tabnine.config")
	if not ok then
		require("safdar.utils").notify("tabnine not found")
		return
	end
	tabnine:setup({
		max_lines = 1000,
		max_num_results = 20,
		priority = 150,
		sort = true,
		run_on_every_keystroke = true,
		snippet_placeholder = "..",
	})
end
return { config = config }
