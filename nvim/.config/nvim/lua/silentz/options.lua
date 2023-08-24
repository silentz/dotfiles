-- neovim options
local options = {
    backup = false,                 -- don't create a backup file
    clipboard = "unnamedplus",      -- allows neovim to access the system clipboard
    cmdheight = 1,                  -- more space in the neovim command line for displaying messages
    conceallevel = 0,               -- so that `` is visible in markdown files
    fileencoding = "utf-8",         -- the encoding written to a file
    hlsearch = true,                -- highlight all matches on previous search pattern
    ignorecase = true,              -- ignore case in search patterns
    mouse = "a",                    -- allow the mouse to be used in neovim
    showmode = false,               -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,                -- always show tabs
    smartcase = true,               -- smart case
    smartindent = true,             -- make indenting smarter again
    splitbelow = true,              -- force all horizontal splits to go below current window
    splitright = true,              -- force all vertical splits to go to the right of current window
    swapfile = false,               -- creates a swapfile
    termguicolors = true,           -- set term gui colors (most terminals support this)
    timeoutlen = 300,               -- time to wait for a mapped sequence to complete (in milliseconds)
    expandtab = true,               -- convert tabs to spaces
    shiftwidth = 4,                 -- the number of spaces inserted for each indentation
    tabstop = 4,                    -- insert so much spaces for a tab
    cursorline = true,              -- highlight the current line
    number = true,                  -- set numbered lines
    relativenumber = false,         -- set relative numbered lines
    numberwidth = 4,                -- set number column width to 4 {default 4}
    writebackup = false,            -- if file is being edited by another program, it's not allowed to be edited
    undofile = true,                -- enable persistent undo
    signcolumn = "yes",             -- always show the sign column
    wrap = true,                    -- display lines as one long line
    linebreak = true,               -- companion to wrap, don't split words
    scrolloff = 8,                  -- minimal number of screen lines to keep above and below the cursor
    sidescrolloff = 8,              -- minimal number of screen columns either side of cursor
    guifont = "monospace:h17",      -- the font used in graphical neovim applications
    whichwrap = "bs<>[]hl",         -- which "horizontal" keys are allowed to travel to prev/next line
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- separate vim plugins from neovim in case vim still in use
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
