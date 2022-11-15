--> TODO: rewrite some of the status line modules

--=====================================================
--                  general
--=====================================================
local utils = require("safdar.core.utils")
local vim = utils.vim
local colors = require("fused.palletes").dark_pallete
local lsp = require("feline.providers.lsp")
local lsp_severity = vim.diagnostic.severity
-- TODO: creae a local table of colors from the fused pallete and used that

local icon_styles = {
    default = {
        left = "",
        right = " ",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
    },
    default2 = {
        left = "",
        right = "",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
    },

    block = {
        left = " ",
        right = " ",
        main_icon = "   ",
        vi_mode_icon = "  ",
        position_icon = "  ",
    },

    round = {
        left = "",
        right = "",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
    },

    slant = {
        left = "",
        right = " ",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
    },
}

--=====================================================
--               defining custom functions
--=====================================================
local enable_only_in_full_buf = function()
    return vim.api.nvim_win_get_width(0) > 40
end

--=====================================================
--                  defining compnents
--=====================================================

-- Initialize the components table
local components = {
    active = {},
    inactive = {},
}

-- Initialize left, mid and right
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

--=====================================================
--                  left
--=====================================================

local mode_colors = {
    ["n"] = { "NORMAL", colors.yellow },
    ["no"] = { "N-PENDING", colors.yellow },
    ["i"] = { "INSERT", colors.green },
    ["ic"] = { "INSERT", colors.green },
    ["t"] = { "TERMINAL", colors.blue },
    ["v"] = { "VISUAL", colors.pink },
    ["V"] = { "V-LINE", colors.pink },
    [""] = { "V-BLOCK", colors.pink },
    ["R"] = { "REPLACE", colors.red },
    ["Rv"] = { "V-REPLACE", colors.red },
    ["s"] = { "SELECT", colors.red },
    ["S"] = { "S-LINE", colors.red },
    [""] = { "S-BLOCK", colors.red },
    ["c"] = { "COMMAND", colors.magenta },
    ["cv"] = { "COMMAND", colors.magenta },
    ["ce"] = { "COMMAND", colors.magenta },
    ["r"] = { "PROMPT", colors.wblue },
    ["rm"] = { "MORE", colors.wblue },
    ["r?"] = { "CONFIRM", colors.wblue },
    ["!"] = { "SHELL", colors.blue },
}

-- local sid_mode_hl = function()
--     return {
--         fg = mode_colors[vim.fn.mode()][2],
--         bg = colors.lightbg,
--     }
-- end

-- components.active[1][1] = {
--     provider = function()
--         return " " .. mode_colors[vim.fn.mode()][1] .. " "
--     end,
--     hl = chad_mode_hl,
-- }

components.active[1][1] = {
    provider = "██",
    -- return '██ '
    enabled = enable_only_in_full_buf,
    hl = function()
        return {
            fg = mode_colors[vim.fn.mode()][2],
            bg = mode_colors[vim.fn.mode()][2],
        }
    end,
}

components.active[1][2] = {
    provider = "git_branch",
    enabled = enable_only_in_full_buf,
    hl = {
        fg = colors.white,
        bg = colors.dark,
    },
    icon = "  ",
    right_sep = {
        str = icon_styles.default2.right,
        hl = {
            fg = colors.dark,
            bg = colors.white,
        },
    },
}

components.active[1][3] = {
    provider = function()
        local origFilename = vim.fn.expand("%:p:t:r")
        local function splitLongString(originalNameString, maxLineLength)
            local length = #originalNameString
            if length > maxLineLength then
                return ""
            else
                return originalNameString
            end
        end

        local filename = splitLongString(origFilename, 15) .. " "
        local extension = vim.fn.expand("%:e")
        local gIcon = require("nvim-web-devicons").get_icon(filename, extension)
        local icon
        if gIcon == nil then
            icon = "  "
        else
            icon = " " .. gIcon .. " "
        end
        return icon .. filename
    end,
    enabled = enable_only_in_full_buf,
    hl = {
        fg = colors.dark,
        bg = colors.white,
    },

    right_sep = {
        str = icon_styles.default2.right,
        hl = {
            fg = colors.white,
            bg = colors.dark,
        },
    },
}

components.active[1][4] = {
    provider = "git_diff_added",
    hl = { fg = colors.green, bg = colors.dark },
    icon = "  ",
}
-- diffModfified
components.active[1][5] = {
    provider = "git_diff_changed",
    hl = { fg = colors.blue, bg = colors.dark },
    icon = " ⦿ ",
}
-- diffRemove
components.active[1][6] = {
    provider = "git_diff_removed",
    hl = { fg = colors.wred, bg = colors.dark },
    icon = "  ",
}

-- components.active[1][7] = {
--     provider = icon_styles.slant.right,
--     -- TODO:
--     -- enabled = function()
--     --         local b = vim.b
--     --         local g = vim.k
--     -- 	return g.gitsigns_head or b.gitsigns_head or b.gitsigns_status_dict	end,
--     hl = {
--         fg = colors.dark,
--         bg = colors.dark,
--     },
-- }

