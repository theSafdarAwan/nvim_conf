-- @packer
local vim = vim

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
local packer_cmds = {
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
}
local plugins = {
	["wbthomason/packer.nvim"] = {
		cmd = packer_cmds,
	},
	-- <~

	-- ~> Essential
	["nvim-lua/plenary.nvim"] = {},
	["nvim-lua/popup.nvim"] = {},
	-- <~

	-- ~> Performance
	["lewis6991/impatient.nvim"] = {
		config = function()
			require("impatient")
			require("impatient").enable_profile()
		end,
	},
	["antoinemadec/FixCursorHold.nvim"] = {
		run = function()
			vim.g.curshold_updatime = 100
		end,
	},
	["norcalli/profiler.nvim"] = {
		config = function()
			require("profiler")
		end,
	},
	-- <~

	-- ~> Telescope
	["nvim-telescope/telescope.nvim"] = {
		after = "telescope-fzf-native.nvim",
		config = function()
			require("safdar.plugins.telescope")
		end,
	},
	["nvim-telescope/telescope-fzf-native.nvim"] = {
		after = "plenary.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	-- <~

	-- ~> color scheme
	["TheSafdarAwan/fused.nvim"] = {
		config = function()
			require("safdar.plugins.fused")
		end,
	},
	["ellisonleao/gruvbox.nvim"] = {
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
	},
	-- <~

	-- ~> more productive
	["kyazdani42/nvim-tree.lua"] = {
		config = function()
			require("safdar.plugins.nvim-tree")
		end,
	},
	-- Git stuff
	["lewis6991/gitsigns.nvim"] = {
		opt = true,
		config = function()
			require("safdar.plugins.gitsigns") -- should be called after other _plugins_configs
		end,
	},
	["TimUntersberger/neogit"] = {
		after = "gitsigns.nvim",
		config = function()
			require("safdar.plugins.neogit")
		end,
	},
	["sindrets/diffview.nvim"] = {
		after = "neogit",
		config = function()
			require("safdar.plugins.diffview")
		end,
	},
	["kylechui/nvim-surround"] = {
		opt = true,
		keys = { { "v", "S" }, { "n", "cs" }, { "n", "ds" }, { "n", "ys" }, { "n", "yS" } },
		-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("safdar.plugins.surround")
		end,
	},
	["s1n7ax/nvim-window-picker"] = {
		keys = { "n", "gf" },
		tag = "v1.*",
		config = function()
			require("safdar.plugins.window-picker")
		end,
	},
	-- <~

	-- ~> ui related stuff
	["kyazdani42/nvim-web-devicons"] = {
		config = function()
			require("nvim-web-devicons").setup()
		end,
	}, -- icons for the nvim
	-- use({
	--     "onsails/lspkind-nvim",
	-- }) -- better icons for the lsp
	["lukas-reineke/indent-blankline.nvim"] = {
		config = function()
			require("safdar.plugins.indent-blank-line")
		end,
	}, -- indent guides
	["feline-nvim/feline.nvim"] = {
		after = "nvim-web-devicons",
		config = function()
			require("safdar.plugins.feline")
		end,
	}, -- status line
	-- <~

	-- ~> linting files that null_ls does not support
	["dense-analysis/ale"] = {
		opt = true,
		config = function()
			require("safdar.plugins.ale")
		end,
	},
	-- <~

	-- ~> load luasnips + cmp related in insert mode only
	["neovim/nvim-lspconfig"] = {
		opt = true,
		config = function()
			require("safdar.lsp.lsp")
		end,
	},
	-- this plguin should be loaded before lsp in the lazy-load-packer.lua
	["b0o/schemastore.nvim"] = {},
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("safdar.lsp.null-ls")
			require("safdar.plugins.plugins_mappings.null-ls_map")
		end,
	},

	["L3MON4D3/LuaSnip"] = {
		requires = {
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("safdar.plugins.luasnip")
		end,
	},

	["hrsh7th/nvim-cmp"] = {
		config = function()
			require("safdar.lsp.cmp")
		end,
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	["tzachar/cmp-tabnine"] = {
		run = "./install.sh",
		opt = true,
		config = function()
			require("safdar.plugins.tabnine")
		end,
	},
	["hrsh7th/cmp-nvim-lua"] = {
		opt = true,
	},

	["hrsh7th/cmp-emoji"] = {
		event = "InsertEnter",
	},
	["uga-rosa/cmp-dictionary"] = {
		opt = true,
		config = function()
			require("safdar.plugins.cmp.cmp-dictionary")
		end,
	},
	-- <~

	-- ~> Lsp utils & enhancements
	["ray-x/lsp_signature.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("safdar.plugins.lspsignature")
		end,
	},
	["folke/trouble.nvim"] = {
		after = "lsp_signature.nvim",
		config = function()
			require("safdar.plugins.lsp-trouble")
		end,
	},
	["glepnir/lspsaga.nvim"] = {
		after = "trouble.nvim",
		config = function()
			require("safdar.plugins.lspsaga")
		end,
	},
	["AckslD/nvim-FeMaco.lua"] = {
		config = function()
			require("femaco").setup()
			require("safdar.plugins.plugins_mappings.FeMaco_map")
		end,
		ft = { "markdown", "norg" },
	},
	-- <~

	-- ~> Debugging
	["mfussenegger/nvim-dap"] = {
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
	},
	-- <~

	-- ~> syntax Highlighting
	["nvim-treesitter/nvim-treesitter"] = {
		run = ":TSUpdate",
		config = function()
			require("safdar.plugins.treesitter")
		end,
	},
	["nvim-treesitter/playground"] = {
		after = "nvim-treesitter",
		config = function()
			require("safdar.plugins.tsplayground")
		end,
	},
	["windwp/nvim-ts-autotag"] = {
		after = "playground",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	["p00f/nvim-ts-rainbow"] = {
		after = "nvim-ts-autotag",
	},
	-- <~

	-- ~> utils
	["folke/todo-comments.nvim"] = {
		opt = true,
		config = function()
			require("safdar.plugins.todo-comments")
		end,
	},
	["windwp/nvim-autopairs"] = {
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				map_c_w = true,
			})
		end,
	},
	["folke/paint.nvim"] = {
		after = "nvim-treesitter",
		config = function()
			require("safdar.plugins.paint")
		end,
	},
	["numToStr/Comment.nvim"] = {
		keys = { { "n", "gc" }, { "v", "gc" }, { "v", "gb" }, { "n", "gb" } },
		config = function()
			require("Comment").setup({})
		end,
	}, -- comment out the blocks of text
	["andymass/vim-matchup"] = {
		after = { "nvim-treesitter" },
		config = function()
			require("safdar.plugins.vim-matchup")
		end,
	},
	["norcalli/nvim-colorizer.lua"] = {
		config = function()
			require("safdar.plugins.colorizer")
		end,
	}, -- shows the colors
	["mbbill/undotree"] = {
		config = function()
			require("safdar.plugins.undotree.maps")
		end,
	},
	-- <~

	-- ~> ThePrimeagen coconut oil
	["ThePrimeagen/vim-be-good"] = {
		opt = true,
		keys = { "n", "<leader>gg" },
		config = function()
			require("safdar.plugins.vim-be-good.maps")
		end,
	},
	["ThePrimeagen/refactoring.nvim"] = {
		opt = true,
		keys = { "n", "v" },
		config = function()
			require("safdar.plugins.refactoring")
		end,
	},
	["ThePrimeagen/harpoon"] = { -- the most amazing plugin i have yet discoverd
		opt = true,
		keys = { { "n", "<leader>a" }, { "n", "<leader>t" } },
		config = function()
			require("safdar.plugins.harpoon")
		end,
	},
	-- TODO: work on this plugin as you explore more about git
	["ThePrimeagen/git-worktree.nvim"] = {
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
	},
	-- <~

	-- ~> Note Takign Stuff Stuff
	-- norg
	["nvim-neorg/neorg"] = {
		run = ":Neorg sync-parsers", -- This is the important bit!
		requires = {
			"nvim-neorg/neorg-telescope",
		},
		after = "nvim-lspconfig",
		config = function()
			require("safdar.plugins.neorg")
		end,
	},
	-- Markdwon Plugin
	["iamcco/markdown-preview.nvim"] = {
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require("safdar.plugins.markdown-preview")
		end,
		opt = true,
	},
	-- <~
}
local install = {}
for key, value in pairs(plugins) do
	plugins[key][1] = key
	install[#install + 1] = value
end

packer.startup({ install })
