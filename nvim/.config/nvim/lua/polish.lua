-- Custom configuration
vim.g.neovide_refresh_rate = 240
vim.g.neovide_cursor_animation_length = 0.03
vim.g.neovide_hide_mouse_when_typing = true

vim.opt.colorcolumn = "72,80,100,120"

-- Are these overriden by something?
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

vim.opt.listchars = "tab: ->,trail:·,extends:>,precedes:<"
vim.opt.list = true

vim.opt.guifont = "CommitMono Nerd Font:h16"

vim.opt.wrap = false
vim.opt.textwidth = 72

-- astro.nvim evidently sets this to "unnamedplus" which makes every
-- yank operation use the "+" register, ie the system clipboard. We
-- don't want this generally. It is especially bad when trying to
-- replace a word with something we copy from another source, because
-- the moment we remove the part we want to replace, it overwrites the
-- text we want to insert...
vim.opt.clipboard = ""


-- Map greek characters to the english characters which use the same
-- key. Essentially makes greek characters work for normal mode.
vim.opt_global.langmap =
"ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz"
