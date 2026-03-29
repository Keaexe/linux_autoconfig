-- Function to make mapping easier
local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

-- Remap AZERTY to QWERTY for Normal, Visual, and Operator modes
local modes = { 'n', 'v', 'o' }

map(modes, 'z', 'w')
map(modes, 'w', 'z')

-- jj for <Esc>
vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
