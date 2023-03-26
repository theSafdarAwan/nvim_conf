local function config()
	local greyjoy = require("greyjoy")
	greyjoy.setup({
		output_results = "buffer",
		last_first = true,
		extensions = {
			generic = {
				commands = {
					["gcc main.c"] = {
						command = { "gcc", "main.c" },
						filetype = "c",
						filename = "main.c",
					},
					["run {filename}"] = {
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