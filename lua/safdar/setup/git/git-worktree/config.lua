local function config()
	local ok, git_worktree = pcall(require, "git-worktree")
	if not ok then
		require("safdar.utils").notify("git-worktree not found")
		return
	end
	git_worktree.setup({
		change_directory_command = "cd", -- default: "cd",
		update_on_change = true, -- default: true,
		update_on_change_command = "e .", -- default: "e .",
		clearjumps_on_change = true, -- default: true,
		autopush = false, -- default: false,
	})
	require("safdar.setup.navigation.telescope.telescope-plugins").git_worktree()
end

return { config = config }
