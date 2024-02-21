-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            -- REQUIRED
            harpoon:setup()
            -- REQUIRED
            vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end,
                { desc = "Add current file to harpoon" })
            vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Toggle the UI for harpoon" })
            vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end,
                { desc = "Go to first file in harpoon" })
            vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end,
                { desc = "Go to second file in harpoon" })
            vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end,
                { desc = "Go to third file in harpoon" })
            vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end,
                { desc = "Go to fourth file in harpoon" })
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.undotreetoggle)
        end
    },
    {
        "laytan/cloak.nvim",
        opts = {
            enabled = true,
            cloak_character = "*",
            -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
            highlight_group = "Comment",
            patterns = {
                {
                    -- Match any file starting with ".env".
                    -- This can be a table to match multiple file patterns.
                    file_pattern = {
                        ".env*",
                        "wrangler.toml",
                        ".dev.vars",
                    },
                    -- Match an equals sign and any character after it.
                    -- This can also be a table of patterns to cloak,
                    -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
                    cloak_pattern = "=.+"
                },
            },
        }
    },
    {
        "ThePrimeagen/refactoring.nvim",
        opts = {},
        config = function()
            vim.api.nvim_set_keymap(
                "v",
                "<leader>rr",
                ":lua require('refactoring').select_refactor()<CR>",
                { noremap = true, silent = true, expr = false, desc = "Refactor selection" }
            )
        end
    },
    'github/copilot.vim',
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 90,
                options = {
                    number = true,
                    relativenumber = true,
                }
            },
        },
        config = function()
            vim.keymap.set("n", "<leader>zz", function()
                require("zen-mode").toggle()
                vim.wo.wrap = false
            end)
        end
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function()
            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
                { silent = true, noremap = true, desc = "Trouble toggle" })
            vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
                { silent = true, noremap = true, desc = "Trouble quickfix" })
        end
    },

    {
        "mhartington/formatter.nvim",
        opts = {
            logging = true,
            filetype = {
                javascript = {
                    -- prettierd
                    function()
                        return {
                            exe = "prettierd",
                            args = { vim.api.nvim_buf_get_name(0) },
                            stdin = true
                        }
                    end
                },
                typescript = {
                    -- prettierd
                    function()
                        return {
                            exe = "prettierd",
                            args = { vim.api.nvim_buf_get_name(0) },
                            stdin = true
                        }
                    end
                },
                typescriptreact = {
                    -- prettierd
                    function()
                        return {
                            exe = "prettierd",
                            args = { vim.api.nvim_buf_get_name(0) },
                            stdin = true
                        }
                    end
                },
                javascriptreact = {
                    -- prettierd
                    function()
                        return {
                            exe = "prettierd",
                            args = { vim.api.nvim_buf_get_name(0) },
                            stdin = true
                        }
                    end
                }
            }
        },
        config = function()
            vim.keymap.set("n", "<leader>fm", "<cmd>FormatWrite<cr>",
                { silent = true, noremap = true, desc = "Format" })
        end
    },
    {
        'gsuuon/model.nvim',

        -- Don't need these if lazy = false
        cmd = { 'M', 'Model', 'Mchat' },
        init = function()
            vim.filetype.add({
                extension = {
                    mchat = 'mchat',
                }
            })
        end,
        ft = 'mchat',

        keys = {
            { '<C-m>d',       ':Mdelete<cr>', mode = 'n' },
            { '<C-m>s',       ':Mselect<cr>', mode = 'n' },
            { '<C-m><space>', ':Mchat<cr>',   mode = 'n' }
        },

        config = function()
            local llamacpp = require("model.providers.openai")
            local util = require("model.util")
            require("model").setup({
                hl_group = "Substitute",
                prompts = util.module.autoload("prompt_library"),
                default_prompt = {
                    provider = llamacpp,
                    options = {
                        url = "http://localhost:8080/v1/",
                    },
                    builder = function(input)
                        return {
                            model = "gpt-3.5-turbo",
                            messages = {
                                {
                                    role = "system",
                                    content = "You are helpful assistant. Write code for the user prompts.",
                                },
                                { role = "user", content = input },
                            },
                        }
                    end,
                },
            })
        end,
    }
}
