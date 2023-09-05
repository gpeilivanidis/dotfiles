local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
  -- Plugins go here
  use { "wbthomason/packer.nvim"} -- Have packer manage itself
  use { "nvim-lua/plenary.nvim"} -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs"} -- Autopairs, integrates with both cmp and treesitter

  -- colorschemes
  use { "kxzk/skull-vim", as = "skull-vim"}
  use{ 'rose-pine/neovim', as = 'rose-pine' }
  use{ 'AlessandroYorba/Sierra', as = 'sierra' }
  use{ 'romainl/Apprentice', as = 'apprentice' }

  -- neorg
  use {
      "nvim-neorg/neorg",
      run = ":Neorg sync-parsers", -- This is the important bit!
      config = function()
          require('neorg').setup {
              load = {
                  ["core.defaults"] = {}, -- Loads default behaviour
                  ["core.concealer"] = {}, -- Adds pretty icons to your documents
                  ["core.dirman"] = { -- Manages Neorg workspaces
                      config = {
                          workspaces = {
                              ideas = "~/ideas",
                          },
                      },
                  },
              },
          }
      end,
      requires = "nvim-lua/plenary.nvim",
  }

-- Cmp 
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path"} -- path completions
	use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
	use { "hrsh7th/cmp-nvim-lsp" }
	use { "hrsh7th/cmp-nvim-lua" }

	-- Snippets
  use { "L3MON4D3/LuaSnip"} --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

-- LSP
	use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim"} -- simple to use language server installer
  use { "williamboman/mason-lspconfig.nvim" }
	use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate"}

	-- Telescope
	use { "nvim-telescope/telescope.nvim" }

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter"
	}

	-- Git
	use { "lewis6991/gitsigns.nvim"}


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
