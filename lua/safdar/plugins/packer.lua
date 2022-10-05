local vim = vim
local packer = require("packer")
require("safdar.core.plugins_mappings.packer_map")
packer.startup({
    function(use)
        --> Packer can manage itself
        use({ "wbthomason/packer.nvim" })

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

        use({ "nvim-lua/plenary.nvim" })
        use({ "nvim-lua/popup.nvim" })

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

        --> color scheme
        use({ "rktjmp/lush.nvim" })
        use({ "folke/tokyonight.nvim" })
        use({
            "ellisonleao/gruvbox.nvim",
            config = function()
                require("gruvbox").setup({
                    undercurl = true,
                    underline = true,
                    bold = true,
                    italic = true,
                    strikethrough = true,
                    invert_selection = false,
                    invert_signs = false,
                    invert_tabline = false,
                    invert_intend_guides = false,
                    inverse = true, -- invert background for search, diffs, statuslines and errors
                    contrast = "", -- can be "hard", "soft" or empty string
                    overrides = {},
                    dim_inactive = false,
                    transparent_mode = false,
                })
            end
        })
        use({
            "catppuccin/nvim",
            as = "catppuccin",
        })

        use({
            "folke/todo-comments.nvim",
            config = function()
                require("safdar.plugins.configs.todo")
            end,
        })

        --> more productive
        use({
            "kyazdani42/nvim-tree.lua",
            config = function()
                require("safdar.plugins.configs.nvim-tree")
                require("safdar.core.plugins_mappings.nvim-tree_map")
            end,
        })
        --> Git stuff
        use({
            "lewis6991/gitsigns.nvim",
            config = function()
                require("safdar.plugins.configs.gitsigns") -- should be called after other _plugins_configs
            end,
        })
        use({
            "TimUntersberger/neogit",
        })

        --> ui related stuff
        use({
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup()
            end,
        }) -- icons for the nvim
        use({ "onsails/lspkind-nvim" }) -- better icons for the lsp
        use({
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("safdar.plugins.configs.indentline")
            end,
        }) -- indent guides

        use({
            "feline-nvim/feline.nvim",
            config = function()
                require("safdar.plugins.configs.feline")
            end,
        })

        -- for linting files that null_ls does not support
        use({
            "dense-analysis/ale",
            config = function()
                require("safdar.plugins.configs.ale")
                require("safdar.core.plugins_mappings.ale_map")
            end,
            ft = { "html" },
        })
        use({
            "mattn/emmet-vim",
            config = function()
                require("safdar.plugins.configs.emmet")
            end,
            ft = { "html" },
        })

        -- load luasnips + cmp related in insert mode only
        use({
            "neovim/nvim-lspconfig", -- quckstart lsp conifgs
            config = function()
                require("safdar.lsp.lsp")
            end,
            requires = {
                {
                    "jose-elias-alvarez/null-ls.nvim",
                    config = function()
                        require("safdar.lsp.null_ls")
                        require("safdar.core.plugins_mappings.null-ls_map")
                    end,
                },
            },
        })
        use({ "b0o/schemastore.nvim" })

        -- completion stuff and snippets
        use({
            "hrsh7th/nvim-cmp",
            config = function()
                require("safdar.lsp.cmp")
            end,
        })
        use({ "hrsh7th/cmp-nvim-lua" })
        use({ "hrsh7th/cmp-nvim-lsp" })
        use({ "hrsh7th/cmp-buffer" })
        use({ "hrsh7th/cmp-emoji", ft = { "html", "css" } })
        use({ "saadparwaiz1/cmp_luasnip" })
        use({ "L3MON4D3/LuaSnip" })
        use({ "rafamadriz/friendly-snippets" })

        use({ "tzachar/cmp-tabnine", run = "./install.sh" })

        --> Lsp utils
        use({
            "ray-x/lsp_signature.nvim",
            config = function()
                require("safdar.plugins.configs.signature")
            end,
        })

        --> for lsp enhancement
        use({
            "folke/trouble.nvim",
            config = function()
                require("safdar.plugins.configs.trouble")
                require("safdar.core.plugins_mappings.lsp-trouble_map")
            end,
        })
        -- TODO: work on this plugin config
        use({
            "glepnir/lspsaga.nvim",
            config = function()
                require("safdar.plugins.configs.saga")
                require("safdar.core.plugins_mappings.lsp-saga_map")
            end,
        })
        use {
            "utilyre/barbecue.nvim",
            requires = {
                "neovim/nvim-lspconfig",
                "smiteshp/nvim-navic",
            },
            config = function ()
                require("safdar.plugins.configs.barbecue")
            end
        }
        use({
            "AckslD/nvim-FeMaco.lua",
            config = function()
                require("femaco").setup()
                require("safdar.core.plugins_mappings.FeMaco_map")
            end,
            ft = { "markdown" },
        })

        -- syntax Highlighting
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("safdar.plugins.configs.treesitter")
                require("safdar.core.plugins_mappings.treesitter_map")
            end,
        })
        use({ "nvim-treesitter/playground" })
        use({
            "windwp/nvim-ts-autotag",
            config = function()
                require("nvim-ts-autotag").setup()
            end,
        })
        use({
            "p00f/nvim-ts-rainbow",
        })

        --> utils
        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({
                    check_ts = true,
                    map_c_w = true,
                })
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                local cmp = require("cmp")
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end,
        })
        use({
            "AckslD/nvim-neoclip.lua",
            requires = { "tami5/sqlite.lua", module = "sqlite" },
            config = function()
                require("safdar.plugins.configs.neoclip")
            end,
        })
        use({ "tpope/vim-repeat" })
        use({ "tpope/vim-surround" })

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
                require("safdar.core.plugins_mappings.undotree_map")
            end,
        })

        --> ThePrimeagen coconut oil
        use({
            "ThePrimeagen/vim-be-good",
            config = function()
                require("safdar.core.plugins_mappings.vim-be-good_map")
            end,
        })
        use({
            "ThePrimeagen/refactoring.nvim",
            config = function()
                require("safdar.plugins.configs.refactoring")
                require("safdar.core.plugins_mappings.refactoring_map")
            end,
        })
        use({
            "ThePrimeagen/harpoon", -- the most amazing plugin i have yet discoverd
            config = function()
                require("safdar.plugins.configs.harpoon")
                require("safdar.core.plugins_mappings.harpoon_map")
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
                require("safdar.core.plugins_mappings.git_worktree_map")
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
                require("safdar.core.plugins_mappings.markdown-preview_map")
            end,
            ft = { "markdown" },
        })
    end,
    config = {
        compile_path = vim.fn.stdpath("config") .. "/lua/_packer/init.lua",
        profile = {
            enable = true,
            threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    },
})

--> Reuire plugins that do not require a config|setup
require("safdar.core.plugins_mappings.neogit_map")
