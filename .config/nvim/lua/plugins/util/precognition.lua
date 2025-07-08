return {
    'tris203/precognition.nvim',
    event = 'VeryLazy',
    opts = {
        startVisible = false,
        -- showBlankVirtLine = true,
        -- highlightColor = { link = "Comment" },
        -- hints = {
        --      Caret = { text = "^", prio = 2 },
        --      Dollar = { text = "$", prio = 1 },
        --      MatchingPair = { text = "%", prio = 5 },
        --      Zero = { text = "0", prio = 1 },
        --      w = { text = "w", prio = 10 },
        --      b = { text = "b", prio = 9 },
        --      e = { text = "e", prio = 8 },
        --      W = { text = "W", prio = 7 },
        --      B = { text = "B", prio = 6 },
        --      E = { text = "E", prio = 5 },
        -- },
        -- gutterHints = {
        --     G = { text = "G", prio = 10 },
        --     gg = { text = "gg", prio = 9 },
        --     PrevParagraph = { text = "{", prio = 8 },
        --     NextParagraph = { text = "}", prio = 8 },
        -- },
        -- disabled_fts = {
        --     "startify",
        -- },
    },
    config = function(_, opts)
        require('precognition').setup(opts)

        require('snacks')
            .toggle({
                name = 'Precognition',
                get = function()
                    return not vim.g.precognition
                end,
                set = function(state)
                    vim.g.precognition = not state
                    require('precognition').toggle(state)
                end,
            })
            :map '<leader>tP'
    end,
}
