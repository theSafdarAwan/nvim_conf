local vim = vim
vim.g.safdar_colorscheme = "dracula-sid"
local colors = require("safdar.lush_theme.dracula-pallete")

function ColorMyPencils()
    vim.g.gruvbox_contrast_dark = "hard"
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.g.gruvbox_invert_selection = "0"
    vim.opt.background = "dark"

    vim.cmd("colorscheme " .. vim.g.safdar_colorscheme)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl("SignColumn", {
        bg = "none",
    })

    hl("ColorColumn", {
        ctermbg = 0,
        bg = colors.color_5,
    })

    hl("guibg", {
        bg = "None"
    })

    hl("Normal", {
        bg = "none"
    })

    hl("FloatBorder", {
        fg = colors.color_2
    })

    -- hl("LineNr", {
    --     fg = "#5eacd3"
    -- })

    -- hl("CursorLineNR", {
    --     bg = "None"
    -- })

    hl("netrwDir", {
        fg = "#5eacd3"
    })
end

ColorMyPencils()
