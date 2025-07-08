-- Helper function to safely load Avante API and execute a prompt
local function avante_ask_prompt(prompt_func)
    local ok, avante = pcall(require, 'avante.api')
    if not ok or not avante then
        vim.notify('Avante plugin is not loaded yet. Please try again.', vim.log.levels.ERROR)
        return
    end

    local prompts = require 'config.avante-prompts'
    local prompt = prompt_func(prompts)
    if prompt then
        avante.ask { question = prompt }
    end
end

return {
    'yetone/avante.nvim',
    event = 'VeryLazy', -- Load after other plugins are ready
    cmd = { 'Avante', 'AvanteAsk', 'AvanteDiff' }, -- Command triggers
    keys = {
        {
            '<leader>aC',
            function()
                avante_ask_prompt(function(prompts)
                    return prompts.generate_commit_message()
                end)
            end,
            desc = 'Generate Commit Message',
        },
        {
            '<leader>aP',
            function()
                avante_ask_prompt(function(prompts)
                    return prompts.list_pending_prs()
                end)
            end,
            desc = 'List PRs for Review',
        },
        -- {
        --     '<leader>ar',
        --     function()
        --         avante_ask_prompt(function(prompts)
        --             return prompts.review_current_file()
        --         end)
        --     end,
        --     desc = 'Review Current File',
        -- },
        {
            '<leader>aE',
            function()
                avante_ask_prompt(function(prompts)
                    return prompts.explain_code()
                end)
            end,
            desc = 'Explain Code',
        },
        -- {
        --     '<leader>as',
        --     function()
        --         avante_ask_prompt(function(prompts)
        --             return prompts.general_status()
        --         end)
        --     end,
        --     desc = 'General Status Report',
        -- },
    },
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
            copilot = {
                model = 'claude-3.7-sonnet',
            },
        },
        behaviour = {
            auto_suggestions = true,
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = true, -- Whether to enable token counting. Default to true.
            enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
        },
        prompt_logger = { -- logs prompts to disk (timestamped, for replay/debugging)
            enabled = false, -- Disable logging to improve performance
            log_dir = vim.fn.stdpath 'cache' .. '/avante_prompts', -- directory where logs are saved
            fortune_cookie_on_success = false, -- shows a random fortune after each logged prompt (requires `fortune` installed)
            next_prompt = {
                normal = '<C-n>', -- load the next (newer) prompt log in normal mode
                insert = '<C-n>',
            },
            prev_prompt = {
                normal = '<C-p>', -- load the previous (older) prompt log in normal mode
                insert = '<C-p>',
            },
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
        highlights = {
            diff = {
                current = 'DiffText',
                incoming = 'DiffAdd',
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
            debounce = 1000, -- Increase debounce to reduce API calls
            throttle = 1000, -- Increase throttle to reduce API calls
        },
        ---------------------------------
        --          MCPHub Configs     --
        ---------------------------------
        -- system_prompt as function ensures LLM always has latest MCP server state
        -- This is evaluated for every message, even in existing chats
        system_prompt = function()
            local ok, hub = pcall(require, 'mcphub')
            if ok then
                local hub_instance = hub.get_hub_instance()
                return hub_instance and hub_instance:get_active_servers_prompt() or ''
            end
            return ''
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
            local tools = {}
            local ok, mcp_tool = pcall(require, 'mcphub.extensions.avante')
            if ok then
                local tool = mcp_tool.mcp_tool()
                if tool then
                    table.insert(tools, tool)
                end
            end
            return tools
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
        {
            -- support for image pasting
            'HakonHarnes/img-clip.nvim',
            event = 'VeryLazy',
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        'MeanderingProgrammer/render-markdown.nvim',
    },
}
