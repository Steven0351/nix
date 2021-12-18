local status_ok, lualine = pcall(require, "lualine")
local colors = require("onenord/colors")

if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  colored = true,
  update_in_insert = false,
  always_visible = false,
}

local diff = {
  "diff",
  colored = true,

  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },

  symbols = { added = "  ", modified = " 柳", removed = "  " },
  color = {},
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function()
    return " "
  end,
  padding = { left = 0, right = 0 },
  color = {},
  cond = nil,
}

local filename = {
  "filename",
  color = {},
  cond = nil,
}

local filetype = {
  "filetype",
  icons_enabled = true,
  icon = nil,
  padding = { left = 1, right = 1 },
}

local branch = {
  "branch",
  icons_enabled = true,
  color = { fg = colors.purple },
  padding = { left = 2, right = 0 },
  icon = "",
}

local location = {
  "location",
  padding = { left = 0, right = 1 },
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local scrollbar = {
  progress,
  padding = { left = 0, right = 0 },
  color = { fg = colors.yellow, bg = colors.bg },
  cond = nil,
}

local treesitter = {
  function()
    local b = vim.api.nvim_get_current_buf()
    if next(vim.treesitter.highlighter.active[b]) then
      return "  "
    end
    return ""
  end,
  padding = { left = 0, right = 0 },
  color = { fg = colors.green },
  cond = hide_in_width,
}

local lsp = {
  function(msg)
    msg = msg or "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      if type(msg) == "boolean" or #msg == 0 then
        return "LS Inactive"
      end
      return msg
    end

    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
        table.insert(buf_client_names, client.name)
      end
    end

    return " " .. table.concat(buf_client_names, "  ")
  end,
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { filename },
    lualine_c = { branch, diff },
    lualine_x = { diagnostics, treesitter, lsp, filetype, location },
    lualine_y = {},
    lualine_z = { scrollbar },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
