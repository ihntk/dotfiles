return {
	"nvim-treesitter/nvim-treesitter", 
  lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = { "java", "html", "lua" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
