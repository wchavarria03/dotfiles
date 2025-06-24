-- return {
--   "yetone/avante.nvim",
--   event = "VeryLazy",
--   version = "*",
--   opts = {
--     provider = "copilot",
--   },
--   build = "make",
--   window = {
--     ask = {
--       floating = true,
--     },
--   },
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     "stevearc/dressing.nvim",
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--     --- The below dependencies are optional,
--     "ibhagwan/fzf-lua", -- for file_selector provider fzf
--     "echasnovski/mini.icons",
--     "zbirenbaum/copilot.lua",
--     "MeanderingProgrammer/render-markdown.nvim",
--   },
-- }

return {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = '*',
    opts = {
        -- -@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = 'copilot', -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
        -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
        -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
        -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
        auto_suggestions_provider = 'copilot',
        cursor_applying_provider = nil, -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase
        file_selector = {
            provider = 'snacks',
        },
        providers = {
            claude = {
                endpoint = 'https://api.anthropic.com',
                model = 'claude-3-5-sonnet-20241022',
                extra_request_body = {
                    temperature = 0,
                    max_tokens = 4096,
                },
            },
        },
        behaviour = {
            auto_suggestions = false,
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = true, -- Whether to enable token counting. Default to true.
            enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
            enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
        },

        mappings = {
            diff = {
                ours = 'co',
                theirs = 'ct',
                all_theirs = 'ca',
                both = 'cb',
                cursor = 'cc',
                next = ']x',
                prev = '[x',
            },
            suggestion = {
                accept = '<C-CR>',
                next = '<C-n>',
                prev = '<C-p>',
                dismiss = '<C-]>',
            },
            jump = {
                next = ']]',
                prev = '[[',
            },
            submit = {
                normal = '<CR>',
                insert = '<C-s>',
            },
            cancel = {
                normal = { '<C-c>', '<Esc>', 'q' },
                insert = { '<C-c>' },
            },
            sidebar = {
                apply_all = 'A',
                apply_cursor = 'a',
                retry_user_request = 'r',
                edit_user_request = 'e',
                switch_windows = '<Tab>',
                reverse_switch_windows = '<S-Tab>',
                remove_file = 'd',
                add_file = '@',
                close = { '<Esc>', 'q' },
                close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
            },
        },
        hints = { enabled = true },
        windows = {
            -- -@type "right" | "left" | "top" | "bottom"
            position = 'right', -- the position of the sidebar
            wrap = true, -- similar to vim.o.wrap
            width = 30, -- default % based on available width
            sidebar_header = {
                enabled = true, -- true, false to enable/disable the header
                align = 'center', -- left, center, right for title
                rounded = true,
            },
            input = {
                prefix = '> ',
                height = 8, -- Height of the input window in vertical layout
            },
            edit = {
                border = 'rounded',
                start_insert = true, -- Start insert mode when opening the edit window
            },
            ask = {
                floating = true, -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = true, -- Start insert mode when opening the ask window
                border = 'rounded',
                -- -@type "ours" | "theirs"
                focus_on_apply = 'ours', -- which diff to focus after applying
            },
        },
        diff = {
            autojump = true,
            -- -@type string | fun(): any
            list_opener = 'copen',
            --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
            --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
            --- Disable by setting to -1.
            override_timeoutlen = 500,
        },
        suggestion = {
            debounce = 600,
            throttle = 600,
        },
        ---------------------------------
        --          MCPHub Configs     --
        ---------------------------------
        -- system_prompt as function ensures LLM always has latest MCP server state
        -- This is evaluated for every message, even in existing chats
        system_prompt = function()
            local hub = require('mcphub').get_hub_instance()
            return hub and hub:get_active_servers_prompt() or ''
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
            return {
                require('mcphub.extensions.avante').mcp_tool(),
            }
        end,
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        --- The below dependencies are optional,
        'nvim-tree/nvim-web-devicons',
        'zbirenbaum/copilot.lua', -- for providers='copilot'
        'MeanderingProgrammer/render-markdown.nvim',
    },
}
