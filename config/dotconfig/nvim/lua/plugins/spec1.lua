return {
	{ "ajmwagar/vim-deus", priority = 10000 },
	{ "ctrlpvim/ctrlp.vim" }, --Swiss knife for opening & finding files
	{ "rhysd/conflict-marker.vim" }, -- Conflict detection and custom highlighting, TODO: can this be replcaed with coc-git?
	{ "unblevable/quick-scope" },
	{ "junegunn/goyo.vim" }, --Adds Goyo mode, which hides unnecessary visual clutter temporarily
	{ "rhysd/git-messenger.vim" }, --"Way to check previous git commits in-line
	-- Plug 'vimwiki/vimwiki'
	{ "itchyny/lightline.vim" }, -- Tab and statusline plugin

	--IDE-like features
	{ "neoclide/coc.nvim", branch = "release", build = ":CocUpdateSync" },
	-- Good syntax highlighting
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	{ "liuchengxu/vim-which-key" }, --WhichKey keybind helper tool

	-- Haskell specific plugins
	{ "alx741/vim-hindent", ft = "haskell" }, --Haskell autoformatting
	{ "Twinside/vim-haskellFold", ft = "haskell" }, -- improved haskell foldinfo

	--Pandoc syntax support (an usable pandoc-flavoured latex supporting markdown etc. compiler)
	-- { 'vim-pandoc/vim-pandoc'
	-- { 'vim-pandoc/vim-pandoc-syntax'
	{ "lervag/vimtex", ft = "tex" }, --"Latex support
	-- In testing currently
	{ "AndrewRadev/tagalong.vim", ft = { "html", "jsx", "tsx", "svelte" } }, --Change both ends of a pair of html tags when editing tags
	-- Plug 'zsugabubus/crazy8.nvim'
	{ "norcalli/nvim-colorizer.lua" }, --Hex and css color highlighting
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

	{ "github/copilot.vim" }, --"Github copilot
	-- https://github.com/zbirenbaum/copilot.lua has more features but more effort to setup
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		config = true,
	},
}
