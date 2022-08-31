local vim = vim
local packer = require("packer")
require(require("genearl").core_loc() .. ".plugins_mappings.packer_map")
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
                require(require("genearl").plugins_loc() .. ".configs.telescope")
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
            "catppuccin/nvim",
            as = "catppuccin",
        })

        use({
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.todo")
            end,
        })

		--> Git stuff
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require(require("genearl").plugins_loc() .. ".configs.gitsigns") -- should be called after other _plugins_configs
			end,
		})
		use({
			"TimUntersberger/neogit",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require(require("genearl").core_loc() .. ".plugins_mappings.neogit_map")
			end,
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
                require(require("genearl").plugins_loc() .. ".configs.indentline")
            end,
        }) -- indent guides

        --> more productive
        use({
            "kyazdani42/nvim-tree.lua",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.nvim-tree")
                require(require("genearl").core_loc() .. ".plugins_mappings.nvim-tree_map")
            end,
        })

        use({
            "feline-nvim/feline.nvim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.feline")
            end,
        })

        -- for linting files that null_ls does not support
        use({
            "dense-analysis/ale",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.ale")
                require(require("genearl").core_loc() .. ".plugins_mappings.ale_map")
            end,
            ft = { "html" },
        })
        use({
            "mattn/emmet-vim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.emmet")
            end,
            ft = { "html" },
        })

        -- load luasnips + cmp related in insert mode only
        use({
            "neovim/nvim-lspconfig", -- quckstart lsp conifgs
            config = function()
                require(require("genearl").lsp_loc() .. ".lsp")
            end,
            requires = {
                {
                    "jose-elias-alvarez/null-ls.nvim",
                    config = function()
                        require(require("genearl").lsp_loc() .. ".null_ls")
                        require(require("genearl").core_loc() .. ".plugins_mappings.null-ls_map")
                    end,
                },
            },
        })
        use({ "b0o/schemastore.nvim" })

        -- completion stuff and snippets
        use({
            "hrsh7th/nvim-cmp",
            config = function()
                require(require("genearl").lsp_loc() .. ".cmp")
            end,
        })
        use({ "hrsh7th/cmp-nvim-lua" })
        use({ "hrsh7th/cmp-nvim-lsp" })
        use({ "hrsh7th/cmp-buffer" })
        use({ "hrsh7th/cmp-emoji", ft = { "html", "css" } })
        use({ "saadparwaiz1/cmp_luasnip" })
        use({ "L3MON4D3/LuaSnip" })
        use({ "rafamadriz/friendly-snippets" })

        use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

        --> Lsp utils
        use({
            "simrat39/symbols-outline.nvim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.symbols-outline")
                require(require("genearl").core_loc() .. ".plugins_mappings.symbols-outline_map")
            end,
        })
        use({
            "ray-x/lsp_signature.nvim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.signature")
            end,
        })

        --> for lsp enhancement
        use({
            "folke/trouble.nvim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.trouble")
                require(require("genearl").core_loc() .. ".plugins_mappings.lsp-trouble_map")
            end,
        })
        -- TODO: work on this plugin config
        use({
            "glepnir/lspsaga.nvim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.saga")
                require(require("genearl").core_loc() .. ".plugins_mappings.lsp-saga_map")
            end,
        })
        use({
            "AckslD/nvim-FeMaco.lua",
            config = function()
                require("femaco").setup()
                require(require("genearl").core_loc() .. ".plugins_mappings.FeMaco_map")
            end,
            ft = { "markdown" },
        })

        -- syntax Highlighting
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.treesitter")
                require(require("genearl").core_loc() .. ".plugins_mappings.treesitter_map")
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
        use({
            "axelvc/template-string.nvim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.template-string")
            end,
        })

        --> utils
        use({
            "AckslD/nvim-neoclip.lua",
            requires = { "tami5/sqlite.lua", module = "sqlite" },
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.neoclip")
            end,
        })
        use({ "tpope/vim-repeat" })
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
        use({ "tpope/vim-surround" })
        --> Tmux for nvim
        use({
            "tpope/vim-obsession",
            config = function()
                require(require("genearl").core_loc() .. ".plugins_mappings.obsession_map")
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
                require(require("genearl").plugins_loc() .. ".configs.vim-matchup")
            end,
        })
        use({
            "norcalli/nvim-colorizer.lua",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.colorizer")
            end,
        }) -- shows the colors
        use({
            "mbbill/undotree",
            config = function()
                require(require("genearl").core_loc() .. ".plugins_mappings.undotree_map")
            end,
        })

        --> ThePrimeagen coconut oil
        use({
            "ThePrimeagen/vim-be-good",
            config = function()
                require(require("genearl").core_loc() .. ".plugins_mappings.vim-be-good_map")
            end,
        })
        use({
            "ThePrimeagen/refactoring.nvim",
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.refactoring")
                require(require("genearl").core_loc() .. ".plugins_mappings.refactoring_map")
            end,
        })
        use({
            "ThePrimeagen/harpoon", -- the most amazing plugin i have yet discoverd
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.harpoon")
                require(require("genearl").core_loc() .. ".plugins_mappings.harpoon_map")
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
                require(require("genearl").core_loc() .. ".plugins_mappings.git_worktree_map")
            end,
        })

        -- Markdwon Plugin
        use({
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
            config = function()
                require(require("genearl").plugins_loc() .. ".configs.markdown-preview")
                require(require("genearl").core_loc() .. ".plugins_mappings.markdown-preview_map")
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
