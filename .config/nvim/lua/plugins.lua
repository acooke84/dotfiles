local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'
  end

  -- Plugins
  local function plugins(use)
    use { 'wbthomason/packer.nvim' }

    -- Load only when require
    use { 'nvim-lua/plenary.nvim', module = 'plenary' }

    -- Colorscheme
    use { 'ellisonleao/gruvbox.nvim', }
    use { 'folke/tokyonight.nvim', }
    use { 'catppuccin/nvim', as = 'catppuccin', }

    -- UI
    use {
      'kyazdani42/nvim-web-devicons',
      config = function()
	      require('nvim-web-devicons').setup { default = true }
      end,
    }
    use {
      'goolord/alpha-nvim',
      config = function()
        require('config.alpha').setup()
      end
    }
    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('config.lualine').setup()
      end,
      disable = false,
    }
    use {
      'akinsho/bufferline.nvim',
      config = function()
        require('config.bufferline').setup()
      end,
      branch = 'main',
      event = 'BufWinEnter',
      disable = false,
    }
    use {
      'levouh/tint.nvim',
      config = function()
        require('tint').setup()
      end,
    }

    -- Markdown
    use {
      'iamcco/markdown-preview.nvim',
      opt = true,
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = 'markdown',
      cmd = { 'MarkdownPreview' },
    }
    use {
      'jakewvincent/mkdnflow.nvim',
      config = function()
        require('mkdnflow').setup {}
      end,
      ft = 'markdown',
    }
    use {
      'nvim-neorg/neorg',
      config = function()
        require('neorg').setup {
          load = {
            ['core.defaults'] = {},
            ['core.presenter'] = {
              config = {
                zen_mode = 'truezen',
              }
            }
          }
        }
      end,
      ft = 'norg',
      require = { 'nvim-lua/plenary.nvim', 'Pocco81/TrueZen.nvim' },
      disable = true,
    }

    -- Jumps
    use {
      'ggandor/leap.nvim',
      keys = { 's', 'S', },
      config = function()
        local leap = require('leap')
        leap.add_default_mappings()
      end,
      disable = false,
    }
    use {
      'abecodes/tabout.nvim',
      after = { 'nvim-cmp' },
      config = function()
        require('tabout').setup {
          completion = false,
          ignore_beginning = true,
        }
      end,
    }

    -- Trouble
    use {
      'folke/trouble.nvim',
      config = function()
        require('trouble').setup()
      end
    }

    -- nvim-tree
    use {
      "nvim-tree/nvim-tree.lua",
      opt = true,
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      event = { "VimEnter" },
      config = function()
	      require('config.telescope').setup()
      end,
      requires = {
        { 'nvim-telescope/telescope-file-browser.nvim' },
      }
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('config.treesitter').setup()
      end,
      requires = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'BufReadPre' },
      }
    }

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('config.lsp').setup()
      end,
      requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim'
      }
    }

    -- Completion
    use {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      opt = true,
      config = function()
        require('config.cmp').setup()
      end,
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'ray-x/cmp-treesitter',
        'saadparwaiz1/cmp_luasnip',
        {
          'L3MON4D3/LuaSnip',
          config = function()
            require('config.snip').setup()
          end,
        },
        { 'onsails/lspkind-nvim', module = { 'lspkind' } },
      }
    }

    -- autopairs
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup()
      end,
    }
    use {
      'windwp/nvim-ts-autotag',
      config = function()
        require('nvim-ts-autotag').setup()
      end
    }

    -- Whichkey
    use {
      'folke/which-key.nvim',
      config = function()
	      require('config.whichkey').setup()
      end
    }

    -- Bootstrap Neovim
    if packer_bootstrap then
      print 'Restart Neovim required after installation!'
      require('packer').sync()
    end
  end

  packer_init()
  local packer = require 'packer'
  packer.init(conf)
  packer.startup(plugins)
end

return M
