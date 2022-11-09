local vim = vim
local dap = require("dap")
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    print("Debugger Initialised")
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    print("Debugger Terminated")
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    print("Debugger Exited")
    dapui.close()
end

-- adapters
local dapAdapters = {
    "js-dap",
}
for _, adapters in ipairs(dapAdapters) do
    require("safdar.dap.adapters." .. adapters)
end

local fn = vim.fn
fn.sign_define(
    "DapBreakpoint",
    { text = "ß", texthl = "@attribute", linehl = "", numhl = "" }
)
fn.sign_define(
    "DapBreakpointCondition",
    { text = "", texthl = "@warning", linehl = "", numhl = "" }
)
fn.sign_define("DapStopped", { text = "ඞ", texthl = "@error" })
fn.sign_define(
    "DapLogPoint",
    { text = "", texthl = "@keyword", linehl = "", numhl = "" }
)
