-- @packer
local utils = require("safdar.core.utils")
local vim = utils.vim

local packer = require("packer")
packer.init({
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
})
packer.startup({
	function(i)
		--  ~> Packer can manage itself
		i({
			opt = true,
			cmd = {
				"PackerSnapshot",
				"PackerSnapshotRollback",
				"PackerSnapshotDelete",
				"PackerInstall",
				"PackerUpdate",
				"PackerSync",
				"PackerClean",
				"PackerCompile",
				"PackerStatus",
				"PackerProfile",
				"PackerLoad",
			},
			"wbthomason/packer.nvim",
		})
		-- <~

		-- ~> Performance
		i({
			"lewis6991/impatient.nvim",
			config = function()
				require("impatient")
				require("impatient").enable_profile()
			end,
		})
		i({
			"antoinemadec/FixCursorHold.nvim",
			run = function()
				vim.g.curshold_updatime = 100
			end,
		})
		i({
			"norcalli/profiler.nvim",
			config = function()
				require("profiler")
			end,
		})
		-- <~

		-- ~> Essential
		i({ "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim", after = "impatient" })
		-- <~

		-- ~> Telescope
		i({
			"nvim-telescope/telescope.nvim",
			after = "telescope-fzf-native.nvim",
			config = function()
				require("safdar.plugins.telescope")
			end,
		})
		i({
			"nvim-telescope/telescope-fzf-native.nvim",
			after = "plenary.nvim",
			run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		})
		-- <~

		-- ~> color scheme
		i({
			"TheSafdarAwan/fused.nvim",
			config = function()
				require("safdar.plugins.fused")
			end,
		})
		i({
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
		i({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("safdar.plugins.nvim-tree")
			end,
		})
		-- Git stuff
		i({
			"lewis6991/gitsigns.nvim",
			opt = true,
			config = function()
				require("safdar.plugins.gitsigns") -- should be called after other _plugins_configs
			end,
		})
		i({
			"TimUntersberger/neogit",
			after = "gitsigns.nvim",
			config = function()
				require("safdar.plugins.neogit")
			end,
		})
		i({
			"sindrets/diffview.nvim",
			after = "neogit",
			config = function()
				require("safdar.plugins.diffview")
			end,
		})
		i({
			"kylechui/nvim-surround",
			opt = true,
			keys = { { "v", "S" }, { "n", "cs" }, { "n", "ds" }, { "n", "ys" }, { "n", "yS" } },
			-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("safdar.plugins.surround")
			end,
		})
		i({
			"s1n7ax/nvim-window-picker",
			keys = { "n", "gf" },
			tag = "v1.*",
			config = function()
				require("safdar.plugins.window-picker")
			end,
		})
		-- <~

		-- ~> ui related stuff
		i({
			"kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup()
			end,
		}) -- icons for the nvim
		-- use({
		--     "onsails/lspkind-nvim",
		-- }) -- better icons for the lsp
		i({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("safdar.plugins.indent-blank-line")
			end,
		}) -- indent guides
		i({
			"feline-nvim/feline.nvim",
			after = "nvim-web-devicons",
			config = function()
				require("safdar.plugins.feline")
			end,
		}) -- status line
		-- <~

		-- ~> linting files that null_ls does not support
		i({
			"dense-analysis/ale",
			opt = true,
			config = function()
				require("safdar.plugins.ale")
			end,
		})
		-- <~

		-- ~> load luasnips + cmp related in insert mode only
		i({
			"neovim/nvim-lspconfig",
			opt = true,
			config = function()
				require("safdar.lsp.lsp")
			end,
		})
		-- this plguin should be loaded before lsp in the lazy-load-packer.lua
		i({ "b0o/schemastore.nvim" })
		i({
			"jose-elias-alvarez/null-ls.nvim",
			after = "nvim-lspconfig",
			config = function()
				require("safdar.lsp.null-ls")
				require("safdar.plugins.plugins_mappings.null-ls_map")
			end,
		})

		i({
			"L3MON4D3/LuaSnip",
			requires = {
				"saadparwaiz1/cmp_luasnip",
			},
			config = function()
				require("safdar.plugins.luasnip")
			end,
		})

		i({
			"hrsh7th/nvim-cmp",
			config = function()
				require("safdar.lsp.cmp")
			end,
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
			},
		})

		i({
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			opt = true,
			config = function()
				require("safdar.plugins.tabnine")
			end,
		})
		i({
			"hrsh7th/cmp-nvim-lua",
			opt = true,
		})

		i({
			"hrsh7th/cmp-emoji",
			event = "InsertEnter",
		})
		i({
			"uga-rosa/cmp-dictionary",
			opt = true,
			config = function()
				require("safdar.plugins.cmp.cmp-dictionary")
			end,
		})
		-- <~

		-- ~> Lsp utils & enhancements
		i({
			"ray-x/lsp_signature.nvim",
			after = "nvim-lspconfig",
			config = function()
				require("safdar.plugins.lspsignature")
			end,
		})
		i({
			"folke/trouble.nvim",
			after = "lsp_signature.nvim",
			config = function()
				require("safdar.plugins.lsp-trouble")
			end,
		})
		i({
			"glepnir/lspsaga.nvim",
			after = "trouble.nvim",
			config = function()
				require("safdar.plugins.lspsaga")
			end,
		})
		i({
			"AckslD/nvim-FeMaco.lua",
			config = function()
				require("femaco").setup()
				require("safdar.plugins.plugins_mappings.FeMaco_map")
			end,
			ft = { "markdown", "norg" },
		})
		-- <~

		-- ~> Debugging
		i({
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
		i({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			-- cmd = {
			-- 	"TSInstall",
			-- 	"TSBufEnable",
			-- 	"TSBufDisable",
			-- 	"TSEnable",
			-- 	"TSDisable",
			-- 	"TSModuleInfo",
			-- },
			config = function()
				require("safdar.plugins.treesitter")
			end,
		})
		i({
			"nvim-treesitter/playground",
			after = "nvim-treesitter",
			config = function()
				require("safdar.plugins.tsplayground")
			end,
		})
		i({
			"windwp/nvim-ts-autotag",
			after = "playground",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		})
		i({
			"p00f/nvim-ts-rainbow",
			after = "nvim-ts-autotag",
		})
		-- <~

		-- ~> utils
		i({
			"folke/todo-comments.nvim",
			opt = true,
			config = function()
				require("safdar.plugins.todo-comments")
			end,
		})
		i({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({
					check_ts = true,
					map_c_w = true,
				})
			end,
		})
		-- Packer
		i({
			"folke/paint.nvim",
			after = "nvim-treesitter",
			config = function()
				require("safdar.plugins.paint")
			end,
		})
		i({
			"numToStr/Comment.nvim",
			keys = { { "n", "gc" }, { "v", "gc" }, { "v", "gb" }, { "n", "gb" } },
			config = function()
				require("Comment").setup({})
			end,
		}) -- comment out the blocks of text
		i({
			"andymass/vim-matchup",
			after = { "nvim-treesitter" },
			config = function()
				require("safdar.plugins.vim-matchup")
			end,
		})
		i({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("safdar.plugins.colorizer")
			end,
		}) -- shows the colors
		i({
			"mbbill/undotree",
			config = function()
				require("safdar.plugins.undotree.maps")
			end,
		})
		-- <~

		-- ~> ThePrimeagen coconut oil
		i({
			"ThePrimeagen/vim-be-good",
			opt = true,
			keys = { "n", "<leader>gg" },
			config = function()
				require("safdar.plugins.vim-be-good.maps")
			end,
		})
		i({
			"ThePrimeagen/refactoring.nvim",
			opt = true,
			keys = { "n", "v" },
			config = function()
				require("safdar.plugins.refactoring")
			end,
		})
		i({
			"ThePrimeagen/harpoon", -- the most amazing plugin i have yet discoverd
			opt = true,
			keys = { { "n", "<leader>a" }, { "n", "<leader>t" } },
			config = function()
				require("safdar.plugins.harpoon")
			end,
		})
		-- TODO: work on this plugin as you explore more about git
		i({
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
		i({
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
		i({
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
})
