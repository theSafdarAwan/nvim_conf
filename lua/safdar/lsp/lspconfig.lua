local utils = require("safdar.core.utils")
local vim = utils.vim
local lsp_util = require("safdar.lsp.lsp_util")
local on_attach = lsp_util.on_attach
local capabilities = lsp_util.capabilities
-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
    if msg:match("exit code") then
        return
    end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({ { msg } }, true, {})
    end
end

--|||||||||||||||||||||||||||||||||||||||||||||||||||||||
--                      lsp general
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||
local nvim_lsp = require("lspconfig")

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- enable lang_servers with same configs alll in one
local servers = {
    --love
    "cssls",
    "tailwindcss",
    "tsserver",
    "emmet_ls",

    -- crush
    -- "clangd",
    "sumneko_lua",
    "vimls",

    -- fun
    "rust_analyzer",
    "gopls",
    "bashls",
    "pyright",
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        autostart = true,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

--=======================================================
--     require lang modules with additional configs
--=======================================================
local langsConfs = {
    "sumneko-lua_lsp",
    "jsonls_lsp",
    "c_lsp",
    "html_lsp",
    "stylelint-lsp_lsp",
}
for _, file in ipairs(langsConfs) do
    require("safdar.lsp.langs." .. file)
end

-- to change the ui
require("safdar.lsp.lsp-ui")

-- add the mappings
require("safdar.plugins.configs.plugins_mappings.lsp_map")
