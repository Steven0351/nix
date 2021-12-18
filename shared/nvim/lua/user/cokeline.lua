local cokeline = require("cokeline")
local colors = require("onenord/colors")
local get_hex = require("cokeline/utils").get_hex

local space = {
	text = " ",
}

local separator = {
	text = "▊",
	hl = {
		fg = function(buffer)
			if buffer.is_focused then
				return colors.green
			else
				return colors.light_gray
			end
		end,
	},
}

local icon = {
	text = function(buffer)
		return buffer.devicon.icon
	end,
	hl = {
		fg = function(buffer)
			if buffer.is_focused then
				return buffer.devicon.color
			else
				return get_hex("Comment", "fg")
			end
		end,
	},
}

local filename = {
	text = function(buffer)
		return buffer.filename
	end,
	hl = {
		fg = function(buffer)
			if buffer.is_focused and buffer.is_modified then
				return colors.yellow
			end

			if buffer.diagnostics.errors ~= 0 then
				return colors.red
			end

			if buffer.diagnostics.warnings ~= 0 then
				return colors.orange
			end

			if buffer.diagnostics.infos ~= 0 then
				return colors.green
			end

			if buffer.diagnostics.hints ~= 0 then
				return colors.purple
			end

			if buffer.is_focused then
				return colors.fg
			end
		end,

		style = function(buffer)
			if buffer.is_focused then
				return "bold"
			end
		end,
	},
}

local changes = {
	text = function(buffer)
		if buffer.is_modified then
			return " ●"
		else
			return ""
		end
	end,
	hl = {
		fg = function(buffer)
			if buffer.is_focused and buffer.is_modified then
				return colors.yellow
			end
		end,
	},
}

local readonly = {
	text = function(buffer)
		if buffer.is_readonly then
			return " "
		else
			return ""
		end
	end,
	hl = {
		fg = function(buffer)
			if buffer.is_readonly then
				return colors.red
			end
		end,
	},
}

cokeline.setup({
	mappings = {
		cycle_prev_next = true,
	},
	default_hl = {
		focused = {
			fg = get_hex("Normal", "fg"),
			bg = get_hex("ColorColumn", "bg"),
			style = "bold",
		},
		unfocused = {
			fg = get_hex("Comment", "fg"),
			bg = get_hex("ColorColumn", "bg"),
		},
	},
	components = {
		separator,
		space,
		space,
		icon,
		filename,
		changes,
		readonly,
		space,
		space,
	},
})
