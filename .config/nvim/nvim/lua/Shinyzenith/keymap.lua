-- Lsp stuff
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
		vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
		vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
		vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
		vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
		vim.keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	end
})

vim.g.mapleader = " "

-- nnoremaps
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("n", "<C-n>", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("n", "<esc>", "<cmd>noh<CR>")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")
vim.keymap.set("n", "<leader>4", "4gt")
vim.keymap.set("n", "<leader>5", "5gt")
vim.keymap.set("n", "<leader>6", "6gt")
vim.keymap.set("n", "<leader>7", "7gt")
vim.keymap.set("n", "<leader>8", "8gt")
vim.keymap.set("n", "<leader>9", "9gt")
vim.keymap.set("n", "<leader>s", "<cmd>:w !sudo tee %<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>p", "\"*yy")
vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<CR>")
vim.keymap.set("n", "<leader>d", "<cmd>TodoTrouble<CR>")
vim.keymap.set('n', '<leader>cc',
	function()
		xpcall(function()
			vim.cmd("Recompile")
		end, function(_err)
			vim.cmd("Compile")
		end)
	end
)

-- tnoremaps
vim.keymap.set("t", "<C-h>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-n>", "<cmd>tabnext<CR>")
vim.keymap.set("t", "<C-p>", "<cmd>tabprev<CR>")

-- vnoremaps
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "<leader>p", "\"*y")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gvi'")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gvi'")
