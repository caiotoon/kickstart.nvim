return {
	'theprimeagen/harpoon',
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set('n', '<C-a>', mark.add_file)
		vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

		vim.keymap.set('n', '<C-9>', ui.nav_next)
		vim.keymap.set('n', '<C-0>', ui.nav_prev)
	end
}
