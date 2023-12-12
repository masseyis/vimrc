
local plugins = {
  {"nvim-lua/plenary.nvim"},
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function ()
  --     require "plugins.configs.lspconfig"
  --     require "custom.configs.lspconfig"
  --   end
  -- },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "saecki/crates.nvim",
    ft = {"rust","toml"},
    config = function (_, opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name="crates"})
      return M
    end,
    config = function()
      -- from https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
      -- Completion Plugin Setup
      local cmp = require'cmp'
      cmp.setup({
        -- Enable LSP snippets
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Add tab support
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          })
        },
        -- Installed sources:
        sources = {
          { name = 'path' },                              -- file paths
          { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
          { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
          { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
          { name = 'buffer', keyword_length = 2 },        -- source current buffer
          { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
          { name = 'calc'},                               -- source for math calculation
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = {'menu', 'abbr', 'kind'},
          format = function(entry, item)
            local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
      })
    end
  },
  {"rsh7th/cmp-nvim-lsp"},
  {"hrsh7th/cmp-nvim-lua"},
  {"hrsh7th/cmp-nvim-lsp-signature-help"},
  {"hrsh7th/cmp-vsnip"},
  {"hrsh7th/cmp-path"},
  {"hrsh7th/cmp-buffer"},
  {"hrsh7th/vim-vsnip"},
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup()
    end,
  },
  {"nvim-treesitter",
    config = function ()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "rust", "toml" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting=false,
        },
        ident = { enable = true }, 
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        }
      }
    end,
  },
  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    lazy = false,
    config = function (_, opts)
      require('tabnine').setup({
        disable_auto_comment=true,
        accept_keymap="<C-]>",
        dismiss_keymap = "<C-[>",
        debounce_ms = 800,
        suggestion_color = {gui = "#808080", cterm = 244},
        exclude_filetypes = {"TelescopePrompt", "NvimTree"},
        log_file_path = nil, -- absolute path to Tabnine log file
      })
    end
  },
  {
    "MunifTanjim/nui.nvim",
  },
  {
    "aznhe21/actions-preview.nvim",
    config = function(_,_)
      vim.keymap.set({ "v", "n" }, "<M-Eenter>", require("actions-preview").code_actions)
      require("actions-preview").setup {
        -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
        diff = {
          ctxlen = 3,
        },
        -- priority list of preferred backend
        backend = { "telescope", "nui" },

        -- options related to telescope.nvim
        telescope = vim.tbl_extend(
          "force",
          -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
          require("telescope.themes").get_dropdown(),
          -- a table for customizing content
          {
            -- a function to make a table containing the values to be displayed.
            -- fun(action: Action): { title: string, client_name: string|nil }
            make_value = nil,

            -- a function to make a function to be used in `display` of a entry.
            -- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
            -- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
            make_make_display = nil,
          }
        ),

        -- options for nui.nvim components
        nui = {
          -- component direction. "col" or "row"
          dir = "col",
          -- keymap for selection component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu#keymap
          keymap = nil,
          -- options for nui Layout component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/layout
          layout = {
            position = "50%",
            size = {
              width = "60%",
              height = "90%",
            },
            min_width = 40,
            min_height = 10,
            relative = "editor",
          },
          -- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
          preview = {
            size = "60%",
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
          },
          -- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
          select = {
            size = "40%",
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
          },
        },
      }
    end,
  },
  {
    "puremourning/vimspector",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {"VimspectorInstall","Vimspector"},
    init = function ()
      vim.g.vimspector_enable_mappings = 'HUMAN'
    end,
  },
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    setup = function()
      require("telescope").load_extension('harpoon')
    end
  },
  {
    "lewis6991/gitsigns.nvim",
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "aspeddro/gitui.nvim",
    cmd = {"Gitui"},
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function (_, _)
      require("gitui").setup({
        -- Command Options
        command = {
          -- Enable :Gitui command
          -- @type: bool
          enable = true,
        },
        -- Path to binary
        -- @type: string
        binary = "gitui",
        -- Argumens to gitui
        -- @type: table of string
        args = {},
        -- WIndow Options
        window = {
          options = {
            -- Width window in %
            -- @type: number
            width = 90,
            -- Height window in %
            -- @type: number
            height = 80,
            -- Border Style
            -- Enum: "none", "single", "rounded", "solid" or "shadow"
            -- @type: string
            border = "rounded",
          },
        },
      })
    end
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {"LazyGit"},
  },
}
return plugins
