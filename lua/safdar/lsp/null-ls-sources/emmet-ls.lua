local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local COMPLETION = methods.internal.COMPLETION

h.make_builtin({
    name = "emmet_ls",
    meta = {
        description = "Emmet Plugin From VSCode",
        notes = {
            "This source will provide Emmet completion",
        },
    },
    method = COMPLETION,
    generator_opts = {
        command = "emmet-ls",
        args = {"--stdio"},
        to_stdin = true,
    },
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    generator = {
        fn = function(params, done)
            local get_candidates = function(entries)
                local items = {}
                for k, v in ipairs(entries) do
                    items[k] = { label = v, kind = vim.lsp.protocol.CompletionItemKind["Emmet"] }
                end

                return items
            end

            local candidates = get_candidates(vim.fn.spellsuggest(params.word_to_complete))
            done({ { items = candidates, isIncomplete = #candidates > 0 } })
        end,
        async = true,
    },
})

local query = {
    name = "emmet_ls", -- string
    method = require("null-ls").methods.FORMATTING, -- null-ls method
}
print(require("null-ls").is_registered(query))
