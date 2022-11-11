local lspconf = require("lspconfig")
local util = require("lspconfig.util")
lspconf.stylelint_lsp.setup({
    filetypes = {
        "css",
        "less",
        "scss",
        -- "sugarss",
        -- "vue",
        -- "wxss",
        -- "javascript",
        -- "javascriptreact",
        -- "typescript",
        -- "typescriptreact",
    },
    root_dir = util.root_pattern(".stylelintrc.json", "package.json"),
})
