local vim = vim
local map = require("safdar.core.utils").map
local opts = { noremap = true, silent = true }

function StopAndStartLspServer()
    vim.api.nvim_command(":LspStop<CR>")
    vim.api.nvim_command(":LspStart<CR>")
end

map("n", "<leader>lR", ":lua StopAndStartLspServer()<CR>", opts)
map("n", "<leader>lr", ":LspRestart<cr>", opts)
map("n", "<leader>li", ":LspInfo<cr>", opts)
map("n", "<leader>nf", "", { noremap = true, silent = true })

local M = {}
local function on_attach()
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    map(
        "n",
        "<space>wa",
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        opts
    )
    map(
        "n",
        "<space>wr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        opts
    )
    map(
        "n",
        "<space>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        opts
    )
    map(
        "n",
        "<space>D",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        opts
    )
    map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    map(
        "n",
        "<space>ca",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        opts
    )
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    map(
        "n",
        "<space>e",
        "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
        opts
    )
    map(
        "n",
        "[d",
        "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
        opts
    )
    map(
        "n",
        "]d",
        "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
        opts
    )
    map(
        "n",
        "<space>q",
        "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
        opts
    )
    map(
        "n",
        "<space>nf",
        "<cmd>lua vim.lsp.buf.format({async = true})<CR>",
        opts
    )
    map(
        "v",
        "nf",
        "<cmd>lua vim.lsp.buf.range_code_action()<CR>",
        opts
    )
end

M.on_attach = on_attach
return M
