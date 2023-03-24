local dap = require("dap")
--[[
dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
        os.getenv("HOME")
            .. "/safdar-local/debuggers/vscode-firefox-debug/dist/adapter.bundle.js",
    },
}
--]]

dap.adapters.chrome = {
	type = "executable",
	command = "node",
	runtimeExecutable = "google-chrome-stable",
	args = {
		vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js",
	},
}

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = {
		vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
	},
}

dap.configurations.javascript = {
	{
		type = "node2",
		name = "node attach",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
	},
	{
		type = "node2",
		name = "node launch file",
		request = "launch",
		program = "${file}",
		cwd = "${workspaceFolder}",
		sourceMaps = true,
		protocol = "inspector",
	},
	{
		name = "Chrome",
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
	-- {
	-- 	type = "chrome",
	-- 	name = "chrome",
	-- 	request = "attach",
	-- 	program = "${file}",
	-- 	-- cwd = "${workspaceFolder}",
	-- 	-- protocol = "inspector",
	-- 	port = 9222,
	-- 	webRoot = "${workspaceFolder}",
	-- 	sourceMaps = true,
	-- 	-- sourceMapPathOverrides = {
	-- 	-- 	-- Sourcemap override for nextjs
	-- 	-- 	["webpack://_N_E/./*"] = "${webRoot}/*",
	-- 	-- 	["webpack:///./*"] = "${webRoot}/*",
	-- 	-- },
	-- },
	--[[
     {
        name = "Debug with Firefox",
        type = "firefox",
        request = "launch",
        reAttach = true,
        -- file = "${workspaceFolder}/indexhtml",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        firefoxExecutable = "/usr/bin/firefox",
    },
    -- ]]
}

-- dap.configurations.javascriptreact = {
--     {
--         type = "chrome",
--         name = "chrome attach",
--         request = "attach",
--         program = "${file}",
--         -- cwd = vim.fn.getcwd(),
--         -- sourceMaps = true,
--         -- protocol = "inspector",
--         port = 9222,
--         sourceMapPathOverrides = {
--             -- Sourcemap override for nextjs
--             -- ["webpack://_N_E/./*"] = "${webRoot}/*",
--             -- ["webpack:///./*"] = "${webRoot}/*",
--         },
--     },
--     {
--         type = "node2",
--         name = "node attach",
--         request = "attach",
--         program = "${file}",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--     },
-- }
--
-- dap.configurations.typescript = {
--     {
--         type = "node2",
--         name = "node attach",
--         request = "attach",
--         program = "${file}",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--     },
--     {
--         type = "node2",
--         name = "node launch file",
--         request = "launch",
--         runtimeExecutable = "node",
--         runtimeArgs = { "--nolazy", "-r", "ts-node/register" },
--         args = { "${file}" },
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--         skipFiles = { "<node_internals>/**", "node_modules/**" },
--     },
--     {
--         type = "chrome",
--         name = "chrome",
--         request = "attach",
--         program = "${file}",
--         -- cwd = "${workspaceFolder}",
--         -- protocol = "inspector",
--         port = 9222,
--         webRoot = "${workspaceFolder}",
--         -- sourceMaps = true,
--         sourceMapPathOverrides = {
--             -- Sourcemap override for nextjs
--             ["webpack://_N_E/./*"] = "${webRoot}/*",
--             ["webpack:///./*"] = "${webRoot}/*",
--         },
--     },
-- }
--
-- dap.configurations.typescriptreact = {
--     {
--         type = "chrome",
--         name = "chrome attach",
--         request = "attach",
--         program = "${file}",
--         -- cwd = "${workspaceFolder}",
--         -- protocol = "inspector",
--         port = 9222,
--         webRoot = "${workspaceFolder}",
--         -- sourceMaps = true,
--         sourceMapPathOverrides = {
--             -- Sourcemap override for nextjs
--             ["webpack://_N_E/./*"] = "${webRoot}/*",
--             ["webpack:///./*"] = "${webRoot}/*",
--         },
--     },
--     {
--         type = "node2",
--         name = "node attach",
--         request = "attach",
--         program = "${file}",
--         cwd = vim.fn.getcwd(),
--         sourceMaps = true,
--         protocol = "inspector",
--     },
-- }
