-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
  local plugins= {
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {
      'numToStr/Comment.nvim',
      opts = {
          -- add any options here
      },
      lazy = false,
    },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
    }
  }

  require("lazy").setup(plugins)

  require("plugins/indent-blankline")
else
  local plugins = {
    {
      -- https://github.com/folke/tokyonight.nvim
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        style = "day",
        transparent = true
      },
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        -- https://github.com/folke/which-key.nvim
      }
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      dependencies = {
          "nvim-tree/nvim-web-devicons",
      },
      keys = {
        { "<Leader>nt", ":NvimTreeToggle<CR>", desc = "ToggleNeoTree"}
      },
      config = function()
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
          require("nvim-tree").setup {}
      end,
    },
    {
      -- synctac highlighting
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate"
    },
    {
      -- file search
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {
      'numToStr/Comment.nvim',
      opts = {
          -- add any options here
      },
      lazy = false,
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lualine').setup()
      end
    },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
    },
    {
      "tpope/vim-fugitive",
      event = "VeryLazy"
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "VeryLazy",
      config = function()
         require('gitsigns').setup({
           signs = {
             add = {
               hl = 'GitSignsAdd',
               text = '+',
               numhl='GitSignsAddNr',
               linehl='GitSignsAddLn'
             },
           }
         })
      end
    }
  }

  require("lazy").setup(plugins)

  require("plugins/nvim-treesitter")
  require("plugins/telescope")
  require("plugins/indent-blankline")

  vim.cmd[[colorscheme tokyonight]]
end

