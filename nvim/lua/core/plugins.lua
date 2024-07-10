-- This command bootstraps lazy.nvim
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

-- Add plugins here
local plugins = {
    { 'catppuccin/nvim', as = 'catppuccin' },
    -- { "rose-pine/neovim", as = "rose-pine" },
    -- 'Mofiqul/dracula.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',
    'nvim-treesitter/nvim-treesitter',

    -- rust
    'simrat39/rust-tools.nvim',

    -- lsp integration
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',

    -- autocompletion and snippet integration
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',

    -- vs-code like snippets
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',

    -- fuzzy finder integration and file tree
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
    },

    -- data science
    {
        'quarto-dev/quarto-nvim',
        dependencies = { 'jmbuhr/otter.nvim' }
    },

    {
        'jpalardy/vim-slime',
        init = function()
            vim.g.slime_target = 'neovim'
            vim.g.slime_python_ipython = 1
            vim.g.slime_dispatch_ipython_pause = 1
            vim.g.slime_cell_delimiter = '#\\s\\=%%'

            vim.cmd [[
            function! _EscapeText_quarto(text)
            if slime#config#resolve("python_ipython") && len(split(a:text,"\n")) > 1
                return ["%cpaste -q\n", slime#config#resolve("dispatch_ipython_pause"), a:text, "--\n"]
            else
                let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
                let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
                let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
                let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
                let except_pat = '\(elif\|else\|except\|finally\)\@!'
                let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
                return substitute(dedented_lines, add_eol_pat, "\n", "g")
            end
            endfunction
            ]]
        end,
        config = function()
            vim.keymap.set({ 'n', 'i' }, '<leader>sc', function()
                vim.cmd [[ call slime#send_cell() ]]
            end, { desc = 'send code cell to terminal' })
        end
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
