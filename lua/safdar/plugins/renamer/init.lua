local status_ok, renamer = pcall(require, "renamer")
if not status_ok then
	vim.notify("renamer not found")
	return
end

renamer.setup({})
require("safdar.plugins.renamer.maps")
