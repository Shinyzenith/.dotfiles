require('nvim-treesitter.configs').setup {
	ensure_installed = { "c", "rust", "zig", "go", "v" },
	sync_install = false,
	auto_install = true,
	ignore_install = { "javascript" },

	hightlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlight = false,
	},
}
