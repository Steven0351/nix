local onenord = require("onenord")
local colors = require("onenord.colors")

onenord.setup {
  styles = {
    comments = "italic",
  },
  custom_highlights = {
    TSNamespace = { fg = colors.purple }
  }
}
