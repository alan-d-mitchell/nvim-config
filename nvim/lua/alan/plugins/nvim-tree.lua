return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() 
        -- recommended settings
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        local nvimtree = require("nvim-tree").setup()

        local keymap = vim.keymap
        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>") -- toggle tree
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>") -- toggle tree for directory of current file
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>") -- reload
    end
}
