local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'christoomey/vim-tmux-navigator',
  -- Git plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set(
          'n',
          '<leader>hp',
          require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = 'Preview git hunk' }
        )
        vim.keymap.set(
          'n',
          '<leader>hs',
          require('gitsigns').stage_hunk,
          { buffer = bufnr, desc = '[S]tage [H]unk' }
        )
        vim.keymap.set(
          'n',
          '<leader>hr',
          require('gitsigns').reset_hunk,
          { buffer = bufnr, desc = '[R]eset [H]unk' }
        )
        vim.keymap.set('v', '<leader>hs', function()
          require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { buffer = bufnr, desc = '[S]tage [H]unk' })
        vim.keymap.set('v', '<leader>hr', function()
          require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { buffer = bufnr, desc = '[R]eset [H]unk' })
        vim.keymap.set(
          'n',
          '<leader>hu',
          require('gitsigns').undo_stage_hunk,
          { buffer = bufnr, desc = '[U]ndo Stage [H]unk' }
        )
        vim.keymap.set(
          'n',
          '<leader>tb',
          require('gitsigns').toggle_current_line_blame,
          { buffer = bufnr, desc = '[T]oggle Line [B]lame' }
        )

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'darker',
    },
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = { { 'filename', path = 1 } },
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():append()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<A-j>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<A-k>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<A-l>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<A-;>', function()
        harpoon:list():select(4)
      end)
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  { 'folke/which-key.nvim', opts = {} },

  {
    'rmagatti/auto-session',
    opts = {
      log_level = 'error',

      cwd_change_handling = {
        post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
          require('lualine').refresh() -- refresh lualine so the new session name is displayed in the status bar
        end,
      },
    },
  },

  -- require 'yusufyildirim.plugins.autoformat',
  -- require 'yusufyildirim.plugins.nvim-lint',
  -- require 'yusufyildirim.plugins.none-ls',
  require 'yusufyildirim.plugins.conform',

  -- Testing setup
  -- {
  -- 	"nvim-neotest/neotest",
  -- 	dependencies = {
  -- 		"nvim-lua/plenary.nvim",
  -- 		"nvim-treesitter/nvim-treesitter",
  -- 		"antoinemadec/FixCursorHold.nvim",
  -- 		"nvim-neotest/neotest-jest"
  -- 	},
  -- 	opts = function(_, opts)
  -- 		opts.adapters = {
  -- 			require('neotest-jest')({})
  -- 		}
  -- 	end,
  -- 	-- opts = {
  -- 	-- 	adapters = {
  -- 	-- 	-- require("neotest-jest")
  -- 	-- 	}
  -- 	-- },
  -- 	keys = {
  -- 		{
  -- 			"<leader>tt",
  -- 			function() require("neotest").run.run(vim.fn.expand("%")) end,
  -- 			desc =
  -- 			"Run File"
  -- 		},
  -- 		{
  -- 			"<leader>tT",
  -- 			function() require("neotest").run.run(vim.loop.cwd()) end,
  -- 			desc =
  -- 			"Run All Test Files"
  -- 		},
  -- 		{
  -- 			"<leader>tr",
  -- 			function() require("neotest").run.run() end,
  -- 			desc =
  -- 			"Run Nearest"
  -- 		},
  -- 		{
  -- 			"<leader>ts",
  -- 			function() require("neotest").summary.toggle() end,
  -- 			desc =
  -- 			"Toggle Summary"
  -- 		},
  -- 		{
  -- 			"<leader>to",
  -- 			function() require("neotest").output.open({ enter = false, auto_close = true }) end,
  -- 			desc =
  -- 			"Show Output"
  -- 		},
  -- 		{
  -- 			"<leader>tO",
  -- 			function() require("neotest").output_panel.toggle() end,
  -- 			desc =
  -- 			"Toggle Output Panel"
  -- 		},
  -- 		{
  -- 			"<leader>tS",
  -- 			function() require("neotest").run.stop() end,
  -- 			desc =
  -- 			"Stop"
  -- 		},
  -- 	},
  -- },
}, {})

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.g.tmux_navigator_disable_when_zoomed = 1
vim.o.sessionoptions =
  'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
