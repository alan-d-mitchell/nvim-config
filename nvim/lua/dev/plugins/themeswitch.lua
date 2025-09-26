return {
    {
        "thesimonho/kanagawa-paper.nvim",
        lazy = true, -- Load only when needed
        config = function()
            require('kanagawa-paper').setup({
                transparent = true,

                styles = {
                    comments = {
                        italics = false,
                    },
                },
            })
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        config = function()
            require("rose-pine").setup({
                variant = "moon", -- Set moon as the variant

                styles = {
                    transparency = true,
                    italic = false, -- Disable italics
                },
            })
        end,
    },
    {
        "vague2k/vague.nvim",
        lazy = true,
        config = function()
            require("vague").setup({
                transparent = true,
                italic = false,
            })
        end
    },
    {
        "datsfilipe/vesper.nvim", 
        lazy = false, -- Keep as default
        priority = 1000,
        config = function()
            -- Path to store the current theme
            local theme_file = vim.fn.stdpath("data") .. "/current_theme.txt"

            require('vesper').setup({
                transparent = true,

                italics = {
                    comments = false,
                    keywords = false,
                    functions = false,
                    strings = false,
                    variables = false,
                },
            })

            -- Available colorschemes
            local colorschemes = {
                vesper = "vesper",
                kanagawa = "kanagawa-paper",
                rosepine = "rose-pine-moon",
                vague = "vague"
            }

            -- Function to save current theme
            local function save_theme(theme_name)
                local file = io.open(theme_file, "w")
                if file then
                    file:write(theme_name)
                    file:close()
                end
            end

            -- Function to load saved theme
            local function load_saved_theme()
                local file = io.open(theme_file, "r")
                if file then
                    local theme_name = file:read("*line")
                    file:close()
                    return theme_name
                end
                return "vague" -- default fallback
            end

            -- Function to safely set colorscheme
            local function set_colorscheme(name)
                local scheme = colorschemes[name]
                if not scheme then
                    vim.notify("Colorscheme '" .. name .. "' not found!", vim.log.levels.ERROR)
                    return false
                end

                local ok, _ = pcall(vim.cmd.colorscheme, scheme)
                if ok then
                    save_theme(name) -- Save the theme when successfully set

                    return true
                else
                    vim.notify("Failed to load " .. name .. " colorscheme", vim.log.levels.ERROR)
                    return false
                end
            end

            -- Load and set the saved theme on startup
            local saved_theme = load_saved_theme()
            set_colorscheme(saved_theme)

            -- Create user commands
            vim.api.nvim_create_user_command("ColorVesper", function()
                set_colorscheme("vesper")
            end, { desc = "Switch to Vesper colorscheme" })

            vim.api.nvim_create_user_command("ColorKanagawa", function()
                set_colorscheme("kanagawa")
            end, { desc = "Switch to Kanagawa Paper colorscheme" })

            vim.api.nvim_create_user_command("ColorRosePine", function()
                set_colorscheme("rosepine")
            end, { desc = "Switch to Rose Pine Moon colorscheme" })

            vim.api.nvim_create_user_command("ColorVague", function()
                set_colorscheme("vague")
            end, { desc = "Switch to Vague colorscheme "})

            -- Generic command that takes colorscheme name as argument
            vim.api.nvim_create_user_command("SwitchTheme", function(opts)
                local name = opts.args
                if name == "" then
                    -- Show available colorschemes if no argument provided
                    local available = {}
                    for key, _ in pairs(colorschemes) do
                        table.insert(available, key)
                    end
                    vim.notify("Available colorschemes: " .. table.concat(available, ", "), vim.log.levels.INFO)
                else
                    set_colorscheme(name)
                end
            end, { 
                    nargs = "?", 
                    complete = function()
                        local options = {}
                        for key, _ in pairs(colorschemes) do
                            table.insert(options, key)
                        end
                        return options
                    end,
                    desc = "Switch colorscheme (shows available options if no args)" 
                })

            -- Keymaps for quick switching
            local keymap = vim.keymap
            keymap.set("n", "<leader>cv", function() set_colorscheme("vesper") end, { desc = "Switch to Vesper" })
            keymap.set("n", "<leader>ck", function() set_colorscheme("kanagawa") end, { desc = "Switch to Kanagawa" })
            keymap.set("n", "<leader>cr", function() set_colorscheme("rosepine") end, { desc = "Switch to Rose Pine Moon" })
            keymap.set("n", "<leader>ca", function() set_colorscheme("vague") end, { desc = "Switch to Vague" })

            -- Cycle through colorschemes
            local scheme_list = {"vesper", "kanagawa", "rosepine"}

            -- Set current_index based on saved theme
            local current_index = 1
            for i, theme in ipairs(scheme_list) do
                if theme == saved_theme then
                    current_index = i
                    break
                end
            end

            keymap.set("n", "<leader>cn", function()
                current_index = current_index % #scheme_list + 1
                set_colorscheme(scheme_list[current_index])
            end, { desc = "Cycle to next colorscheme" })

            keymap.set("n", "<leader>cp", function()
                current_index = current_index - 1
                if current_index < 1 then
                    current_index = #scheme_list
                end
                set_colorscheme(scheme_list[current_index])
            end, { desc = "Cycle to previous colorscheme" })
        end,
        opts = {},
    }
}

