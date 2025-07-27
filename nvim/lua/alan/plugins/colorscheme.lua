return {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme("kanagawa-paper")
    end,
    opts = {...},
}
