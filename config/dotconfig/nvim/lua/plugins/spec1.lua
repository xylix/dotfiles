return {
	{
		"ajmwagar/vim-deus",
		dev = false,
		priority = 10000,
		init = function()
			vim.g.deus_termcolors = 256
			vim.cmd("colorscheme deus")
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
			},
		},
	},
	{
		"ctrlpvim/ctrlp.vim",
		init = function()
			-- let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
			vim.g.ctrlp_user_command = 'fd --hidden --type f --color=never "" %s'
			vim.g.ctrlp_use_caching = 0
		end,
	}, --Swiss knife for opening & finding files
	{
		"rhysd/conflict-marker.vim",
		lazy = false,
		init = function()
			-- Disable conflict market feature that requires matchit.vim
			vim.g.conflict_marker_enable_matchit = 0
			--" Replace conflict marker plugin default coloring settings with own
			vim.g.conflict_marker_highlight_group = ""
		end,
		config = function()
			-- vim.schedule runs the setup at the next event loop execution, and this makes it work
			vim.schedule(function()
				vim.api.nvim_set_hl(0, "ConflictMarkerBegin", { bg = "#2f7366" })
				vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = "#2e5049" })
				vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = "#344f69" })
				vim.api.nvim_set_hl(0, "ConflictMarkerEnd", { bg = "#2f628e" })
				-- "Keep none: cn or :ConflictMarkerNone
				-- "Keep ours: co or :ConflictMarkerOurselves
				-- "Keep theirs: ct or :ConflictMarkerThemselves
				-- "Keep both cb or :ConflictMarkerBoth
			end)
		end,
	}, -- Conflict detection and custom highlighting, TODO: can this be replcaed with coc-git?
	{ "unblevable/quick-scope" },
	{
		"junegunn/goyo.vim",
		init = function()
			vim.g.goyo_width = 140
			vim.g.goyo_height = 100
		end,
	}, --Adds Goyo mode, which hides unnecessary visual clutter temporarily
	{ "rhysd/git-messenger.vim" }, --"Way to check previous git commits in-line
	-- Plug 'vimmwiki/vimwiki'
	-- vimwiki configs need to be set before it is loaded
	-- let g:vimwiki_key_mappings = { 'all_maps': 0, }
	-- let g:vimwiki_global_ext = 0
	-- let g:vimwiki_ext2syntax = {}
	-- let g:vimwiki_list = [{'path': '~/logseq-database/', 'path_html': '~/logseq-database/build', 'syntax': 'markdown', 'ext': 'md'}]
	{
		"itchyny/lightline.vim", -- Tab and statusline plugin
		init = function()
			vim.g.lightline = { colorscheme = "deus" }
			vim.laststatus = 2
			vim.showmode = true
		end,
	},

	--IDE-like features
	{
		"neoclide/coc.nvim",
		branch = "release",
		build = ":CocUpdateSync",
		init = function()
			vim.g.coc_global_extensions = {
				"coc-json",
				"coc-git",
				"coc-yaml",
				"coc-pyright",
				"coc-tsserver",
				"coc-vimlsp",
				"coc-sh",
				"coc-snippets",
			} --todo: add coc r lsp and coc-texlab if they good
		end,
	},
	-- Good syntax highlighting
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	{ "liuchengxu/vim-which-key" }, --WhichKey keybind helper tool

	-- Haskell specific plugins
	{ "alx741/vim-hindent", ft = "haskell" }, --Haskell autoformatting
	{ "Twinside/vim-haskellFold", ft = "haskell" }, -- improved haskell foldinfo

	--Pandoc syntax support (an usable pandoc-flavoured latex supporting markdown etc. compiler)
	-- { 'vim-pandoc/vim-pandoc'
	-- "Pandoc config
	--let g:pandoc#spell#enabled = 0
	-- let g:pandoc#modules#disabled = ["folding"]
	-- { 'vim-pandoc/vim-pandoc-syntax'
	{
		"lervag/vimtex", --"Latex support
		ft = "tex",
		init = function()
			vim.g.vimtex_view_method = "skim" -- Choose which program to use to view PDF file
			vim.g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
			vim.g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given
			vim.g.vimtex_quickfix_mode = 0
		end,
	},
	-- In testing currently
	{ "AndrewRadev/tagalong.vim", ft = { "html", "jsx", "tsx", "svelte" } }, --Change both ends of a pair of html tags when editing tags
	-- Plug 'zsugabubus/crazy8.nvim'
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup() -- Call Colorizer setup command to set up filetypes
		end,
	}, --Hex and css color highlighting
	{ "tpope/vim-fugitive" }, -- Git plugin
	{
		"stevearc/aerial.nvim", --Document outline view
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- Plug 'derekelkins/agda-vim'

	{
		"3rd/image.nvim",
		ft = { "markdown", "vimwiki" }, -- The funny hijack file patterns feature won't work with this but this reduces latency for other filetypes by ~30 ms
		cond = { os.getenv("KITTY_WINDOW_ID") ~= "" },
		opts = {
			backend = "kitty",
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
				},
				html = {
					enabled = false,
				},
				css = {
					enabled = false,
				},
			},
			max_width = nil,
			max_height = nil,
			max_width_window_percentage = nil,
			max_height_window_percentage = 50,
			window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
			tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
		},
	}, --inline images

	--endif

	-- Finnish spellchecking
	-- Plug 'git@github.com:xylix/Vimchant.git'
	-- set updatetime=1000
	-- let g:vimchant_spellcheck_lang = 'fi'

	{
		"github/copilot.vim",
		init = function() vim.g.copilot_enabled = 0 end,
	}, --"Github copilot
	-- TODO: consider https://github.com/zbirenbaum/copilot.lua Vaatii vähän setup koska sillä on eri default behaviour mutta ois luaa
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		config = true,
	},
	{ -- Could use this for file picking too, but primarily added to help with browsing highlight groups with `:FzfLua highlights`
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		opts = {},
	},
}
