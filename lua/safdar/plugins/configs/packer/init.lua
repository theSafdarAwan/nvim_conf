local utils = require("safdar.core.utils")
local vim = utils.vim

local packer = require("packer")
packer.startup({
    function(use)
        --  ++> Packer can manage itself
        use({ "wbthomason/packer.nvim" })
        -- <++

        -- ++> Performance
        use({
            "lewis6991/impatient.nvim",
            config = function()
                require("impatient")
                require("impatient").enable_profile()
            end,
        })
        use({
            "antoinemadec/FixCursorHold.nvim",
            run = function()
                vim.g.curshold_updatime = 100
            end,
        })
        use({
            "norcalli/profiler.nvim",
            config = function()
                require("profiler")
            end,
        })
        -- <++

        -- ++> Essential
        use({ "nvim-lua/plenary.nvim" })
        use({ "nvim-lua/popup.nvim" })
        -- <++

        -- ++> Telescope
        use({
            "nvim-telescope/telescope.nvim",
            config = function()
                require("safdar.plugins.configs.telescope")
            end,
        })
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        })
        -- <++

        -- ++> color scheme
        use({
            "TheSafdarAwan/fused.nvim",
            config = function()
                require("fused").setup({ enable_plugins = true })
            end,
        })
        use({
            "folke/tokyonight.nvim",
            "ellisonleao/gruvbox.nvim",
            "catppuccin/nvim",
        })
        -- <++

        -- ++> more productive
        use({
            "kyazdani42/nvim-tree.lua",
            config = function()
                require("safdar.plugins.configs.nvim-tree")
                require("safdar.plugins.configs.nvim-tree.maps")
            end,
        })
        -- Git stuff
        use({
            "lewis6991/gitsigns.nvim",
            config = function()
                require("safdar.plugins.configs.gitsigns") -- should be called after other _plugins_configs
            end,
        })
        use({
            "TimUntersberger/neogit",
            requires = {
                "sindrets/diffview.nvim",
                config = function()
                    require("safdar.plugins.configs.diffview")
                end,
            },
            config = function()
                require("safdar.plugins.configs.neogit")
            end,
        })
        use({
            "kylechui/nvim-surround",
            tag = "main", -- Use for stability; omit to use `main` branch for the latest features
            config = function()
                require("safdar.plugins.configs.surround")
            end,
        })
        -- <++

        -- ++> ui related stuff
        use({
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup()
            end,
        }) -- icons for the nvim
        -- use({
        --     "onsails/lspkind-nvim",
        -- }) -- better icons for the lsp
        use({
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("safdar.plugins.configs.indent-blank-line")
            end,
        }) -- indent guides
        use({
            "feline-nvim/feline.nvim",
            config = function()
                require("safdar.plugins.configs.feline")
            end,
        }) -- status line
        -- <++

        -- ++> for linting files that null_ls does not support
        use({
            "dense-analysis/ale",
            config = function()
                require("safdar.plugins.configs.ale")
                require("safdar.plugins.configs.maps")
            end,
            ft = { "html" },
        })
        use({
            "petertriho/nvim-scrollbar",
            config = function()
                require("safdar.plugins.configs.scroolbar")
            end,
        })
        -- <++

        -- ++> load luasnips + cmp related in insert mode only
        use({
            "neovim/nvim-lspconfig", -- quckstart lsp conifgs
            config = function()
                require("safdar.lsp.lspconfig")
            end,
            requires = {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("safdar.lsp.null-ls")
                    require("safdar.plugins.configs.plugins_mappings.null-ls_map")
                end,
            },
        })
        use({ "b0o/schemastore.nvim" })
        use({
            "hrsh7th/nvim-cmp",
            config = function()
                require("safdar.lsp.cmp")
            end,
        })
        use({ "tzachar/cmp-tabnine", run = "./install.sh" })
        use({
            "uga-rosa/cmp-dictionary",
            ft = { "markdown", "norg" },
            config = function()
                require("safdar.plugins.configs.cmp.cmp-dictionary")
            end,
        })
        use({
            "hrsh7th/cmp-emoji",
            ft = { "html", "css", "markdown", "norg" },
        })
        use({
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
        })
        use({
            "L3MON4D3/LuaSnip",
            config = function()
                require("safdar.plugins.configs.luasnip")
            end,
        })
        -- <++

        -- ++> Lsp utils & enhancements
        use({
            "ray-x/lsp_signature.nvim",
            config = function()
                require("safdar.plugins.configs.lspsignature")
            end,
        })
        use({
            "folke/trouble.nvim",
            config = function()
                require("safdar.plugins.configs.lsp-trouble")
                require("safdar.plugins.configs.lsp-trouble.maps")
            end,
        })
        use({
            "glepnir/lspsaga.nvim",
            config = function()
                require("safdar.plugins.configs.lspsaga")
                require("safdar.plugins.configs.lspsaga.maps")
            end,
        })
        use({
            "AckslD/nvim-FeMaco.lua",
            config = function()
                require("femaco").setup()
                require("safdar.plugins.configs.plugins_mappings.FeMaco_map")
            end,
            ft = { "markdown", "norg" },
        })
        -- <++

        -- ++> Debugging
        use({
            "mfussenegger/nvim-dap",
            requires = {
                { "theHamsta/nvim-dap-virtual-text" },
                { "rcarriga/nvim-dap-ui" },
            },
            config = function()
                require("safdar.dap")
                require("safdar.plugins.configs.dap.maps").dap_maps()
                --> plugins cfgs
                require("safdar.plugins.configs.dap.dap-ui")
                require("safdar.plugins.configs.dap.dap-virtual-text")
            end,
        })
        -- <++

        -- ++> syntax Highlighting
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("safdar.plugins.configs.treesitter")
                require("safdar.plugins.configs.treesitter.maps")
            end,
        })
        use({
            "nvim-treesitter/tsplayground",
            config = function()
                require("safdar.plugins.configs.tsplayground")
            end,
        })
        use({
            "windwp/nvim-ts-autotag",
            config = function()
                require("nvim-ts-autotag").setup()
            end,
        })
        use({
            "p00f/nvim-ts-rainbow",
        })
        -- <++

        -- ++> utils
        use({
            "folke/todo-comments.nvim",
            config = function()
                require("safdar.plugins.configs.todo-comments")
                require("safdar.plugins.configs.todo-comments.maps")
            end,
        })
        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({
                    check_ts = true,
                    map_c_w = true,
                })
            end,
        })
        -- Packer
        use({
            "folke/paint.nvim",
            config = function()
                require("safdar.plugins.configs.paint")
            end,
        })
        use({
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup({})
            end,
        }) -- comment out the blocks of text
        use({
            "andymass/vim-matchup",
            config = function()
                require("safdar.plugins.configs.vim-matchup")
            end,
        })
        use({
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("safdar.plugins.configs.colorizer")
            end,
        }) -- shows the colors
        use({
            "mbbill/undotree",
            config = function()
                require("safdar.plugins.configs.undotree.maps")
            end,
        })
        -- <++

        -- ++> ThePrimeagen coconut oil
        use({
            "ThePrimeagen/vim-be-good",
            config = function()
                require("safdar.plugins.configs.vim-be-good.maps")
            end,
        })
        use({
            "ThePrimeagen/refactoring.nvim",
            config = function()
                require("safdar.plugins.configs.refactoring")
                require("safdar.plugins.configs.refactoring.maps")
            end,
        })
        use({
            "ThePrimeagen/harpoon", -- the most amazing plugin i have yet discoverd
            config = function()
                require("safdar.plugins.configs.harpoon")
                require("safdar.plugins.configs.harpoon.maps")
            end,
        })
        -- TODO: work on this plugin as you explore more about git
        use({
            "ThePrimeagen/git-worktree.nvim",
            config = function()
                require("git-worktree").setup({
                    change_directory_command = "cd", -- default: "cd",
                    update_on_change = true, -- default: true,
                    update_on_change_command = "e .", -- default: "e .",
                    clearjumps_on_change = true, -- default: true,
                    autopush = false, -- default: false,
                })
                require("safdar.plugins.configs.plugins_mappings.git_worktree_map")
            end,
        })
        -- <++

        -- ++> Note Takign Stuff Stuff
        -- norg
        use({
            "nvim-neorg/neorg",
            run = ":Neorg sync-parsers", -- This is the important bit!
            -- ft = "norg",
            requires = {
                "nvim-neorg/neorg-telescope",
            },
            config = function()
                require("safdar.plugins.configs.neorg")
                require("safdar.plugins.configs.neorg.maps")
            end,
        })
        -- Markdwon Plugin
        use({
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
            config = function()
                require("safdar.plugins.configs.markdown-preview")
                require("safdar.plugins.configs.markdown-preview.maps")
            end,
            ft = { "markdown" },
        })
        -- <++
    end,
    config = {
        compile_path = vim.fn.stdpath("config") .. "/lua/_packer/init.lua",
        auto_clean = true,
        compile_on_sync = true,
        git = { clone_timeout = 6000 },
        profile = {
            enable = true,
            threshold = 100, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },
        display = {
            working_sym = "ﲊ",
            error_sym = "✗ ",
            done_sym = " ",
            removed_sym = " ",
            moved_sym = "",
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    },
})
