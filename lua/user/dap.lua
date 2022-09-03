local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

vim.fn.sign_define("dapbreakpoint", { text = "", texthl = "diagnosticsignerror", linehl = "", numhl = "" })
dap.defaults.fallback.terminal_win_cmd = "20split new"
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🧘", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🏃", texthl = "", linehl = "", numhl = "" })

local dap_py_install_status_ok, dap_py = pcall(require, "dap-python")
if not dap_py_install_status_ok then
	return
end

local dap_go_install_status_ok, dap_go = pcall(require, "dap-go")
if not dap_go_install_status_ok then
	return
end

dapui.setup({
	sidebar = {
		elements = {
			{
				id = "scopes",
				size = 0.25, -- Can be float or integer > 1
			},
			{ id = "breakpoints", size = 0.25 },
		},
		size = 40,
		position = "right", -- Can be "left", "right", "top", "bottom"
	},
	tray = {
		elements = {},
	},
})
-- add other configs here
dap_py.setup("~/.virtualenvs/debugpy/bin/python")
dap_py.test_runner = "pytest"
dap_go.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Load Vscode Launcher for debugging
local dap_vscode_status_ok, dap_vscode_config = pcall(require, "dap.ext.vscode")
if not dap_vscode_status_ok then
    return
end
dap_vscode_config.load_launchjs()
