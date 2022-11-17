-- ++> Remov default plugins
local utils = require("safdar.core.utils")
local g = utils.g
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
-- <++

require("safdar")
require("_packer")

-- TODO:
-- create folder for each plugin and put their config and maps in it rather then
-- having a config and plugins_mappings folder

-- TODO:
-- create a popup wrapper for the harpoon.term like the toggle term does
