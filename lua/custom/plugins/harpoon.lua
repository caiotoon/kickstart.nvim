return {
	'theprimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local harpoon = require('harpoon')
		harpoon:setup()

		vim.keymap.set('n', '<C-a>', function() harpoon:list():add() end)
		vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		vim.keymap.set('n', '<C-9>', function() harpoon:list():next({ ui_nav_wrap = true }) end)
		vim.keymap.set('n', '<C-0>', function() harpoon:list():prev({ ui_nav_wrap = true }) end)
	end,
}
