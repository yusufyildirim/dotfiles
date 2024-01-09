vim.g.mapleader = " "
-- Prevent space from moving to the f*n right
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- A saner way to navigate between lines up and down.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


vim.keymap.set("n", "<leader>fe", vim.cmd.Ex, { desc = "[F]ile [E]xplorer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

