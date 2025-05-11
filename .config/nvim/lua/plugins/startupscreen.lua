return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[                                          ]],
			[[                                          ]],
			[[   ▄████ ▓█████  ▄████▄   ██ ▄█▀ ▒█████   ]],
			[[  ██▒ ▀█▒▓█   ▀ ▒██▀ ▀█   ██▄█▒ ▒██▒  ██▒ ]],
			[[ ▒██░▄▄▄░▒███   ▒▓█    ▄ ▓███▄░ ▒██░  ██▒ ]],
			[[ ░▓█  ██▓▒▓█  ▄ ▒▓▓▄ ▄██▒▓██ █▄ ▒██   ██░ ]],
			[[ ░▒▓███▀▒░▒████▒▒ ▓███▀ ░▒██▒ █▄░ ████▓▒░ ]],
			[[  ░▒   ▒ ░░ ▒░ ░░ ░▒ ▒  ░▒ ▒▒ ▓▒░ ▒░▒░▒░  ]],
			[[   ░   ░  ░ ░  ░  ░  ▒   ░ ░▒ ▒░  ░ ▒ ▒░  ]],
			[[   ░ ░   ░    ░   ░        ░ ░░ ░ ░ ░ ░ ▒ ]],
			[[         ░    ░  ░░ ░      ░  ░       ░ ░ ]],
			[[                                          ]],
			[[                                          ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("SPC f f", "  Find file", ":Telescope find_files<CR>"),
			dashboard.button("SPC f o", "  Recent files", ":Telescope oldfiles<CR>"),
			dashboard.button("SPC f g", "󰱼  Live grep", ":Telescope live_grep<CR>"),
			dashboard.button("SPC e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("SPC q", "  Quit", ":qa<CR>"),
			dashboard.button("SPC u", "  Update plugins", ":Lazy update<CR>"),
      dashboard.button("CTRL n", "  Open Neo tree", ":Neotree filesystem reveal left<CR>")
		}

		alpha.setup(dashboard.opts)
	end,
}
