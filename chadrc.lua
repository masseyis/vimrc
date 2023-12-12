---@type ChadrcConfig
local M = {}
--if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
  vim.o.guifont = "Hasklug Nerd Font Mono,MesloLGS NF,Roboto Mon,Soource Code Pro:h13"
--end
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prog = "/Users/james/.pyenv/shims/python3"
-- Automatically format JSON with jq
vim.api.nvim_exec([[
  autocmd FileType json nnoremap <buffer> <leader>f :%!jq '.'<CR>
]], false)

M.ui = { theme = 'catppuccin' }
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"
return M
