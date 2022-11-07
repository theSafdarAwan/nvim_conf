-- luasnip setup
local luasnip = require("luasnip")
local border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
-- local border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" }
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    completion = {
        keyword_length = 1,
    },
    window = {
        documentation = {
            border = border,
            max_width = 80,
            max_hight = 30,
            winhighlight = "FloatBorder:TelescopeBorder",
        },
        completion = {
            border = border,
            col_offset = 30,
            side_padding = 0,
            winhighlight = "FloatBorder:TelescopeBorder",
        },
    },
    experimental = { ghost_text = true },
    formatting = {
        format = function(entry, vim_item)
            -- load lspkind icons
            local icons = require("safdar.plugins.configs.lspkind").icons
            vim_item.kind =
                string.format("%s %s", icons[vim_item.kind], vim_item.kind)

            vim_item.menu = ({
                nvim_lsp = "(LSP)",
                emoji = "(Emoji)",
                path = "(Path)",
                calc = "(Calc)",
                cmp_tabnine = "(Tabnine)",
                vsnip = "(Snippet)",
                luasnip = "(Snippet)",
                buffer = "(Buffer)",
            })[entry.source.name]

            return vim_item
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-2),
        ["<C-d>"] = cmp.mapping.scroll_docs(2),
        ["<C-l>"] = cmp.mapping.complete(),
        ["<C-x>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = { -- different source for the completion
        { name = "nvim_lsp" },
        { name = "neorg" },
        {
            name = "luasnip",
            keyword_length = 2,
        },
        {
            name = "buffer",
            keyword_length = 3,
        },
        { name = "nvim_lua" },
        { name = "dictionary" },
        { name = "emoji" },
        {
            name = "cmp_tabnine",
            keyword_length = 4,
        },
        {
            name = "spell",
            option = {
                keep_all_entries = false,
                enable_in_context = function()
                    return true
                end,
            },
        },
    },
})

luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
})
-- require the vscode html tag completion
require("luasnip/loaders/from_vscode").lazy_load()

-- tabnine
local tabnine = require("cmp_tabnine.config")
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    priority = 150,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
})

-- autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
