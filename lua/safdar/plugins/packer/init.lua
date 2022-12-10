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

local plugins = {
	["wbthomason/packer.nvim"] = { -- packer can manage itself
		opt = true,
		cmd = require("safdar.core.utils").packer_cmds,
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
		event = "BufWinEnter",
		keys = require("safdar.plugins.telescope.maps").packer_keys,
		module_pattern = "telescope.*",
		config = function()
			require("safdar.plugins.telescope")
			require("fused").lazy_load("telescope")
		end,
	},
	["nvim-telescope/telescope-fzf-native.nvim"] = {
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		requires = {
			event = "BufRead",
			"nvim-telescope/telescope-live-grep-args.nvim",
			after = "telescope-fzf-native.nvim",
		},
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
	["shaunsingh/nord.nvim"] = {},
	-- <~

	----------------------------------------------------------------------
	--                   ~> Navigation and enhancements                 --
	----------------------------------------------------------------------
	["kyazdani42/nvim-tree.lua"] = {
		config = function()
			require("safdar.plugins.nvim-tree")
			require("fused").lazy_load("nvimtree")
		end,
	},
	["kylechui/nvim-surround"] = {
		keys = {
			{ "v", "S" },
			{ "n", "cs" },
			{ "n", "ds" },
			{ "n", "ys" },
			{ "n", "yS" },
			{ "n", "ca" },
			{ "n", "da" },
		},
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
		setup = function()
			local gitsigns = { name = "gitsigns.nvim" }
			require("safdar.core.lazy_load").load.gitsigns(gitsigns)
		end,
		config = function()
			require("safdar.plugins.gitsigns")
		end,
	},
	["TimUntersberger/neogit"] = {
		keys = { { "n", "ygo" }, { "n", "ygc" } },
		config = function()
			require("safdar.plugins.neogit")
			require("fused").lazy_load("neogit")
		end,
	},
	["sindrets/diffview.nvim"] = {
		keys = { { "n", "ygd" }, { "n", "ygD" } },
		config = function()
			require("safdar.plugins.diffview")
			require("fused").lazy_load("diffview")
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
			require("fused").lazy_load("indentblankline")
		end,
	}, -- indent guides
	-- <~

	----------------------------------------------------------------------
	--                            ~> Lsp                                --
	----------------------------------------------------------------------
	["neovim/nvim-lspconfig"] = {
		opt = true,
		cmd = require("safdar.core.lazy_load").lsp_cmds,
		setup = function()
			local plugin = {
				name = "nvim-lspconfig",
			}
			require("safdar.core.lazy_load").load.loader(plugin)
		end,
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
		opt = true,
		setup = function()
			local femaco = {
				name = "nvim-FeMaco.lua",
				pattern = { "*.md", "*.norg" },
			}
			require("safdar.core.lazy_load").load.loader(femaco)
		end,
		config = function()
			require("femaco").setup()
			require("safdar.plugins.plugins_mappings.FeMaco_map")
		end,
	},
	-- ~> linting files that null_ls does not support
	["dense-analysis/ale"] = {
		setup = function()
			local ale = {
				name = "ale",
				pattern = { "*.html" },
			}
			require("safdar.core.lazy_load").load.loader(ale)
		end,
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
		setup = function()
			local nvim_cmp = { name = "nvim-cmp", event = "InsertEnter" }
			require("safdar.core.lazy_load").load.loader(nvim_cmp)
		end,
		config = function()
			require("safdar.lsp.cmp")
			require("fused").lazy_load("cmp")
		end,
	},
	["hrsh7th/cmp-nvim-lsp"] = {
		after = "nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = { "cmp-buffer" } },
			{ "hrsh7th/cmp-emoji", key = { "i", ":" } },
		},
	},
	["hrsh7th/cmp-nvim-lua"] = { ft = "lua" },

	["tzachar/cmp-tabnine"] = {
		run = "./install.sh",
		setup = function()
			local tabnine = {
				name = "cmp-tabnine",
				events = "InsertEnter",
			}
			require("safdar.core.lazy_load").load.loader(tabnine)
		end,
		config = function()
			require("safdar.plugins.tabnine")
		end,
	},

	["uga-rosa/cmp-dictionary"] = {
		event = "InsertEnter",
		ft = { "markdown", "norg", "html" },
		config = function()
			require("safdar.plugins.cmp.cmp-dictionary")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                ~> Lsp utils & enhancements                       --
	----------------------------------------------------------------------
	["ray-x/lsp_signature.nvim"] = {
		event = "InsertEnter",
		after = "nvim-lspconfig",
		config = function()
			require("safdar.plugins.lspsignature")
		end,
	},
	["folke/trouble.nvim"] = {
		keys = { "n", "[" },
		config = function()
			require("safdar.plugins.lsp-trouble")
			require("fused").lazy_load("trouble")
		end,
	},
	["glepnir/lspsaga.nvim"] = {
		after = "trouble.nvim",
		config = function()
			require("safdar.plugins.lspsaga")
			require("fused").lazy_load("lspsaga")
		end,
	},
	["weilbith/nvim-code-action-menu"] = {
		config = function()
			require("safdar.plugins.code-action-menu")
		end,
		cmd = "CodeActionMenu",
		keys = {
			{ "n", "gca" },
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
		after = "nvim-dap-virtual-text",
		config = function()
			require("safdar.plugins.dap")
			--> plugins configs
			require("safdar.plugins.dap.dap-ui")
			require("safdar.plugins.dap.dap-virtual-text")
		end,
	},
	["rcarriga/nvim-dap-ui"] = {
		requires = { "theHamsta/nvim-dap-virtual-text", after = "nvim-dap-ui" },
		keys = { { "n", "_" } },
		setup = function()
			local cmp_dictionary = {
				name = "cmp-dictionary",
				events = "InsertEnter",
				pattern = { "*.md", "*.html", "*.norg" },
			}
			require("safdar.core.lazy_load").load.loader(cmp_dictionary)
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                        ~> Treesitter                             --
	----------------------------------------------------------------------
	["nvim-treesitter/nvim-treesitter"] = {
		setup = function()
			local nvim_ts = {
				name = "nvim-treesitter",
			}
			require("safdar.core.lazy_load").load.loader(nvim_ts)
		end,
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
		after = "impatient.nvim",
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
		config = function()
			require("fused").lazy_load("tsrainbow")
		end,
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
		keys = { "CursorMoved" },
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
			{ "v", "gc" },
			{ "n", "gc" },
		},
		config = function()
			require("Comment").setup({})
		end,
	}, -- comment out the blocks of text
	["folke/todo-comments.nvim"] = {
		event = "BufWinEnter",
		config = function()
			require("safdar.plugins.todo-comments")
			require("fused").lazy_load("todocomments")
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
		keys = { "<leader>t", "<leader>a" },
		config = function()
			require("safdar.plugins.harpoon")
			require("fused").lazy_load("harpoon")
		end,
	},
	-- TODO: work on this plugin as you explore more about git
	["ThePrimeagen/git-worktree.nvim"] = {
		keys = { { "n", "<leader>gw" } },
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
		ft = "norg",
		setup = function()
			local neorg = {
				name = "neorg",
			}
			require("safdar.core.lazy_load").load.neorg(neorg)
		end,
		keys = { "n", "gtc" },
		module_pattern = {
			"neorg.modules.*",
			"neorg.modules.core.integrations.telescope.module",
		},
		run = ":Neorg sync-parsers", -- This is the important bit!
		requires = {
			"nvim-neorg/neorg-telescope",
		},
		config = function()
			require("safdar.plugins.neorg")
			require("fused").lazy_load("neorg")
		end,
	},
	["iamcco/markdown-preview.nvim"] = {
		key = { "n", "<leader>mp" },
		setup = function()
			local md_preview = {
				name = "markdown-preview.nvim",
				pattern = "*.md",
			}
			require("safdar.core.lazy_load").load.loader(md_preview)
		end,
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
