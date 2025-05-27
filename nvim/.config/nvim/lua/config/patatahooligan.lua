-- Custom configuration
vim.opt.colorcolumn = "72,80,100,120"
vim.opt.relativenumber = true

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

vim.opt.clipboard = ""

-- TODO: Figure out if this is needed, or it was just a lazy.vim thing
--vim.g.autoformat = false

-- Map greek characters to the english characters which use the same
-- key. Essentially makes greek characters work for normal mode.
vim.opt_global.langmap =
	"ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz"
