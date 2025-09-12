return {
	"nvim-treesitter/nvim-treesitter", 
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "java", "html", "lua" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
