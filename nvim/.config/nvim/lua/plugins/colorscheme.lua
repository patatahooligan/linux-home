return {
    {
        "tomasr/molokai",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.g.molokai_original = 1
            vim.cmd([[colorscheme molokai]])
        end,
    },
}
