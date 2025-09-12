return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup({
			options = {
				-- theme = 'seoul256',
				section_separators = { left = '', right = '' },
				component_separators = { left = '', right = '' }
			},
			tabline = {
				lualine_a = {'buffers'},
				lualine_b = {},
  				lualine_c = {},
  				lualine_x = {{'filename', path = 1}},
  				lualine_y = {},
  				lualine_z = {'tabs'}
			}

		})
	end
}
