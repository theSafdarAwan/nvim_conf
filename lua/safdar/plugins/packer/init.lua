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
		install({ "nvim-lua/plenary.nvim" })
		install({ "nvim-lua/popup.nvim" })
		-- <~

		-- ~> Telescope
		install({
			"nvim-telescope/telescope.nvim",
			config = function()
				require("safdar.plugins.telescope")
			end,
		})
		install({
			"nvim-telescope/telescope-fzf-native.nvim",
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
			"folke/tokyonight.nvim",
			config = function()
				-- require("safdar.plugins.tokyonight")
			end,
		})
		install({
			"ellisonleao/gruvbox.nvim",
			"catppuccin/nvim",
			"LunarVim/Colorschemes",
			"nvchad/base46",
			config = function()
				require("base46").get_theme_tb("falcon")
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
			config = function()
				require("safdar.plugins.gitsigns") -- should be called after other _plugins_configs
			end,
		})
		install({
			"TimUntersberger/neogit",
			requires = {
				"sindrets/diffview.nvim",
				config = function()
					require("safdar.plugins.diffview")
				end,
			},
			config = function()
				require("safdar.plugins.neogit")
			end,
		})
		install({
			"kylechui/nvim-surround",
			-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("safdar.plugins.surround")
			end,
		})
		install({
			"s1n7ax/nvim-window-picker",
			tag = "v1.*",
			config = function()
				require("safdar.plugins.window-picker")
			end,
		})
		-- <~

		-- ~> ui related stuff
		install({
			"kyazdani42/nvim-web-devicons",
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
			config = function()
				require("safdar.plugins.feline")
			end,
		}) -- status line
		-- <~

		-- ~> linting files that null_ls does not support
		install({
			"dense-analysis/ale",
			config = function()
				require("safdar.plugins.ale")
			end,
			ft = { "html" },
		})
		-- <~

		-- ~> load luasnips + cmp related in insert mode only
		install({
			"neovim/nvim-lspconfig", -- quckstart lsp conifgs
			config = function()
				require("safdar.lsp.lspconfig")
			end,
			requires = {
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("safdar.lsp.null-ls")
					require("safdar.plugins.plugins_mappings.null-ls_map")
				end,
			},
		})
		install({ "b0o/schemastore.nvim" })
		install({
			"hrsh7th/nvim-cmp",
			config = function()
				require("safdar.lsp.cmp")
			end,
		})
		install({ "tzachar/cmp-tabnine", run = "./install.sh" })
		install({
			"uga-rosa/cmp-dictionary",
			ft = { "markdown", "norg" },
			config = function()
				require("safdar.plugins.cmp.cmp-dictionary")
			end,
		})
		install({
			"hrsh7th/cmp-emoji",
			ft = { "html", "css", "markdown", "norg" },
		})
		install({
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
		})
		install({
			"L3MON4D3/LuaSnip",
			config = function()
				require("safdar.plugins.luasnip")
			end,
		})
		-- <~

		-- ~> Lsp utils & enhancements
		install({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("safdar.plugins.lspsignature")
			end,
		})
		install({
			"folke/trouble.nvim",
			config = function()
				require("safdar.plugins.lsp-trouble")
			end,
		})
		install({
			"glepnir/lspsaga.nvim",
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
			config = function()
				require("safdar.plugins.tsplayground")
			end,
		})
		install({
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		})
		install({
			"p00f/nvim-ts-rainbow",
		})
		-- <~

		-- ~> utils
		install({
			"folke/todo-comments.nvim",
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
			config = function()
				require("safdar.plugins.paint")
			end,
		})
		install({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup({})
			end,
		}) -- comment out the blocks of text
		install({
			"andymass/vim-matchup",
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
			config = function()
				require("safdar.plugins.vim-be-good.maps")
			end,
		})
		install({
			"ThePrimeagen/refactoring.nvim",
			config = function()
				require("safdar.plugins.refactoring")
			end,
		})
		install({
			"ThePrimeagen/harpoon", -- the most amazing plugin i have yet discoverd
			config = function()
				require("safdar.plugins.harpoon")
			end,
		})
		-- TODO: work on this plugin as you explore more about git
		install({
			"ThePrimeagen/git-worktree.nvim",
			config = function()
				require("git-worktree").setup({
					change_directory_command = "cd", -- default: "cd",
					update_on_change = true, -- default: true,
					update_on_change_command = "e .", -- default: "e .",
					clearjumps_on_change = true, -- default: true,
					autopush = false, -- default: false,
				})
				require("safdar.plugins.plugins_mappings.git_worktree_map")
			end,
		})
		-- <~

		-- ~> Note Takign Stuff Stuff
		-- norg
		install({
			"nvim-neorg/neorg",
			run = ":Neorg sync-parsers", -- This is the important bit!
			-- ft = "norg",
			requires = {
				"nvim-neorg/neorg-telescope",
			},
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
			ft = { "markdown" },
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
