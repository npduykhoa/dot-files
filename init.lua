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
vim.g.mapleader=' '

require("lazy").setup(
  {
    { 'nvim-lua/plenary.nvim', priority=1000 },
    { 'nvim-lua/popup.nvim', priority=1000 },
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('plugins.lspconfig').setup()
      end
    },
    { 'neoclide/coc.nvim', branch='release' },
    {
      'echasnovski/mini.nvim', priority=1000,
      config = function()
        require('plugins.mini').setup()
      end
    },
    {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('plugins.lualine').setup()
      end
    },
    {
      'folke/tokyonight.nvim', priority=1000, lazy = false,
      config = function()
        require('plugins.theme').setup()
      end
    },
    { 'kyazdani42/nvim-web-devicons', event = "BufRead" },
    {
      'nvim-telescope/telescope.nvim', event='VimEnter',
      dependencies = {
        { 'nvim-telescope/telescope-file-browser.nvim', event='BufRead' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build='make', event='BufRead' },
        { 'nvim-telescope/telescope-project.nvim', event='BufRead' },
        {
          'axkirillov/easypick.nvim',
          config = function()
            require('plugins.easypick').setup()
          end
        },
      },
      config = function()
        require('plugins.telescope').setup()
      end
    },
    {
      'ryenguyen7411/any-jump.vim', branch='develop', event='BufRead',
      config = function()
        require('plugins.any_jump').setup()
      end
    },
    {
      'sindrets/diffview.nvim', lazy=true, event='VimEnter',
      config = function()
        require('plugins.diffview').setup()
      end
    },
    {
      'lukas-reineke/indent-blankline.nvim', event='BufRead',
      config = function()
        require('plugins.indent_blankline').setup()
      end
    },
    { 'shellRaining/hlchunk.nvim', event='BufRead' },
    {
      'nvim-treesitter/nvim-treesitter', build=':TSUpdate', event='VimEnter',
      dependencies = {
        { 'windwp/nvim-ts-autotag', event='BufRead' },
        { 'JoosepAlviste/nvim-ts-context-commentstring', event='BufRead' },
        { 'HiPhish/nvim-ts-rainbow2', event='BufRead' },
      },
      config = function()
        require('plugins.treesitter').setup()
      end
    },
    { 'tpope/vim-commentary', event='BufRead' },
    {
      'akinsho/toggleterm.nvim', version = "*",
      config = function()
        require('plugins.toggleterm').setup()
      end
    },
    { 'f-person/git-blame.nvim', event='BufRead' },
    { 'tpope/vim-fugitive', event='BufRead' },
    { 'airblade/vim-gitgutter', event='BufRead' },
    { 'SirVer/ultisnips', event='BufRead' },
    { 'honza/vim-snippets', event='BufRead' },
    {
      'windwp/nvim-autopairs', event='BufRead',
      config = function()
        require('plugins.autopair').setup()
      end
    },
  }, {
  ui = {
    border = 'double',
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
});

require("autocmds")
require("settings")
require("mappings")
