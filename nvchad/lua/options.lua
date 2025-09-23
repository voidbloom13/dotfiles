require "nvchad.options"

-- add yours here!

local o = vim.o
local hl = vim.api.nvim_set_hl
hl(0, "LineNrAbove", { fg = "cyan" })
hl(0, "LineNr", { fg = "magenta" })
hl(0, "LineNrBelow", { fg = "cyan" })
hl(0, "NeoTreeNormal", { bg = "NONE" })
hl(0, "NeoTreeNormalNC", { bg = "NONE" })
