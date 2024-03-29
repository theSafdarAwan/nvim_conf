local function config()
	local greyjoy = require("greyjoy")
	local ui = vim.api.nvim_list_uis()[1]
	greyjoy.setup({
		output_results = "buffer",
		ui = {
			buffer = {
				width = math.floor(ui.width - (ui.width / 6)),
				height = math.floor(ui.height / 1.5),
			},
		},
		last_first = true,
		extensions = {
			generic = {
				commands = {
					["compile main.c"] = {
						command = { "gcc", "main.c" },
						filetype = "c",
						filename = "main.c",
					},
					["run python"] = {
						command = { "python3", "{filename}" },
						filetype = "python",
					},
					["run main.go"] = {
						command = { "go", "run", "main.go" },
						filetype = "go",
						filename = "main.go",
					},
					["build main.go"] = {
						command = { "go", "build", "main.go" },
						filetype = "go",
						filename = "main.go",
					},
					["run lisp"] = {
						command = { "clisp", "{filename}" },
						filetype = "lisp",
					},
				},
			},
			kitchen = {
				targets = { "converge", "verify", "destroy", "test" },
				include_all = false,
			},
		},
		run_groups = { fast = { "generic", "makefile", "cargo" } },
	})

	greyjoy.load_extension("kitchen")
	greyjoy.load_extension("generic")
	-- greyjoy.load_extension("vscode_tasks")
	greyjoy.load_extension("makefile")
	greyjoy.load_extension("cargo")
end
return { config = config }
