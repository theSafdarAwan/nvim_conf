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

	local ensure_installed = {
		"lua-language-server",
		"bash-language-server",
		"black",
		"chrome-debug-adapter",
		"clang-format",
		"clangd",
		"css-lsp",
		"emmet-ls",
		"eslint-lsp",
		"eslint_d",
		"flake8",
		"gopls",
		"html-lsp",
		"json-lsp",
		"ltex-ls",
		"lua-language-server",
		"luacheck",
		"node-debug2-adapter",
		"prettierd",
		"pyright",
		"rust-analyzer",
		"stylelint-lsp",
		"stylua",
		"tailwindcss-language-server",
		"typescript-language-server",
		"vim-language-server",
	}
	vim.api.nvim_create_user_command("MasonInstallAll", function()
		vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
	end, {})
end

return { config = config }
