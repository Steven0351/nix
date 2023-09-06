local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "            :h-                                  Nhy`               ",
  "           -mh.                           h.    `Ndho               ",
  "           hmh+                          oNm.   oNdhh               ",
  "          `Nmhd`                        /NNmd  /NNhhd               ",
  "          -NNhhy                      `hMNmmm`+NNdhhh               ",
  "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
  "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
  "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
  "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
  " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
  " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
  " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
  " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
  "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
  "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
  "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
  "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
  "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
  "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
  "       //+++//++++++////+++///::--                 .::::-------::   ",
  "       :/++++///////////++++//////.                -:/:----::../-   ",
  "       -/++++//++///+//////////////               .::::---:::-.+`   ",
  "       `////////////////////////////:.            --::-----...-/    ",
  "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
  "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
  "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
  "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
  "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
  "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
  "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
  "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
  "                        .-:mNdhh:.......--::::-`                    ",
  "                           yNh/..------..`                          ",
  "                                                                    ",
  "                              N E O V I M                           ",
}

dashboard.section.buttons.val = {
  dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
  dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
}

local function footer()
  -- NOTE: requires the fortune-mod package to work
  -- local handle = io.popen("fortune")
  -- local fortune = handle:read("*a")
  -- handle:close()
  -- return fortune
  -- Want to update this to use https://github.com/fredrikburman/ted-lasso-quotes-cli
  return "To the everlasting glory of the infantry..."
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "String"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
