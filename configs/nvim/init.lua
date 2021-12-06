local api, cmd, fn, g, opt, wo = vim.api, vim.cmd, vim.fn, vim.g, vim.opt, vim.wo

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

----- Plugins -----
local paq = require('paq-nvim').paq
--- Icons
paq {'kyazdani42/nvim-web-devicons'}
-- Git
paq {'nvim-lua/plenary.nvim'}
paq {'lewis6991/gitsigns.nvim'}
paq {'sindrets/diffview.nvim'}
paq {'TimUntersberger/neogit'}
-- Autopairs
paq {'windwp/nvim-autopairs'}
-- Indent guides
paq {'lukas-reineke/indent-blankline.nvim'}
-- Whitespaces
paq {'ntpeters/vim-better-whitespace'}
-- editor config
paq {'editorconfig/editorconfig-vim'}
-- Theme
paq {'rktjmp/lush.nvim'}
paq {'sainnhe/gruvbox-material'}
-- Lualine
paq {'nvim-lualine/lualine.nvim'}
-- File browser
paq {'kyazdani42/nvim-tree.lua'}
-- Cursors
paq {'terryma/vim-multiple-cursors'}
--- Root
paq {'ygm2/rooter.nvim'}
-- Comments
paq {'b3nj5m1n/kommentary'}
-- ALE
paq {'dense-analysis/ale'}
-- Languages support
paq {'nvim-treesitter/nvim-treesitter', run='TSUpdate'}
-- Telescope
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}
-- LSP
paq {'neovim/nvim-lspconfig'}
paq {'hrsh7th/nvim-cmp'}
paq {'hrsh7th/cmp-nvim-lsp'}
paq {'hrsh7th/cmp-buffer'}
paq {'hrsh7th/cmp-path'}
paq {'hrsh7th/cmp-cmdline'}
--- Tabs
paq {'romgrk/barbar.nvim'}

----- OPTIONS -----
local indent, width = 2, 120

opt.textwidth = width
opt.background = 'dark'
opt.dictionary = '/usr/share/dict/words'
opt.langmenu = 'en_US.UTF-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.autoread = true
opt.backup = false
opt.wb = false
opt.swapfile = false
opt.shell = 'zsh'
opt.clipboard = 'unnamed'

opt.scrolloff = 1
opt.laststatus = 2
opt.cursorline = true
opt.mouse = 'a'
opt.title = false
opt.autoread = true
opt.confirm = true
--opt.dir = ~/.cache/vim
opt.history=1000
opt.modeline = false
opt.tabstop=4
opt.shiftwidth=4
opt.expandtab= true

cmd 'set termguicolors'
cmd 'colorscheme gruvbox-material'
--cmd 'filetype plugin indent on'
cmd 'syntax on'

api.nvim_exec(
[[
autocmd Filetype html         setlocal ts=2 sw=2 expandtab
autocmd Filetype yaml         setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby         setlocal ts=2 sw=2 expandtab
autocmd Filetype vim          setlocal ts=2 sw=2 expandtab
autocmd Filetype json         setlocal ts=2 sw=2 expandtab
autocmd Filetype css          setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript   setlocal ts=2 sw=2 expandtab
autocmd Filetype python       setlocal ts=4 sw=4 expandtab

autocmd BufRead,BufNewFile *.j2   set ft=htmldjango

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]],
true)

----- HOTKEYS -----
g['mapleader'] = ','

map('n', '<Leader>n',    '<cmd>NvimTreeToggle<CR>')
map('n', '<Leader>tn',   '<cmd>tabnew<CR>')
map('n', '<Leader>b',    '<cmd>Gitsigns toggle_current_line_blame<CR>')
map('n', '<Leader>gdo',    '<cmd>DiffviewOpen<CR>')
map('n', '<Leader>gdc',    '<cmd>DiffviewClose<CR>')
map('n', '<Leader>gdh',    '<cmd>DiffviewFileHistory<CR>')
map('n', '<Leader>gm',    '<cmd>Neogit<CR>')