--=====================================================
--                  center
--=====================================================

components.active[2][1] = {
    provider = function()
        local Lsp = vim.lsp.util.get_progress_messages()[1]
        if Lsp then
            local msg = Lsp.message or ""
            local percentage = Lsp.percentage or 0
            local title = Lsp.title or ""
            local spinners = {
                "⠋",
                "⠇",
                "⠦",
                "⠙",
                "⠹",
                "⠼",
                "⠴",
                "⠸",
                "⠦",
                "⠧",
                "⠇",
                "⠏",
            }

            local success_icon = {
                -- "",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
                "﫠",
            }

            local ms = vim.loop.hrtime() / 1000000
            local frame = math.floor(ms / 120) % #spinners

            if percentage >= 70 then
                return string.format(
                    " %%<%s %s %s (%s%%%%) ",
                    success_icon[frame + 1],
                    title,
                    msg,
                    percentage
                )
            else
                return string.format(
                    " %%<%s %s %s (%s%%%%) ",
                    spinners[frame + 1],
                    title,
                    msg,
                    percentage
                )
            end
        end
        return "%b-0x%B"
    end,
    enabled = enable_only_in_full_buf,
    hl = { fg = colors.green, bg = colors.dark },
}

--=====================================================
--                  right
--=====================================================
-- some custom manipulation
components.active[3][1] = {
    provider = icon_styles.slant.left,
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.ERROR)
            or lsp.diagnostics_exist(lsp_severity.WARN)
            or lsp.diagnostics_exist(lsp_severity.HINT)
            or lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    hl = {
        fg = colors.dark,
        bg = colors.dark,
    },
}

components.active[3][2] = {
    provider = "diagnostic_errors",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.ERROR)
    end,
    hl = { fg = colors.error_red, bg = colors.dark },
    icon = "  ",
}

components.active[3][3] = {
    provider = "diagnostic_warnings",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.WARN)
    end,
    hl = { fg = colors.yellow, bg = colors.dark },
    icon = "  ",
}

components.active[3][4] = {
    provider = "diagnostic_hints",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.HINT)
    end,
    hl = { fg = colors.sky, bg = colors.dark },
    icon = "  ",
}

components.active[3][5] = {
    provider = "diagnostic_info",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    hl = { fg = colors.green, bg = colors.dark },
    icon = "  ",
}

-- some custom manipulation
components.active[3][6] = {
    provider = " ",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.ERROR)
            or lsp.diagnostics_exist(lsp_severity.WARN)
            or lsp.diagnostics_exist(lsp_severity.HINT)
            or lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    hl = {
        fg = colors.dark,
        bg = colors.dark,
    },
}

components.active[3][7] = {
    provider = icon_styles.default.left,
    enabled = enable_only_in_full_buf,
    hl = {
        fg = colors.white,
        bg = colors.dark,
    },
}

components.active[3][7] = {
    provider = function()
        local lsp_symbol_str = "   LSP "
        local lsp_symbol_str_not_atcive = "   no LSP "

        if next(vim.lsp.buf_get_clients()) ~= nil then
            local lsp_status_slant = lsp_symbol_str .. icon_styles.default.left
            return lsp_status_slant
        else
            local lsp_status_slant = lsp_symbol_str_not_atcive
                .. icon_styles.default.left
            return lsp_status_slant
        end
    end,
    enabled = enable_only_in_full_buf,
    hl = { fg = colors.dark, bg = colors.white },
    left_sep = {
        str = icon_styles.default.left,
        hl = {
            fg = colors.white,
            bg = colors.dark,
        },
    },
}

components.active[3][8] = {
    provider = function()
        local current_line = vim.fn.line(".")
        local total_line = vim.fn.line("$")

        if current_line == 1 then
            return " Top "
        elseif current_line == vim.fn.line("$") then
            return " Bot "
        end
        local result, _ = math.modf((current_line / total_line) * 100)
        return " " .. result .. "%% "
    end,

    enabled = enable_only_in_full_buf,

    hl = {
        fg = colors.green,
        bg = colors.dark,
    },
}

components.active[3][9] = {
    provider = "scroll_bar",
    enabled = enable_only_in_full_buf,
    hl = {
        fg = colors.teal,
        bg = colors.dark,
        style = "bold",
    },
}

require("feline").setup({
    colors = {
        bg = colors.dark,
        fg = colors.white,
    },
    components = components,
    force_inactive = {
        filetypes = {
            "^NvimTree$",
            "^Outline$",
            "DiffviewFileHistory",
            "DiffviewFiles",
        },
        buftypes = {
            "^terminal$",
            "prompt",
        },
        bufnames = {
            "neorg://norg/Projects.norg",
            "neorg://norg/Neorg Toc.norg",
        },
    },
})
