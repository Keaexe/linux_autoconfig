-- Function to make mapping easier
local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

-- Remap AZERTY to QWERTY for Normal, Visual, and Operator modes
local modes = { 'n', 'v', 'o' }

map(modes, 'a', 'q')
map(modes, 'q', 'a')
map(modes, 'z', 'w')
map(modes, 'w', 'z')
map(modes, 'm', ',') -- M is where comma is on QWERTY
map(modes, ',', 'm')

-- Fix numbers (AZERTY requires Shift for numbers)
-- This allows hitting the top row keys directly for counts/actions
local azerty_top = { "à", "&", "é", '"', "'", "(", "-", "è", "_", "ç" }
for i, key in ipairs(azerty_top) do
    map(modes, key, tostring(i % 10))
end

-- jj for <Esc>
vim.keymap.set("i", "jj", "<ESC>", { silent = true })
