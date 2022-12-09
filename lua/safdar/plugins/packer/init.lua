-- @packer
local vim = vim

pcall(require, "impatient") -- run :LuaCacheClear

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
	["wbthomason/packer.nvim"] = { -- packer can manage itself
		cmd = packer_cmds,
	},

	----------------------------------------------------------------------
	--                        ~> Performance                            --
	----------------------------------------------------------------------
	["lewis6991/impatient.nvim"] = { -- reduces loadtime
		config = function()
			require("impatient")
			require("impatient").enable_profile()
		end,
	},
	["antoinemadec/FixCursorHold.nvim"] = {
		after = "impatient.nvim",
		run = function()
			vim.g.curshold_updatime = 100
		end,
	},
	["norcalli/profiler.nvim"] = {
		after = "FixCursorHold.nvim",
		config = function()
			require("profiler")
		end,
	},
	["dstein64/vim-startuptime"] = { after = "profiler.nvim", cmd = { "StartupTime" } },
	-- <~

	----------------------------------------------------------------------
	--                   ~> Common Libraries                            --
	----------------------------------------------------------------------
	["nvim-lua/plenary.nvim"] = {},
	["nvim-lua/popup.nvim"] = { after = "plenary.nvim" },
	-- <~

	----------------------------------------------------------------------
	--                        ~> Telescope                              --
	----------------------------------------------------------------------
	["nvim-telescope/telescope.nvim"] = {
		after = "telescope-live-grep-args.nvim",
		module_pattern = "telescope.*",
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "nvim-telescope/telescope-live-grep-args.nvim", after = "telescope-fzf-native.nvim" },
		},
		config = function()
			require("safdar.plugins.telescope")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                      ~> Color Schemes                            --
	----------------------------------------------------------------------
	["TheSafdarAwan/fused.nvim"] = {
		config = function()
			require("safdar.plugins.fused")
		end,
	},
	["ellisonleao/gruvbox.nvim"] = {},
	-- ["catppuccin/nvim"] = {},
	["LunarVim/Colorschemes"] = {},
	["nvchad/base46"] = {
		config = function()
			-- local base46 = require("base46")
			-- base46.load_theme()
			-- base46.load_highlight("treesitter")
		end,
	},
	["folke/tokyonight.nvim"] = {
		-- config = function()
		-- 	require("safdar.plugins.tokyonight")
		-- end,
	},
	["Mofiqul/vscode.nvim"] = {
		cond = function()
			return false
		end,
		config = function()
			require("safdar.plugins.vscode")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                   ~> Navigation and enhancements                 --
	----------------------------------------------------------------------
	["kyazdani42/nvim-tree.lua"] = {
		config = function()
			require("safdar.plugins.nvim-tree")
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
	["RRethy/vim-illuminate"] = {
		config = function()
			require("safdar.plugins.illuminate")
		end,
		event = { "CursorMoved" },
	},
	["abecodes/tabout.nvim"] = {
		config = function()
			require("safdar.plugins.tabout")
		end,
		wants = { "nvim-treesitter" }, -- or require if not used so far
		after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
		event = { "BufRead" },
	},
	["s1n7ax/nvim-window-picker"] = {
		keys = { "n", "gf" },
		tag = "v1.*",
		config = function()
			require("safdar.plugins.window-picker")
		end,
	},
	["sindrets/winshift.nvim"] = { -- move window
		config = function()
			require("safdar.plugins.winshift")
		end,
		cmd = { "WinShift" },
		keys = {
			{ "n", "g;" },
			{ "n", "g:" },
		},
	},
	["beauwilliams/focus.nvim"] = {
		config = function()
			require("safdar.plugins.focus")
		end,
		cmd = { "FocusToggle", "FocusEnable" },
		keys = {
			{ "n", "gF" },
			{ "n", "go" },
			{ "n", "g," },
		},
	},
	-- <~

	----------------------------------------------------------------------
	--                          ~> Git                                  --
	----------------------------------------------------------------------
	["lewis6991/gitsigns.nvim"] = {
		opt = true,
		config = function()
			require("safdar.plugins.gitsigns") -- should be called after other _plugins_configs
		end,
	},
	["TimUntersberger/neogit"] = {
		keys = { { "n", "yso" }, { "n", "ygc" } },
		config = function()
			require("safdar.plugins.neogit")
		end,
	},
	["sindrets/diffview.nvim"] = {
		keys = { { "n", "ygd" }, { "n", "ygD" } },
		config = function()
			require("safdar.plugins.diffview")
		end,
	},

	----------------------------------------------------------------------
	--                     ~> UI                              --
	----------------------------------------------------------------------
	["kyazdani42/nvim-web-devicons"] = {
		config = function()
			require("nvim-web-devicons").setup()
		end,
	}, -- icons for the nvim
	["feline-nvim/feline.nvim"] = {
		after = "nvim-web-devicons",
		config = function()
			require("safdar.plugins.feline")
		end,
	}, -- status line
	["lukas-reineke/indent-blankline.nvim"] = {
		event = "BufReadPost",
		config = function()
			require("safdar.plugins.indent-blank-line")
		end,
	}, -- indent guides
	-- <~

	----------------------------------------------------------------------
	--                            ~> Lsp                                --
	----------------------------------------------------------------------
	["neovim/nvim-lspconfig"] = {
		opt = true,
		module_pattern = { "lspconfig.*" },
		config = function()
			require("safdar.lsp.lsp")
		end,
	},
	["b0o/schemastore.nvim"] = {}, -- for json schemas
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("safdar.lsp.null-ls")
			require("safdar.plugins.plugins_mappings.null-ls_map")
		end,
	},

	["AckslD/nvim-FeMaco.lua"] = { -- edit code from the markdown and neorg file using the lsp
		config = function()
			require("femaco").setup()
			require("safdar.plugins.plugins_mappings.FeMaco_map")
		end,
		ft = { "markdown", "norg" },
	},
	-- ~> linting files that null_ls does not support
	["dense-analysis/ale"] = {
		ft = { "html" },
		config = function()
			require("safdar.plugins.ale")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                ~> Completion and Snippets                        --
	----------------------------------------------------------------------
	["L3MON4D3/LuaSnip"] = {
		after = "impatient.nvim",
		requires = {
			{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
		},
		config = function()
			require("safdar.plugins.luasnip")
		end,
	},

	["hrsh7th/nvim-cmp"] = {
		module = { "nvim-cmp", "cmp" },
		config = function()
			require("safdar.lsp.cmp")
		end,
		requires = {
			{ "hrsh7th/cmp-nvim-lsp", event = "BufRead" },
			{ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
			{ "hrsh7th/cmp-emoji", after = "cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lua", ft = "lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = { "nvim-cmp" } },
		},
		event = "InsertEnter",
	},

	["tzachar/cmp-tabnine"] = {
		run = "./install.sh",
		opt = true,
		config = function()
			require("safdar.plugins.tabnine")
		end,
	},

	["uga-rosa/cmp-dictionary"] = {
		opt = true,
		config = function()
			require("safdar.plugins.cmp.cmp-dictionary")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                ~> Lsp utils & enhancements                       --
	----------------------------------------------------------------------
	["ray-x/lsp_signature.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("safdar.plugins.lspsignature")
		end,
	},
	["folke/trouble.nvim"] = {
		keys = { "n", "[" },
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
	["weilbith/nvim-code-action-menu"] = {
		config = function()
			require("safdar.plugins.code-action-menu")
		end,
		cmd = "CodeActionMenu",
		keys = {
			{ "n", "ca" },
		},
	},
	["filipdutescu/renamer.nvim"] = {
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("safdar.plugins.renamer")
		end,
		keys = {
			{ "n", "yr" },
		},
	},
	-- <~

	----------------------------------------------------------------------
	--                         ~> Debugging                             --
	----------------------------------------------------------------------
	["mfussenegger/nvim-dap"] = {
		keys = { "n", "_" },
		requires = {
			{ "theHamsta/nvim-dap-virtual-text", after = "nvim-dap" },
			{ "rcarriga/nvim-dap-ui", after = "nvim-dap" },
		},
		config = function()
			require("safdar.plugins.dap")
			--> plugins configs
			require("safdar.plugins.dap.dap-ui")
			require("safdar.plugins.dap.dap-virtual-text")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                        ~> Treesitter                             --
	----------------------------------------------------------------------
	["nvim-treesitter/nvim-treesitter"] = {
		after = "plenary.nvim",
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
	["folke/paint.nvim"] = {
		after = "playground",
		config = function()
			require("safdar.plugins.paint")
		end,
	},
	["windwp/nvim-ts-autotag"] = {
		ft = { "html" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	["p00f/nvim-ts-rainbow"] = {
		after = "nvim-ts-autotag",
	},
	-- <~

	----------------------------------------------------------------------
	--                           ~> Utils                               --
	----------------------------------------------------------------------
	["windwp/nvim-autopairs"] = {
		event = "InsertEnter",
		config = function()
			require("safdar.plugins.autopairs")
		end,
	},
	["andymass/vim-matchup"] = {
		event = { "CursorMoved" },
		config = function()
			require("safdar.plugins.vim-matchup")
		end,
	},
	["norcalli/nvim-colorizer.lua"] = {
		after = "vim-matchup",
		config = function()
			require("safdar.plugins.colorizer")
		end,
	}, -- shows the colors
	["mbbill/undotree"] = {
		after = "vim-matchup",
		config = function()
			require("safdar.plugins.undotree.maps")
		end,
	},
	["numToStr/Comment.nvim"] = {
		keys = {
			"gcc",
			"gcb",
			"gcl",
			"gbl",
			"gco",
			"gcO",
			"gca",
		},
		config = function()
			require("Comment").setup({})
		end,
	}, -- comment out the blocks of text
	["folke/todo-comments.nvim"] = {
		opt = true,
		config = function()
			require("safdar.plugins.todo-comments")
		end,
	},
	["s1n7ax/nvim-comment-frame"] = {
		config = function()
			require("safdar.plugins.comment-frame")
		end,
		keys = {
			"<leader>cm",
			"<leader>cl",
		},
	},

	-- <~

	----------------------------------------------------------------------
	--                      ~> ThePrimeagen                             --
	----------------------------------------------------------------------
	["ThePrimeagen/vim-be-good"] = {
		keys = { "n", "<leader>gg" },
		config = function()
			require("safdar.plugins.vim-be-good.maps")
		end,
	},
	["ThePrimeagen/refactoring.nvim"] = {
		keys = { "n", "v" },
		config = function()
			require("safdar.plugins.refactoring")
		end,
	},
	["ThePrimeagen/harpoon"] = { -- the most amazing plugin i have yet discoverd
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

	----------------------------------------------------------------------
	--                    ~> Note Takign Stuff Stuff                    --
	----------------------------------------------------------------------
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
	["iamcco/markdown-preview.nvim"] = {
		ft = "markdown",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require("safdar.plugins.markdown-preview")
		end,
	},
	-- <~
}
local install = {}
for key, value in pairs(plugins) do
	plugins[key][1] = key
	install[#install + 1] = value
end

packer.startup({ install })
