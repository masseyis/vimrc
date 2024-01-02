local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
--    ["<leader>h"] = "",
--    ["<C-a>"] = ""
  }
}

-- Your custom mappings
M.abc = {
  n = {
     ["<C-n>"] = {"<cmd> Telescope <CR>", "Telescope"},
     ["<C-s>"] = {":Telescope Files <CR>", "Telescope Files"},
     ["<Leader>di"] = {":VimspectorBalloonEval", "Vimspector balloon"},
     ["<Leader>mm"] = {":lua require(\"harpoon.mark\").add_file()<CR>", "Mark a Harpoon"},
     ["<Leader>mg"] = {":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>", "Harpoon menu"},
     ["<Leader>mt"] = {":Telescope harpoon marks<CR>", "Telescope harpoon marks"},
     ["<C-u>"] = {"<C-u>zz"},
     ["<C-d>"] = {"<C-d>zz"},
     ["n"] = {"nzz"},
     ["N"] = {"Nzz"},
     ["<Leader>gg"] = {":LazyGit<CR>", "LazyGit floating window"},
     ["<Leader>ca"] = {vim.lsp.buf.code_action},
     ["<Leader>rf"] = {vim.lsp.buf.rename},
     ["gt"] = {vim.lsp.buf.type_definition, "Go to typ definition"},
     ["<Leader>rr"] = {vim.lsp.buf.references},
     ["<Leader>rc"] = {vim.lsp.buf.clear_references},
     ["<Leader>ri"] = {vim.lsp.buf.incoming_calls},
     ["<C-h>"] = {":lua require'rust-tools'.hover_actions.hover_actions()<CR>", "Hovr Action"}
  },

  i = {
     ["jk"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
     ["<C-n>"] = {"<cmd> Telescope <CR>", "Telescope"},
     ["<C-s>"] = {":Telescope Files <CR>", "Telescope Files"},
     ["<C-u>"] = {"<C-u>zz"},
     ["<C-d>"] = {"<C-d>zz"},
  },

  v = {
    ["<Leader>ca"] = {vim.lsp.buf.code_action},
    ["<Leader>rf"] = {vim.lsp.buf.rename},
  },
}

return M
