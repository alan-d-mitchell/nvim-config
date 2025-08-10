 return {
     "nvim-lualine/lualine.nvim",
     dependencies = { "nvim-tree/nvim-web-devicons" },
     config = function()
         local lualine = require("lualine")
         local lazy_status = require("lazy.status") -- to configure lazy pending updates count

         local colors = {
             blue = "#7e9cd8",        -- crystalBlue
             green = "#98bb6c",       -- springGreen
             violet = "#957fb8",      -- oniViolet
             yellow = "#e6c384",      -- carpYellow
             red = "#c34043",         -- autumnRed
             fg = "#dcd7ba",          -- fujiWhite
             bg = "#1f1f28",          -- sumiInk0
             inactive_bg = "#223249", -- waveBlue1
             semilightgray = "#727169",
         }

         local my_lualine_theme = {
             normal = {
                 a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
                 b = { bg = "none", fg = colors.fg },
                 c = { bg = "none", fg = colors.fg },
             },
             insert = {
                 a = { bg = colors.green, fg = colors.bg, gui = "bold" },
                 b = { bg = "none", fg = colors.fg },
                 c = { bg = "none", fg = colors.fg },
             },
             visual = {
                 a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
                 b = { bg = "none", fg = colors.fg },
                 c = { bg = "none", fg = colors.fg },
             },
             command = {
                 a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
                 b = { bg = "none", fg = colors.fg },
                 c = { bg = "none", fg = colors.fg },
             },
             replace = {
                 a = { bg = colors.red, fg = colors.bg, gui = "bold" },
                 b = { bg = "none", fg = colors.fg },
                 c = { bg = "none", fg = colors.fg },
             },
             inactive = {
                 a = { bg = "none", fg = colors.semilightgray, gui = "bold" },
                 b = { bg = "none", fg = colors.semilightgray },
                 c = { bg = "none", fg = colors.semilightgray },
             },
         }

         -- configure lualine with modified theme
         lualine.setup({
             options = {
                 theme = my_lualine_theme,
             },
             sections = {
                 lualine_x = {
                     {
                         lazy_status.updates,
                         cond = lazy_status.has_updates,
                         color = { fg = "#ff9e64" },
                     },
                     { "encoding" },
                     { "fileformat" },
                     { "filetype" },
                 },
             },
         })
     end,
 }
