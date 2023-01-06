local config = function()
	require("mason").setup({

		-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
		-- packages that are requested to be installed will be put in a queue.
		max_concurrent_installers = 2,

		ui = {
			-- Whether to automatically check for new versions when opening the :Mason window.
			check_outdated_packages_on_open = true,

			-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
			border = "single",

			icons = {
				-- The list icon to use for installed packages.
				package_installed = "",
				-- The list icon to use for packages that are installing, or queued for installation.
				package_pending = "◍",
				-- The list icon to use for packages that are not installed.
				package_uninstalled = "✗",
			},

			keymaps = require("safdar.setup.lsp.mason.maps").mason_maps(),
		},
	})
	require("safdar.setup.lsp.mason.maps").maps()
end

local mason_installer = function()
	-- if the executables are different then the package name then add the
	-- executable name as a value to the package key
	local ensure_installed = {
		["lua-language-server"] = "",
		["bash-language-server"] = "",
		["black"] = "",
		["chrome-debug-adapter"] = "",
		["clang-format"] = "",
		["clangd"] = "",
		["css-lsp"] = "vscode-css-language-server",
		["emmet-ls"] = "",
		["eslint-lsp"] = "vscode-eslint-language-server",
		["eslint_d"] = "",
		["flake8"] = "",
		["gopls"] = "",
		["html-lsp"] = "vscode-html-language-server",
		["json-lsp"] = "vscode-json-language-server",
		["ltex-ls"] = "",
		["luacheck"] = "",
		["node-debug2-adapter"] = "",
		["prettierd"] = "",
		["pyright"] = "",
		["rust-analyzer"] = "",
		["stylelint-lsp"] = "",
		["stylua"] = "",
		["tailwindcss-language-server"] = "",
		["typescript-language-server"] = "",
		["vim-language-server"] = "",
	}

	-- only install packages that are not installed
	local fn = vim.fn
	local not_installed_pkgs = {}
	local already_installed_pkgs = {}
	local packer_path = fn.stdpath("data") .. "/mason/bin/"
	for key, pkg in pairs(ensure_installed) do
		local executable
		if pkg == "" then
			executable = key
		else
			executable = pkg
		end
		if fn.empty(fn.glob(packer_path .. executable)) > 0 then
			not_installed_pkgs[#not_installed_pkgs + 1] = pkg
		else
			already_installed_pkgs[#already_installed_pkgs + 1] = pkg
		end
	end
	vim.api.nvim_create_user_command("MasonInstallAll", function()
		vim.cmd("MasonInstall " .. table.concat(not_installed_pkgs, " "))
	end, {})
	require("safdar.utils").notify(
		"these packages are already installed " .. table.concat(already_installed_pkgs, " ")
	)
end

return { config = config, mason_installer = mason_installer }
