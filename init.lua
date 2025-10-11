--┌───────────────────────────────────────────────────────────────────┐
--│ Author:         Shaedil D.                                        │
--│ Website Link:   https://github.com/Shaedil/vim-config             │
--│ Description:    Optimized version of nvim-lua/kickstart.nvim      │
--│ Last Modified:  10/11/25                                          │
--│ StartUpTimeAvg: ~50 ms                                            │
--└───────────────────────────────────────────────────────────────────┘
-- Vim Settings {{{
-- See `:help vim.o`
vim.cmd('filetype on')
vim.o.showmode = false
vim.o.shortmess = "icfxtoTOlFI"
vim.o.mouse = 'a'
vim.o.confirm = true
vim.o.pumheight = 20
vim.o.swapfile = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
-- gui settings
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.title = true
vim.o.laststatus = 3
vim.cmd('set fillchars=diff:╱')
vim.o.conceallevel = 2
vim.o.guifont = "JetBrainsMono NFM:h9"
vim.g.have_nerd_font = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
--optimizations
vim.o.breakindent = true
vim.o.synmaxcol = 300
vim.o.updatetime = 250
vim.o.timeoutlen = 300
--autocompletion + path + undo
vim.o.path = '.,,**'
vim.go.wildmode = 'longest:full'
vim.go.wildignore =
"*.swip, *.bak, *.pyc, *.class, *.sln, *.Master, *.csproj, *.csproj.user, *.cache, *.dll, *.pdb, *.min.*, */.git/**/*, */.hg/**/*, */.svn/**/*, tags, *.tar.*"
vim.o.undofile = true
-- Fold settings
vim.opt.foldmethod = 'marker'
vim.opt.foldnestmax = 10
vim.opt.foldlevelstart = 0
-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.o.expandtab = true
--}}}
-- Keymappings {{{
-- Defer keymappings to after startup for faster load
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- See `:help vim.keymap.set()`
    local map = vim.keymap.set
    -- aliases vim.keymap.set() to respective vim functions
    -- sets space as <leader> instead of actual leader key
    map({'v', 'n'}, '<Space>', '<Nop>', { silent = true })
    -- Remap for dealing with word wrap
    map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
    map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    -- Mappings for telescope
    map('n', '<leader>sf', '<cmd>Telescope find_files<CR>', { desc = '[S]earch [F]iles' })
    map('n', '<leader>sh', '<cmd>Telescope help_tags<CR>', { desc = '[S]earch [H]elp' })
    map('n', '<leader>sk', '<cmd>Telescope keymaps<CR>', { desc = '[S]earch [K]ey mappings' })
    map('n', '<leader>sw', '<cmd>Telescope grep_string<CR>', { desc = '[S]earch current [W]ord' })
    map('n', '<leader>sg', '<cmd>Telescope live_grep<CR>', { desc = '[S]earch by [G]rep' })
    map('n', '<leader>sd', '<cmd>Telescope diagnostics<CR>', { desc = '[S]earch [D]iagnostics' })
    map('n', '<leader>sm', '<cmd>Telescope marks<CR>', { desc = '[S]earch [M]arks' })
    map('n', '<leader>sp', '<cmd>Telescope projects<CR>', { desc = '[S]earch [P]rojects' })
    map('n', '<leader>u', '<cmd>Telescope undo<CR>', { desc = '[U]ndo tree toggle' })
    -- git
    map('n', "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "[g]it [c]ommits" })
    map('n', "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "[g]it [s]tatus" })
    -- split window nav
    map('n', '<c-h>', '<c-w><c-h>', { desc = 'move focus to the left window' })
    map('n', '<c-j>', '<c-w><c-j>', { desc = 'move focus to the lower window' })
    map('n', '<c-k>', '<c-w><c-k>', { desc = 'move focus to the upper window' })
    map('n', '<c-l>', '<c-w><c-l>', { desc = 'move focus to the right window' })
    -- terminal nav
    map('t', '<c-w>h', '<c-\\><c-n><c-w>h', { desc = 'move focus from terminal to left window' })
    map('t', '<c-w>j', '<c-\\><c-n><c-w>j', { desc = 'move focus from terminal to window below' })
    map('t', '<c-w>k', '<c-\\><c-n><c-w>k', { desc = 'move focus from terminal to window above' })
    map('t', '<c-w>l', '<c-\\><c-n><c-w>l', { desc = 'move focus from terminal to right window' })
    -- split window size
    map('n', '<c-up>', '<c-w>+', { desc = 'vertically size [up] the current window' })
    map('n', '<c-down>', '<c-w>-', { desc = 'vertically size [down] the current window' })
    map('n', '<c-right>', '<c-w>>', { desc = 'horizontally increase size of current window' })
    map('n', '<c-left>', '<c-w><', { desc = 'horizontally decrease size of current window' })
    map('n', '<c-=>', '<c-w>=', { desc = '[=]alize all windows in current tab' })
    map('n', '<c-_>', '<c-w>_', { desc = 'maximize current window size in current tab' })
    -- tab nav gt is default
    map('n', 'gt', '<cmd>tabnext<cr>', { desc = '[g]o [t]o next tab page' })
    map('n', 'th', '<cmd>tabprev<cr>', { desc = '[t]ab to previous tab page' })
    map('n', 'tn', '<cmd>tabnew<cr>', { desc = 'make a [t]ab that is [n]ew' })
    map('n', 'tc', '<cmd>tabclose<cr>', { desc = 'make current [t]ab [c]losed' })
    -- fugitive conflict resolution
    map('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>', { desc = 'start [g]it vertical [d]iff' })
    map('n', 'gdh', '<cmd>diffget //1<cr>', { desc = 'accept change from left (head) in [g]it [d]iff' })
    map('n', 'gdl', '<cmd>diffget //3<cr>', { desc = 'accept change from right (master) in [g]it [d]iff' })
    -- harpoon keybindings
    map('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<cr>', { desc = '[h]arpoon [a]dd file' })
    map('n', '<leader>hm', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { desc = 'open [h]arpoon [m]enu' })
    map('n', '<leader>h1', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', { desc = '[h]arpoon file [1]' })
    map('n', '<leader>h2', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', { desc = '[h]arpoon file [2]' })
    map('n', '<leader>h3', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', { desc = '[h]arpoon file [3]' })
    map('n', '<leader>h4', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', { desc = '[h]arpoon file [4]' })
    map('n', '<leader>h5', '<cmd>lua require("harpoon.ui").nav_file(5)<cr>', { desc = '[h]arpoon file [5]' })
    map('n', '<leader>h6', '<cmd>lua require("harpoon.ui").nav_file(6)<cr>', { desc = '[h]arpoon file [6]' })
    map('n', '<leader>h7', '<cmd>lua require("harpoon.ui").nav_file(7)<cr>', { desc = '[h]arpoon file [7]' })
    map('n', '<leader>h8', '<cmd>lua require("harpoon.ui").nav_file(8)<cr>', { desc = '[h]arpoon file [8]' })
    map('n', '<leader>h9', '<cmd>lua require("harpoon.ui").nav_file(9)<cr>', { desc = '[h]arpoon file [9]' })
    -- replace all is aliased to s
    map('n', 's', ':%s//g<left><left>', { desc = '[s]ubstitute and replace all in buffer' })
    -- diagnostic keymaps
    map('n', '[d', vim.diagnostic.goto_prev, { desc = '[d]iagnostic previous' })
    map('n', ']d', vim.diagnostic.goto_next, { desc = '[d]iagnostic next' })
    map('n', '<leader>e', vim.diagnostic.open_float, { desc = '[d]iagnostic open float' })
    map('n', '<leader>q', vim.diagnostic.setloclist, { desc = '[d]iagnostic set loclist' })
    -- obsidian keymaps
    map('n', '<leader>on', ':ObsidianNew ', { desc = '[o]bsidian [n]ew note' })
    map('n', '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', { desc = '[o]bsidian [o]pen note' })
    map('v', '<leader>ol', ':ObsidianLink ', { desc = '[o]bsidian [l]ink' })
    map('v', '<leader>oln', ':ObsidianLinkNew ', { desc = '[o]bsidian [l]ink [n]ew' })
    map('n', '<leader>or', '<cmd>ObsidianRename<cr>', { desc = '[o]bsidian [r]ename' })
    map('n', '<leader>op', '<cmd>ObsidianPasteImg<cr>', { desc = '[o]bsidian [p]aste image' })
    map('n', '<leader>os', '<cmd>ObsidianSearch<cr>', { desc = '[o]bsidian [s]earch' })
    map('n', '<leader>ob', '<cmd>ObsidianBackLinks<cr>', { desc = '[o]bsidian [b]acklinks' })
  end,
})
-- }}}
-- Custom Functions, Commands & Autocommands {{{
-- A function that deletes all unmodified buffers except current buffer {{{
local function delete_unmodified_buffers_except_current()
  local current_buffer = vim.api.nvim_get_current_buf()
  local all_buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(all_buffers) do
    if buf ~= current_buffer and not vim.api.nvim_buf_get_option(buf, 'modified') then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end
vim.api.nvim_create_user_command('BufOnly', delete_unmodified_buffers_except_current, {})
-- }}}
-- Highlight on yank {{{
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
-- }}}
-- Add checkboxes to *.wiki files {{{
local function setup_conceal()
  local conceal_id1 = pcall(vim.fn.match, vim.fn.bufnr(), 12)
  local conceal_id2 = pcall(vim.fn.match, vim.fn.bufnr(), 13)
  if not conceal_id1 then
    vim.api.nvim_command("call matchadd('Conceal', '\\[\\ \\]', 0, 12, {'conceal': '' })")
  end
  if not conceal_id2 then
    vim.api.nvim_command("call matchadd('Conceal', '\\[X\\]', 0, 13, {'conceal': '' })")
  end
  vim.api.nvim_command("hi def link todoCheckbox Todo")
  vim.api.nvim_set_hl(0, 'Conceal', { ctermbg = 'NONE', ctermfg = 'NONE', bg = 'NONE', fg = 'NONE' })
end
setup_conceal()
-- }}}
-- Disable hlsearch automatically {{{
local ns = vim.api.nvim_create_namespace('toggle_hlsearch')
local function toggle_hlsearch(char)
  if vim.fn.mode() == 'n' then
    local keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end
vim.on_key(toggle_hlsearch, ns)
-- }}}
-- Cleaner folds {{{
vim.cmd([[
function! NeatFoldText()
    let line = substitute(getline(v:foldstart), '/\*\|\*/\|{{{\d\=\|--', '', 'g') "}}}
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '│ ' . printf("%10s", lines_count . ' lines') . ' │'
    let foldchar = ' '
    let foldtextstart = strpart('█' . repeat(foldchar, v:foldlevel) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
]])
-- }}}
-- Forces syntax highlighting for markdown files {{{
vim.api.nvim_command("autocmd BufEnter,BufRead,BufNewFile *.md set syntax=markdown")
-- }}}
-- }}}
-- lazy.nvim Bootstrap {{{
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)
--}}}
-- Plugin Install {{{
require('lazy').setup({
  {'NMAC427/guess-indent.nvim', lazy = true, event = "BufReadPost"},
  {'tpope/vim-rhubarb',
    dependencies = {
      'tpope/vim-fugitive',
    },
    cmd = {
      "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gsplit",
      "Gread", "Gwrite", "Ggrep", "Glgrep", "Gmove", "Gdelete",
      "Gremove", "Gbrowse",
    },
  },
  {'tpope/vim-commentary', keys = {'gc', 'gcc'}},
  {'epwalsh/obsidian.nvim', version = "*", lazy = true, ft = "markdown", dependencies = {"nvim-lua/plenary.nvim" }},
  {'github/copilot.vim', event = "InsertEnter"},
  {'bronson/vim-visual-star-search', keys = {'*', '#', '<leader>*'}, lazy = true},
  {'ThePrimeagen/harpoon', keys = {'<leader>h'}},
  {'tpope/vim-speeddating', keys = { '<C-A>', '<C-X>'}},
  {'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        [[                                              ___  ]],
        [[                                           ,o88888 ]],
        [[       NEOVIM                           ,o8888888' ]],
        [[                  ,:o:o:oooo.        ,8O88Pd8888"  ]],
        [[              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"    ]],
        [[            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"      ]],
        [[           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"        ]],
        [[          , ..:.::o:ooOoOO8O888O8O,COCOO"          ]],
        [[         , . ..:.::o:ooOoOOOO8OOOOCOCO"            ]],
        [[          . ..:.::o:ooOoOoOO8O8OCCCC"o             ]],
        [[             . ..:.::o:ooooOoCoCCC"o:o             ]],
        [[             . ..:.::o:o:,cooooCo"oo:o:            ]],
        [[          `   . . ..:.:cocoooo"'o:o:::'            ]],
        [[          .`   . ..::ccccoc"'o:o:o:::'             ]],
        [[         :.:.    ,c:cccc"':.:.:.:.:.'              ]],
        [[       ..:.:"'`::::c:"'..:.:.:.:.:.'               ]],
        [[     ...:.'.:.::::"'    . . . . .'                 ]],
        [[    .. . ....:."' `   .  . . ''                    ]],
        [[  . . . ...."'                    SATURN           ]],
        [[  .. . ."'                                         ]],
        [[ .                                                 ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("SPC f", " Find file", ":Telescope find_files <CR>"),
        dashboard.button("SPC e", " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("SPC p", " Find project", ":Telescope projects <CR>"),
        dashboard.button("SPC r", " Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("SPC c", " Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("SPC q", " Quit Neovim", ":qa<CR>"),
      }
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          stats.real_cputime = true
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      alpha.setup(dashboard.config)
      vim.cmd([[autocmd User AlphaReady echo 'Alpha is ready']])
    end
  },
  {'iamcco/markdown-preview.nvim',
    ft = "markdown",
    build = 'cd app && npm install',
    init = function() vim.g.mkdp_filetypes = {"markdown"} end
  },
  {'nvim-zh/colorful-winsep.nvim', event = "WinNew"},
  {'onsails/lspkind.nvim', lazy = true },
  {'norcalli/nvim-colorizer.lua', lazy = true, event = "BufReadPost"},
  {'folke/todo-comments.nvim',
    cmd = {"TodoTrouble", "TodoTelescope"},
    event = 'BufReadPost',
    dependencies = {"nvim-lua/plenary.nvim"},
    opts = {
      colors = {
        error = {"DiagnosticError", "ErrorMsg", "#DC2626"},
        warning = {"DiagnosticWarn", "WarningMsg", "#FBBF24"},
        info = {"DiagnosticInfo", "#2563EB"},
        hint = {"DiagnosticHint", "#10B981"},
        default = {"Identifier", "#7C3AED"},
        test = {"Identifier", "#FF00FF"}
      },
    }
  },
  {'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').load()
      vim.cmd.colorscheme 'bamboo'
    end
  },
  {'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    event = "BufReadPost",
    opts = {
      debounce = 100,
      indent = { char = "┊" },
      whitespace = {
        highlight = { "Whitespace", "NonText" },
      },
      scope = {
        char = "▎",
      },
      exclude = {
        filetypes = {
          "alpha", "dashboard", "starter", "TelescopeResults", "TelescopePrompt", "lazy",
          "vimwiki", "NvimTree", "lsp-installer", "checkhealth", "mason",
          "lazyterm", "toggleterm"
        },
        buftypes = {
          "_.*"
        },
      },
    }
  },
  {'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
      local lualine_colors = {
        bg       = '#191919',
        fg       = '#bbc2cf',
        yellow   = '#ECBE7B',
        cyan     = '#008080',
        darkblue = '#081633',
        green    = '#98be65',
        orange   = '#FF8800',
        violet   = '#a9a1e1',
        magenta  = '#c678dd',
        blue     = '#51afef',
        red      = '#ec5f67',
      }
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand('%:p:h')
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }
      local config = {
        options = {
          component_separators = '',
          section_separators = '',
          theme = {
            normal = { c = { fg = lualine_colors.fg, bg = lualine_colors.bg } },
            inactive = { c = { fg = lualine_colors.fg, bg = lualine_colors.bg } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {function()
                return '▊'
              end,
              color = { fg = lualine_colors.blue },
              padding = { right = 1 },
            },
            {'mode',
              color = function()
                local mode_color = {
                  n = lualine_colors.red,
                  i = lualine_colors.green,
                  v = lualine_colors.blue,
                  [''] = lualine_colors.blue,
                  V = lualine_colors.blue,
                  c = lualine_colors.magenta,
                  no = lualine_colors.red,
                  s = lualine_colors.orange,
                  S = lualine_colors.orange,
                  [''] = lualine_colors.orange,
                  ic = lualine_colors.yellow,
                  R = lualine_colors.violet,
                  Rv = lualine_colors.violet,
                  cv = lualine_colors.red,
                  ce = lualine_colors.red,
                  r = lualine_colors.cyan,
                  rm = lualine_colors.cyan,
                  ['r?'] = lualine_colors.cyan,
                  ['!'] = lualine_colors.red,
                  t = lualine_colors.red,
                }
                return { fg = mode_color[vim.fn.mode()] }
              end,
              padding = { right = 1 },
            },
            {'filesize',
              cond = conditions.buffer_not_empty,
            },
            {'filetype',
              colored = true,
              icon_only = true,
            },
            {'filename',
              cond = conditions.buffer_not_empty,
              color = { fg = lualine_colors.magenta, gui = 'bold' },
              symbols = {
                modified = '●',
                alternate_file = '#',
                directory = '',
              }
            },
            {'location'},
            {'progress',
              color = { fg = lualine_colors.fg, gui = 'bold' },
            },
            {'diagnostics',
              sources = { 'nvim_lsp' },
              symbols = { error = ' ', warn = ' ', info = ' ' },
              diagnostics_color = {
                color_error = { fg = lualine_colors.red },
                color_warn = { fg = lualine_colors.yellow },
                color_info = { fg = lualine_colors.cyan },
              },
              sections = { 'error', 'warn', 'info' },
              cond = conditions.hide_in_width,
            },
            {function()
              return '%='
            end,
            },
            {function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end
                return msg
              end,
              icon = ' LSP:',
              color = { fg = lualine_colors.cyan, gui = 'bold' },
            },
          },
          lualine_x = {
            {'o:encoding',
              fmt = string.upper,
              cond = conditions.hide_in_width,
              color = { fg = lualine_colors.green, gui = 'bold' },
            },
            {'fileformat',
              fmt = string.upper,
              icons_enabled = false,
              color = { fg = lualine_colors.green, gui = 'bold' },
              cond = conditions.hide_in_width,
            },
            {'branch',
              icon = '',
              color = { fg = lualine_colors.violet, gui = 'bold' },
            },
            {'diff',
              symbols = { added = ' ', modified = ' ', removed = ' ' },
              diff_color = {
                added = { fg = lualine_colors.green },
                modified = { fg = lualine_colors.orange },
                removed = { fg = lualine_colors.red },
              },
              cond = conditions.hide_in_width,
            },
            {function()
                return '▊'
              end,
              color = { fg = lualine_colors.blue },
              padding = { left = 1 },
            },
          },
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = { 'buffers' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'tabs' },
        },
        extensions = { 'quickfix', 'fugitive' },
      }
      require('lualine').setup(config)
    end
  },
  {'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = {
      current_line_blame_formatter = '<author>, <author_time:%m-%d-%Y> - <summary>',
    }
  },
  {'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = {'BufReadPost', 'BufNewFile'},
    cmd = {'TSUpdateSync', 'TSUpdate', 'TSInstall'},
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<c-backspace>", desc = "Decrement Selection", mode = "x" }
    },
    opts = {
      ensure_installed = {},
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<C-backspace>',
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'ahmedkhalf/project.nvim',
        config = function()
          require('project_nvim').setup({ silent_chdir = true, show_hidden = false })
        end
      },
      {'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {'debugloop/telescope-undo.nvim'},
      {'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font},
      {'nvim-telescope/telescope-ui-select.nvim'},
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
          prompt_prefix = " ",
          selection_caret = " ",
          layout_config = {
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = { "node_modules" },
          path_display = { "truncate" },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-u',
            '-u',
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
          },
          undo = {
            use_delta = true,
            side_by_side = false,
          },
        },
      }
      -- Enable Telescope extensions
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'harpoon')
      pcall(require('telescope').load_extension, 'projects')
      pcall(require('telescope').load_extension, 'undo')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer]' })
    end,
  },
  {'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        {path = '${3rd}/luv/library', words = {'vim%.uv'}},
      },
    },
  },
  {'neovim/nvim-lspconfig',
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      {'mason-org/mason.nvim', opts = {}, cmd = {'Mason', 'MasonInstall', 'MasonUninstall', 'MasonLog', 'MasonUpdate'}},
      {'WhoIsSethDaniel/mason-tool-installer.nvim'},
      {'mason-org/mason-lspconfig.nvim'},
      {'j-hui/fidget.nvim', opts = {}},
      {'saghen/blink.cmp'},
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', {clear = true}),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[G]o to Code [A]ction', { 'n', 'x' })
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })
      -- Diagnostic Config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘ ',
            [vim.diagnostic.severity.WARN] = '⚠ ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = {
      {'L3MON4D3/LuaSnip',
        version = '2.*',
        build = 'make install_jsregexp',
      },
      {'folke/lazydev.nvim'},
    },
    opts = {
      keymap = {preset = 'default'},
      appearance = {nerd_font_variant = 'mono'},
      snippets = {preset = 'luasnip'},
      fuzzy = {implementation = 'lua'},
      signature = {enabled = true},
      completion = {
        documentation = {auto_show = false, auto_show_delay_ms = 500},
      },
      sources = {
        default = {'lsp', 'path', 'snippets', 'lazydev'},
        providers = {
          lazydev = {module = 'lazydev.integrations.blink', score_offset = 100},
        },
      },
    },
  },
})
--}}}
-- Plugin Config {{{
-- Harpoon  {{{
require('harpoon').setup()
-- }}}
-- LSP Signs  {{{
local signs = { Error = "✘ ", Warn = "⚠ ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- }}}
-- Nvim-web-devicons {{{
require('nvim-web-devicons').setup({
  color_icons = true,
  default = true,
  strict = true,
})
-- }}}
-- Colorizer {{{
require 'colorizer'.setup()
-- }}}
-- obsidian.nvim {{{
require("obsidian").setup({
  workspaces = {
    {
      name = "Mind Bank",
      path = "~/iCloudDrive/Mind Bank/"
    },
  },
})
-- }}}
-- }}}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
