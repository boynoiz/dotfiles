-- stylua: ignore
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Switch buffers
if Util.has("bufferline.nvim") then
  map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

-- map x to d
map("v", "x", "d", { desc = "Cut" })

-- map ; to :
map("n", ";", ":", { desc = "Open command line" })

-- split
map("n", "<leader>ss", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>sv", "<C-W>v", { desc = "Split window right" })

-- save
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })

-- quit
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })
