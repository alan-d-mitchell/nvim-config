vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.java",
    callback = function()
        local filename = vim.fn.expand("%:t:r")
        local template = {
            "public class " .. filename .. " {",
            "",
            "}"
        }
        vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
    end,
})
