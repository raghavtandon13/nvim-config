local wezterm = require("wezterm")
local config = wezterm.config_builder()
local pwsh = "C:/Program Files/PowerShell/7/pwsh.exe"
local zsh = "C:/Program Files/Git/bin/bash.exe"

config.audible_bell = "Disabled"
config.color_scheme = "Catppuccin Mocha"
config.colors = { tab_bar = { background = "#141414" }, background = "#141414" }
config.default_cwd = "D:/Code"
config.default_prog = { pwsh, "-nologo" }
config.font_size = 14
config.hide_tab_bar_if_only_one_tab = true
config.keys = {
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
	{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "_", mods = "ALT|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "+", mods = "ALT|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{
		key = "v",
		mods = "ALT|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({ args = { pwsh, "-nologo", "-Command", "v" } }),
	},
	{
		key = "n",
		mods = "ALT|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({ args = { pwsh, "-nologo", "-Command", "n" } }),
	},
	{
		key = "t",
		mods = "ALT|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({ args = { pwsh, "-nologo", "-Command", "t" } }),
	},
}
config.launch_menu = {
	{ label = "PWSH", args = { pwsh, "-nologo" } },
	{ label = "ZSH ", args = { zsh, "-i", "-l" } },
	{ label = "FZF ", args = { pwsh, "-nologo", "-Command", "v" } },
	{ label = "BTOP", args = { "btop" } },
}
config.line_height = 1.4
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 24
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.98
config.win32_system_backdrop = 'Acrylic'
config.window_decorations = "RESIZE"
config.window_padding = { left = 4, right = 0, top = "30", bottom = 0 }

for i = 0, 8 do
	table.insert(config.keys, { key = tostring(i + 1), mods = "CTRL", action = wezterm.action.ActivateTab(i) })
end


--[[ change padding when window is resized ]]
--[[
    local function adjust_padding(window)
	    local overrides = window:get_config_overrides() or {}
	    local dims = window:get_dimensions()
	    if dims.pixel_height == 1371 then
		    overrides.window_padding = { left = 10, right = 0, top = 10, bottom = 0 }
	    else
		    overrides.window_padding = { left = 10, right = 0, top = 10, bottom = 0 }
	    end
	    window:set_config_overrides(overrides)
     end
     wezterm.on("window-resized", function(window)
	    adjust_padding(window)
     end)
]]

wezterm.on("format-tab-title", function(tab)
	local title = tab.tab_title
	if not title or #title == 0 then
		title = tab.active_pane.title
	end
	local INACTIVE_BG = "#141414"
	local ACCENT = "#799dd9"
	if tab.is_active then
		return {
			{ Background = { Color = INACTIVE_BG } },
			{ Foreground = { Color = ACCENT } },
			{ Text = wezterm.nerdfonts.ple_left_half_circle_thick },
			{ Background = { Color = ACCENT } },
			{ Foreground = { Color = INACTIVE_BG } },
			{ Text = " " .. (((title:match("[^/\\]+$") or title):gsub("%.exe$", "")):sub(1, 12)) .. " " },
			{ Background = { Color = INACTIVE_BG } },
			{ Foreground = { Color = ACCENT } },
			{ Text = wezterm.nerdfonts.ple_right_half_circle_thick },
		}
	else
		return {
			{ Background = { Color = INACTIVE_BG } },
			{ Foreground = { Color = INACTIVE_BG } },
			{ Text = wezterm.nerdfonts.ple_left_half_circle_thick },
			{ Background = { Color = INACTIVE_BG } },
			{ Foreground = { Color = ACCENT } },
			{ Text = " " .. (((title:match("[^/\\]+$") or title):gsub("%.exe$", "")):sub(1, 12)) .. " " },
			{ Background = { Color = INACTIVE_BG } },
			{ Foreground = { Color = INACTIVE_BG } },
			{ Text = wezterm.nerdfonts.ple_right_half_circle_thick },
		}
	end
end)

return config
