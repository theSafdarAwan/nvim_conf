local g = vim.g

g.mkdp_refresh_slow = 1
g.mkdp_browser = "firefox"
g.mkdp_echo_preview_url = 1
g.mkdp_filetypes = { "markdown" }

require("safdar.plugins.markdown-preview.maps")