--- telescope
map('n', '<Leader>ff',    "<cmd>lua require('telescope.builtin').find_files()<CR>")
map('n', '<Leader>fg',    "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map('n', '<Leader>gf',    "<cmd>lua require('telescope.builtin').git_files()<CR>")
map('n', '<Leader>gc',    "<cmd>lua require('telescope.builtin').git_commits()<CR>")
map('n', '<Leader>gb',    "<cmd>lua require('telescope.builtin').git_branches()<CR>")
map('n', '<Leader>gs',    "<cmd>lua require('telescope.builtin').git_status()<CR>")

--- tabs barbar
map('n', '<A-,>', ':BufferPrevious<CR>')
map('n', '<A-.>', ':BufferNext<CR>')
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>')
map('n', '<A->>', ' :BufferMoveNext<CR>')
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>')
map('n', '<A-2>', ':BufferGoto 2<CR>')
map('n', '<A-3>', ':BufferGoto 3<CR>')
map('n', '<A-4>', ':BufferGoto 4<CR>')
map('n', '<A-5>', ':BufferGoto 5<CR>')
map('n', '<A-6>', ':BufferGoto 6<CR>')
map('n', '<A-7>', ':BufferGoto 7<CR>')
map('n', '<A-8>', ':BufferGoto 8<CR>')
map('n', '<A-9>', ':BufferGoto 9<CR>')
map('n', '<A-0>', ':BufferLast<CR>')
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>')
-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>')
-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>')
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>')
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>')

----- Lualine -----
require('statusline')

---- autopairs ------
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

----- INDENT -----

require("indent_blankline").setup {
    buftype_exclude = {"terminal"}
}

----- ROOT -----
g['rooter_pattern'] = {'.git'}
g['outermost_root'] = true

----- TREESITTER -----
require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
}

----- Telescope -----
require('telescope').setup{ 
    defaults = { 
        file_ignore_patterns = {"vendor",".git"} 
    } 
}

----- NVIM TREE -----
g['nvim_tree_gitignore'] = 1
g['nvim_tree_git_hl'] = 1
g['nvim_tree_quit_on_open'] = 1
require'nvim-tree'.setup {
    auto_close = true,
    open_on_setup = false,
    update_focused_file = { enable = true, update_cwd = true },
    view = { hide_root_folder = true }
}

----- ALE -----
g['ale_linters'] = {
    yaml={'yamllint'},
    python={'flake8'}, 
    go={'gofmt', 'gopls', 'govet'}
}
g['ale_fixers'] = {
    python={'black'},
    go={'goimports'}
}
g['ale_fix_on_save'] = true
g['ale_lint_on_save'] = true
g['ale_lint_on_enter'] = true
g['ale_lint_on_text_changed'] = 'never'
g['ale_sign_error'] = ''
g['ale_sign_warning'] = ''
g['ale_sign_highlight_linenrs'] = true
g['ale_change_sign_column_color'] = true
g['ale_echo_msg_error_str'] = 'E'
g['ale_echo_msg_warning_str'] = 'W'
g['ale_echo_msg_format'] = '[%linter%] %s [%severity%]'
g['ale_python_flake8_options'] = '--ignore=W503,E501'
g['ale_python_flake8_use_global'] = true
g['ale_python_black_use_global'] = true

----- LSP -----
cmd 'set completeopt=menuone,noinsert,noselect'

local cmp = require'cmp'

cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
})

 cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.gopls.setup{ on_attach=require'cmp'.on_attach }

----- tabs barbar -----

vim.g.bufferline = {
  animation = true,
  auto_hide = true,
  tabpages = true,
  closable = true,
  clickable = true,
  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},
  icons = true,
  icon_custom_colors = false,
  icon_separator_active = '',
  icon_separator_inactive = '',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',
  insert_at_end = false,
  insert_at_start = false,
  maximum_padding = 1,
  maximum_length = 30,
  semantic_letters = true,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  no_name_title = nil,
}

----- git -----
require'diffview'.setup{}
require('gitsigns').setup({
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '=', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '±', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,
  numhl      = true,
  linehl     = false,
  word_diff  = true,
  current_line_blame = false,
  current_line_blame_opts = {
    delay = 0,
  }
})
require('neogit').setup({
  integrations = {
    diffview = true  
  }
})

----- kommentary -----
require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true
})

