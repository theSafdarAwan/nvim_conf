-- @packer
local utils = require("safdar.core.utils")
local vim = utils.vim

local packer = require("packer")
packer.startup({
	function(install)
		--  ~> Packer can manage itself
		install({ "wbthomason/packer.nvim" })
		-- <~

		-- ~> Performance
		install({
			"lewis6991/impatient.nvim",
			config = function()
				require("impatient")
				require("impatient").enable_profile()
			end,
		})
		install({
			"antoinemadec/FixCursorHold.nvim",
			run = function()
				vim.g.curshold_updatime = 100
			end,
		})
		install({
			"norcalli/profiler.nvim",
			config = function()
				require("profiler")
			end,
		})
		-- <~

		-- ~> Essential
		install({ "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim", after = "impatient" })
		-- <~

		-- ~> Telescope
		install({
			"nvim-telescope/telescope.nvim",
			after = "telescope-fzf-native.nvim",
			config = function()
				require("safdar.plugins.telescope")
			end,
		})
		install({
			"nvim-telescope/telescope-fzf-native.nvim",
			after = "plenary.nvim",
			run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		})
		-- <~

		-- ~> color scheme
		install({
			"TheSafdarAwan/fused.nvim",
			config = function()
				require("safdar.plugins.fused")
			end,
		})
		install({
			"ellisonleao/gruvbox.nvim",
			"catppuccin/nvim",
			"LunarVim/Colorschemes",
			"nvchad/base46",
			"folke/tokyonight.nvim",
			config = function()
				-- require("safdar.plugins.tokyonight")
				local base46 = require("base46")
				base46.load_theme()
				base46.load_highlight("treesitter")
			end,
		})
		-- <~

		-- ~> more productive
		install({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("safdar.plugins.nvim-tree")
			end,
		})
		-- Git stuff
		install({
			"lewis6991/gitsigns.nvim",
			opt = true,
			config = function()
				require("safdar.plugins.gitsigns") -- should be called after other _plugins_configs
			end,
		})
		install({
			"TimUntersberger/neogit",
			after = "gitsigns.nvim",
			config = function()
				require("safdar.plugins.neogit")
			end,
		})
		install({
			"sindrets/diffview.nvim",
			after = "neogit",
			config = function()
				require("safdar.plugins.diffview")
			end,
		})
		install({
			"kylechui/nvim-surround",
			opt = true,
			keys = { { "v", "S" }, { "n", "cs" }, { "n", "ds" } },
			-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("safdar.plugins.surround")
			end,
		})
		install({
			"s1n7ax/nvim-window-picker",
			keys = { "n", "gf" },
			tag = "v1.*",
			config = function()
				require("safdar.plugins.window-picker")
			end,
		})
		-- <~

		-- ~> ui related stuff
		install({
			"kyazdani42/nvim-web-devicons",
			after = { "telescope.nvim", "nvim-tree.lua" },
			config = function()
				require("nvim-web-devicons").setup()
			end,
		}) -- icons for the nvim
		-- use({
		--     "onsails/lspkind-nvim",
		-- }) -- better icons for the lsp
		install({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("safdar.plugins.indent-blank-line")
			end,
		}) -- indent guides
		install({
			"feline-nvim/feline.nvim",
			after = "nvim-web-devicons",
			config = function()
				require("safdar.plugins.feline")
			end,
		}) -- status line
		-- <~

		-- ~> linting files that null_ls does not support
		install({
			"dense-analysis/ale",
			opt = true,
			config = function()
				require("safdar.plugins.ale")
			end,
		})
		-- <~

		-- ~> load luasnips + cmp related in insert mode only
		install({
			"neovim/nvim-lspconfig",
			opt = true,
			config = function()
				require("safdar.lsp.lsp")
			end,
		})
		-- this plguin should be loaded before lsp in the lazy-load-packer.lua
		install({ "b0o/schemastore.nvim" })
		install({
			"jose-elias-alvarez/null-ls.nvim",
			after = "nvim-lspconfig",
			config = function()
				require("safdar.lsp.null-ls")
				require("safdar.plugins.plugins_mappings.null-ls_map")
			end,
		})

		install({
			"L3MON4D3/LuaSnip",
			requires = {
				"saadparwaiz1/cmp_luasnip",
			},
			config = function()
				require("safdar.plugins.luasnip")
			end,
		})

		install({
			"hrsh7th/nvim-cmp",
			config = function()
				require("safdar.lsp.cmp")
			end,
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
			},
		})

		install({
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			opt = true,
			config = function()
				require("safdar.plugins.tabnine")
			end,
		})
		install({
			"hrsh7th/cmp-nvim-lua",
			opt = true,
		})

		install({
			"hrsh7th/cmp-emoji",
			event = "InsertEnter",
		})
		install({
			"uga-rosa/cmp-dictionary",
			opt = true,
			config = function()
				require("safdar.plugins.cmp.cmp-dictionary")
			end,
		})
		-- <~

		-- ~> Lsp utils & enhancements
		install({
			"ray-x/lsp_signature.nvim",
			after = "nvim-lspconfig",
			config = function()
				require("safdar.plugins.lspsignature")
			end,
		})
		install({
			"folke/trouble.nvim",
			after = "lsp_signature.nvim",
			config = function()
				require("safdar.plugins.lsp-trouble")
			end,
		})
		install({
			"glepnir/lspsaga.nvim",
			after = "trouble.nvim",
			config = function()
				require("safdar.plugins.lspsaga")
			end,
		})
		install({
			"AckslD/nvim-FeMaco.lua",
			config = function()
				require("femaco").setup()
				require("safdar.plugins.plugins_mappings.FeMaco_map")
			end,
			ft = { "markdown", "norg" },
		})
		-- <~

		-- ~> Debugging
		install({
			"mfussenegger/nvim-dap",
			requires = {
				{ "theHamsta/nvim-dap-virtual-text" },
				{ "rcarriga/nvim-dap-ui" },
			},
			after = "nvim-lspconfig",
			config = function()
				require("safdar.plugins.dap")
				--> plugins cfgs
				require("safdar.plugins.dap.dap-ui")
				require("safdar.plugins.dap.dap-virtual-text")
			end,
		})
		-- <~

		-- ~> syntax Highlighting
		install({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("safdar.plugins.treesitter")
			end,
		})
		install({
			"nvim-treesitter/playground",
			after = "nvim-treesitter",
			config = function()
				require("safdar.plugins.tsplayground")
			end,
		})
		install({
			"windwp/nvim-ts-autotag",
			after = "playground",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		})
		install({
			"p00f/nvim-ts-rainbow",
			after = "nvim-ts-autotag",
		})
		-- <~

		-- ~> utils
		install({
			"folke/todo-comments.nvim",
			opt = true,
			config = function()
				require("safdar.plugins.todo-comments")
			end,
		})
		install({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({
					check_ts = true,
					map_c_w = true,
				})
			end,
		})
		-- Packer
		install({
			"folke/paint.nvim",
			after = "nvim-treesitter",
			config = function()
				require("safdar.plugins.paint")
			end,
		})
		install({
			"numToStr/Comment.nvim",
			keys = { { "n", "gc" }, { "v", "gc" }, { "v", "gb" }, { "n", "gb" } },
			config = function()
				require("Comment").setup({})
			end,
		}) -- comment out the blocks of text
		install({
			"andymass/vim-matchup",
			after = { "nvim-treesitter" },
			config = function()
				require("safdar.plugins.vim-matchup")
			end,
		})
		install({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("safdar.plugins.colorizer")
			end,
		}) -- shows the colors
		install({
			"mbbill/undotree",
			config = function()
				require("safdar.plugins.undotree.maps")
			end,
		})
		-- <~

		-- ~> ThePrimeagen coconut oil
		install({
			"ThePrimeagen/vim-be-good",
			opt = true,
			keys = { "n", "<leader>gg" },
			config = function()
				require("safdar.plugins.vim-be-good.maps")
			end,
		})
		install({
			"ThePrimeagen/refactoring.nvim",
			opt = true,
			keys = { "n", "v" },
			config = function()
				require("safdar.plugins.refactoring")
			end,
		})
		install({
			"ThePrimeagen/harpoon", -- the most amazing plugin i have yet discoverd
			opt = true,
			keys = { { "n", "<leader>a" }, { "n", "<leader>t" } },
			config = function()
				require("safdar.plugins.harpoon")
			end,
		})
		-- TODO: work on this plugin as you explore more about git
		install({
			"ThePrimeagen/git-worktree.nvim",
			after = "diffview.nvim",
			config = function()
				require("git-worktree").setup({
					change_directory_command = "cd", -- default: "cd",
					update_on_change = true, -- default: true,
					update_on_change_command = "e .", -- default: "e .",
					clearjumps_on_change = true, -- default: true,
					autopush = false, -- default: false,
				})
				require("safdar.plugins.plugins_mappings.git_worktree_map")
				require("safdar.plugins.telescope").git_worktree()
			end,
		})
		-- <~

		-- ~> Note Takign Stuff Stuff
		-- norg
		install({
			"nvim-neorg/neorg",
			run = ":Neorg sync-parsers", -- This is the important bit!
			requires = {
				"nvim-neorg/neorg-telescope",
			},
			after = "nvim-lspconfig",
			config = function()
				require("safdar.plugins.neorg")
			end,
		})
		-- Markdwon Plugin
		install({
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
			config = function()
				require("safdar.plugins.markdown-preview")
			end,
			opt = true,
		})
		-- <~
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
