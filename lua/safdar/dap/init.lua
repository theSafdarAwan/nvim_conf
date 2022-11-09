local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    -- dapui.open()
    print("Debugger Initialised")
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    print("Debugger Terminated")
    -- dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

require("safdar.plugins_mappings.dap_map")

-- adapters
-- TODO: chorme debug adapters
require("safdar.dap.adapters.js-node")
-- require("safdar.dap.adapters.js-chrome")
require("safdar.plugins.configs.dap-ui")
require("safdar.plugins.configs.dap-virtual-text")
