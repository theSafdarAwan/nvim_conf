local maps = function()
	local set_map = require("safdar.utils").set_map
	set_map("n", "<leader>mm", ":Mason<CR>")
end

local mason_maps = function()
	return {
		-- Keymap to expand a package
		toggle_package_expand = "<TAB>",
		-- Keymap to install the package under the current cursor position
		install_package = "I",
		-- Keymap to reinstall/update the package under the current cursor position
		update_package = "u",
		-- Keymap to check for new version for the package under the current cursor position
		check_package_version = "c",
		-- Keymap to update all installed packages
		update_all_packages = "U",
		-- Keymap to check which installed packages are outdated
		check_outdated_packages = "C",
		-- Keymap to uninstall a package
		uninstall_package = "X",
		-- Keymap to cancel a package installation
		cancel_installation = "<C-c>",
		-- Keymap to apply language filter
		apply_language_filter = "<C-f>",
	}
end

return { mason_maps = mason_maps, maps = maps }
