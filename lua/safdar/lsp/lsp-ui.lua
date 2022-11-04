local utils = require("safdar.core.utils")
local vim = utils.vim
local signs = {
    Error = " ",
    Warn = " ",
    Hint = "",
    Info = " ",
    other = " ",
}

for sign, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. sign
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = "",
            spacing = 0,
        },
        signs = true,
        underline = true,
        update_in_insert = true, -- update diagnostics insert mode
    })
--     ["bold"] = {
--       {"┏", highlight},
--       {"─", highlight},
--       {"┓", highlight},
--       {"│", highlight},
--       {"┛", highlight},
--       {"─", highlight},
--       {"┗", highlight},
--       {"│", highlight}

--       { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },

--       { "╭", "highlight" },
--       { "─", "highlight" },
--       { "╮", "highlight" },
--       { "│", "highlight" },
--       { "╯", "highlight" },
--       { "─", "highlight" },
--       { "╰", "highlight" },
--       { "│", "highlight" },
local border = {
    { "┌", "highlight" },
    { "─", "highlight" },
    { "┐", "highlight" },
    { "│", "highlight" },
    { "┘", "highlight" },
    { "─", "highlight" },
    { "└", "highlight" },
    { "│", "highlight" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = border,
})
-- vim.lsp.handlers["textDocument/signatureHelp"] =
vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
})
