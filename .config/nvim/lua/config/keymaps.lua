vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

local job_id = 0
vim.keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  -- vim.api.nvim_open_win(0, false, { relative = 'win', row = 3, col = 3, width = 12, height = 3 })

  job_id = vim.bo.channel
end)
vim.keymap.set({ "n", "t" }, "<leader>sft", "<cmd>Floaterminal<CR>")

vim.keymap.set("n", "<leader>example", function()
  -- make
  -- gobuild
  -- go test ./<filename>
  vim.fn.chansend(job_id, { "ls -la\r\n" })
end)

vim.keymap.set("n", "-", "<cmd>Oil<CR>")

vim.keymap.set("n", "<leader>rb", "<cmd>ToggleBool<CR>")
