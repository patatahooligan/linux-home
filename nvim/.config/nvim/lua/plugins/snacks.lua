return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            dashboard = { example = "files" },
            indent = { enabled = true },
            notifier = { enabled = true },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            -- TODO: Use this only when not running neovide
            scroll = {
                animate = {
                    duration = { step = 4, total = 100 },
                    easing = "linear",
                    fps = 240,
                },
            },
            words = { enabled = true },
        },
    }
}
