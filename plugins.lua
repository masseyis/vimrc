
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
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
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
    end
  },
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
