local vim = vim
local dap = require("dap")

dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {
        os.getenv("HOME")
            .. "/safdar-local/debuggers/vscode-chrome-debug/out/src/chromeDebug.js",
    },
}

dap.configurations.javascript = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}

dap.configurations.typescript = {
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
    },
}
