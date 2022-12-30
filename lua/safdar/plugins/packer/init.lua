-- NOTE: if you are trying to lazy_load using the lazy-loader
-- functions then there should be only three keys in the plugin table
-- 1) opt
-- 2) setup
-- 3) config
-- If you have requires key then it may break so move that to a separate key.

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

	-- lazy loader
	["TheSafdarAwan/lazy-loader.nvim"] = {
		after = "impatient.nvim",
		config = function()
			require("safdar.plugins.lazy-loader")
		end,
	},

	["antoinemadec/FixCursorHold.nvim"] = {
		after = "impatient.nvim",
		run = function()
			vim.g.curshold_updatime = 100
		end,
	},
	["norcalli/profiler.nvim"] = {
		opt = true,
		config = function()
			require("profiler")
		end,
	},
	["dstein64/vim-startuptime"] = {
		opt = true,
		cmd = { "StartupTime" },
	},
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
		opt = true,
		setup = function()
			local plugin = {
				name = "telescope.nvim",
				before_load = {
					config = function()
						require("fused").lazy_load("telescope")
					end,
				},
				on_load = {
					config = function()
						require("safdar.plugins.telescope").telescope()
					end,
				},
				keymap = {
					keys = require("safdar.plugins.telescope.maps").packer_keys,
				},
			}
			require("lazy-loader").loader(plugin)
		end,
	},
	["nvim-telescope/telescope-fzf-native.nvim"] = {
		after = "telescope.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		config = function()
			require("safdar.plugins.telescope.telescope-plugins").fzf()
		end,
	},
	-- TODO: look into telescope plugin ans config for searching
	-- ["nvim-telescope/telescope-live-grep-args.nvim"] = {
	-- 	after = "telescope-fzf-native.nvim",
	-- },
	["LukasPietzschmann/telescope-tabs"] = {
		after = "telescope-fzf-native.nvim",
		config = function()
			require("safdar.plugins.telescope.telescope-plugins").tabs()
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
		opt = true,
		setup = function()
			local plugin = {
				name = "nvim-surround",
				on_load = {
					config = function()
						require("safdar.plugins.surround")
					end,
				},
				keymap = {
					keys = {
						{ "v", "S" },
						{ "n", "cs" },
						{ "n", "ds" },
						{ "n", "ys" },
						{ "n", "yS" },
						{ "n", "ca" },
						{ "n", "da" },
					},
				},
			}
			require("lazy-loader").loader(plugin)
		end,
		-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
	},
	["RRethy/vim-illuminate"] = {
		config = function()
			require("safdar.plugins.illuminate")
		end,
		event = { "CursorMoved" },
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
		keys = { "gF", "go", "g," },
		config = function()
			require("safdar.plugins.focus")
		end,
		cmd = { "FocusToggle", "FocusEnable" },
	},
	-- <~

	----------------------------------------------------------------------
	--                          ~> Git                                  --
	----------------------------------------------------------------------
	["lewis6991/gitsigns.nvim"] = {
		opt = true,
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
	["rcarriga/nvim-notify"] = {
		after = "impatient.nvim",
	},
	["kyazdani42/nvim-web-devicons"] = {
		config = function()
			require("safdar.plugins.web-dev-icons")
			require("fused").lazy_load("devicons")
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
	["b0o/schemastore.nvim"] = { event = { "VimEnter", "BufRead" } }, -- for json schemas
	["neovim/nvim-lspconfig"] = {
		after = "schemastore.nvim",
		config = function()
			require("safdar.lsp.lsp")
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("safdar.lsp.null-ls")
			require("safdar.plugins.plugins_mappings.null-ls_map")
		end,
	},

	["AckslD/nvim-FeMaco.lua"] = { -- edit code from the markdown and norg file using the lsp
		opt = true,
		setup = function()
			local femaco = {
				name = "nvim-FeMaco.lua",
				autocmd = {
					ft_ext = { "md", "norg" },
				},
			}
			require("lazy-loader").loader(femaco)
		end,
		config = function()
			require("femaco").setup()
			require("safdar.plugins.plugins_mappings.FeMaco_map")
		end,
	},
	-- ~> linting files that null_ls does not support
	["dense-analysis/ale"] = {
		opt = true,
		setup = function()
			local ale = {
				name = "ale",
				autocmd = {
					ft_ext = "html",
				},
			}
			require("lazy-loader").loader(ale)
		end,
		config = function()
			require("safdar.plugins.ale")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                ~> Completion and Snippets                        --
	----------------------------------------------------------------------
	["hrsh7th/nvim-cmp"] = {
		evnet = "InsertEnter",
		setup = function()
			require("fused").lazy_load("cmp")
		end,
		config = function()
			require("safdar.lsp.cmp")
		end,
	},
	["hrsh7th/cmp-nvim-lsp"] = {
		after = "nvim-cmp",
		config = function()
			require("safdar.lsp.cmp.cmp-nvim-lsp")
		end,
	},
	["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },
	["hrsh7th/cmp-nvim-lsp-signature-help"] = { after = { "cmp-buffer" } },
	["hrsh7th/cmp-emoji"] = { after = "cmp-nvim-lsp-signature-help" },

	["hrsh7th/cmp-nvim-lua"] = {
		opt = true,
		setup = function()
			local plugin = {
				name = "cmp-nvim-lua",
				autocmd = {
					event = "InsertEnter",
					ft = "lua",
				},
			}
			require("lazy-loader").loader(plugin)
		end,
	},

	["tzachar/cmp-tabnine"] = {
		disable = true,
		opt = true,
		run = "./install.sh",
		setup = function()
			local tabnine = {
				name = "cmp-tabnine",
				autocmd = {
					events = "InsertEnter",
				},
			}
			require("lazy-loader").loader(tabnine)
		end,
		config = function()
			require("safdar.plugins.tabnine")
		end,
	},

	["uga-rosa/cmp-dictionary"] = {
		opt = true,
		-- event = "InsertEnter",
		-- ft = { "markdown", "norg", "html" },
		setup = function()
			local cmp_dictionary = {
				name = "cmp-dictionary",
				autocmd = {
					ft_ext = { "md", "html", "norg" },
					events = "InsertEnter",
				},
			}
			require("lazy-loader").loader(cmp_dictionary)
		end,
		config = function()
			require("safdar.plugins.cmp.cmp-dictionary")
		end,
	},

	-- snippets
	["L3MON4D3/LuaSnip"] = {
		opt = true,
		after = "nvim-cmp",
		setup = function()
			local luasnip = {
				name = "LuaSnip",
				autocmd = {
					events = "InsertEnter",
				},
			}
			require("lazy-loader").loader(luasnip)
		end,
		config = function()
			require("safdar.plugins.luasnip")
		end,
	},
	["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },

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
		opt = true,
		setup = function()
			require("fused").lazy_load("lspsaga")
			local plugin = {
				name = "lspsaga.nvim",
				keymap = {
					keys = {
						"[k",
						"[l",
						"]]",
						"[[",
						"gh",
						"gd",
					},
				},
			}
			require("lazy-loader").loader(plugin)
		end,
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
			{ "n", "gca" },
		},
	},
	["filipdutescu/renamer.nvim"] = {
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("safdar.plugins.renamer")
			require("fused").lazy_load("renamer")
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
		keys = { { "n", "_" } },
		requires = { "theHamsta/nvim-dap-virtual-text", after = "nvim-dap-ui" },
	},
	-- <~

	----------------------------------------------------------------------
	--                        ~> Treesitter                             --
	----------------------------------------------------------------------
	["nvim-treesitter/nvim-treesitter"] = {
		opt = true,
		setup = function()
			local nvim_ts = {
				name = "nvim-treesitter",
			}
			require("lazy-loader").loader(nvim_ts)
		end,
		after = "plenary.nvim",
		run = ":TSUpdate",
		config = function()
			require("safdar.plugins.treesitter")
		end,
	},
	["nvim-treesitter/playground"] = {
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
		config = function()
			require("safdar.plugins.tsplayground")
		end,
	},
	["folke/paint.nvim"] = {
		opt = true,
		after = "impatient.nvim",
		config = function()
			require("safdar.plugins.paint")
		end,
	},
	["windwp/nvim-ts-autotag"] = {
		opt = true,
		setup = function()
			local ts_autotag = {
				name = "nvim-ts-autotag",
				autocmd = { ft_ext = "*.html" },
			}
			require("lazy-loader").loader(ts_autotag)
		end,
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	["p00f/nvim-ts-rainbow"] = {
		after = "nvim-treesitter",
		config = function()
			require("fused").lazy_load("tsrainbow")
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                           ~> Utils                               --
	----------------------------------------------------------------------
	["windwp/nvim-autopairs"] = {
		opt = true,
		setup = function()
			local autopairs = {
				name = "nvim-autopairs",
				autocmd = {
					events = { "InsertEnter" },
				},
			}
			require("lazy-loader").loader(autopairs)
		end,
		config = function()
			require("safdar.plugins.autopairs")
		end,
	},
	["andymass/vim-matchup"] = { -- don't do lazy loading wit vim-matchup it breaks things
		after = "nvim-treesitter",
		config = function()
			require("safdar.plugins.vim-matchup")
		end,
	},
	["norcalli/nvim-colorizer.lua"] = {
		after = "nvim-autopairs",
		config = function()
			require("safdar.plugins.colorizer")
		end,
	}, -- shows the colors
	["mbbill/undotree"] = {
		opt = true,
		setup = function()
			local plugin = {
				name = "undotree",
				on_load = {
					config = function()
						require("safdar.plugins.markdown-preview")
					end,
				},
				keymap = {
					keys = {
						"<leader>u",
					},
				},
			}
			require("lazy-loader").loader(plugin)
		end,
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
		opt = true,
		cmd = "VimBeGood",
		setup = function()
			local vim_be_good = {
				name = "vim-be-good",
				keymap = {
					keys = {
						{ "n", "<leader>gg" },
					},
				},
			}
			require("lazy-loader").loader(vim_be_good)
		end,
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
		opt = true,
		setup = function()
			local plugin = {
				name = "harpoon",
				-- for harpoon telescope plugin
				requies = { "telescope.nvim" },
				before_load = {
					config = function()
						require("fused").lazy_load("harpoon")
					end,
				},
				on_load = {
					config = function()
						require("safdar.plugins.harpoon")
					end,
				},
				keymap = {
					keys = require("safdar.plugins.harpoon.maps").packer_keys,
				},
			}
			require("lazy-loader").loader(plugin)
		end,
	},
	-- TODO: work on this plugin as you explore more about git
	["ThePrimeagen/git-worktree.nvim"] = {
		after = "telescope.nvim",
		config = function()
			require("git-worktree").setup({
				change_directory_command = "cd", -- default: "cd",
				update_on_change = true, -- default: true,
				update_on_change_command = "e .", -- default: "e .",
				clearjumps_on_change = true, -- default: true,
				autopush = false, -- default: false,
			})
			require("safdar.plugins.plugins_mappings.git_worktree_map")
			require("safdar.plugins.telescope.telescope-plugins").git_worktree()
		end,
	},
	-- <~

	----------------------------------------------------------------------
	--                    ~> Note Takign Stuff Stuff                    --
	----------------------------------------------------------------------
	["nvim-neorg/neorg"] = {
		opt = true,
		setup = function()
			local lazy_load = {
				name = "neorg",
				-- on_load = {
				-- 	-- cmd = "Neorg gtd capture",
				-- 	config = function()
				-- 		require("safdar.plugins.neorg").load_conf()
				-- 	end,
				-- },
				-- keymap = {
				-- 	keys = { "gtc" },
				-- },
				autocmd = {
					ft_ext = "norg",
				},
			}
			require("lazy-loader").loader(lazy_load)
		end,
		run = ":Neorg sync-parsers", -- This is the important bit!
	},
	["nvim-neorg/neorg-telescope"] = { after = "neorg" },
	["iamcco/markdown-preview.nvim"] = {
		opt = true,
		setup = function()
			local md_preview = {
				name = "markdown-preview.nvim",
				on_load = {
					config = function()
						require("safdar.plugins.markdown-preview")
					end,
				},
				autocmd = {
					ft = "markdown",
					keymap = {
						keys = { "<leader>mp" },
					},
				},
			}
			require("lazy-loader").loader(md_preview)
		end,
		run = function()
			vim.fn["mkdp#util#install"]()
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
