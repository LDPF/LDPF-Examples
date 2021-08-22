local ldpfgui = require("ldpfgui")

local PluginParams  = ldpfgui.PluginParams
local PluginGui     = ldpfgui.PluginGui
local PluginWindow  = ldpfgui.PluginWindow

----------------------------------------------------------------------------------------------------------

local lwtk    = require("lwtk")

local Box        = lwtk.Box
local Color      = lwtk.Color
local Column     = lwtk.Column
local PushButton = lwtk.PushButton
local Row        = lwtk.Row
local Space      = lwtk.Space
local TitleText  = lwtk.TitleText

----------------------------------------------------------------------------------------------------------

local params = PluginParams {
    { "mute", "boolean", false }
}

----------------------------------------------------------------------------------------------------------

local gui = PluginGui("ldpf-example03", params)

local win = PluginWindow(gui, {

    style = {
        { "BackgroundColor",                    Color"1d1d1d" },
        { "TextColor",                          Color"f0f0f0" },
        { "AccentColor",                        Color"db8505" },
        { "BackgroundColor@PushButton",         Color"2d2d2d" },
        { "BackgroundColor@PushButton:hover",   Color"3d3d3d" },
        { "TextColor@PushButton:disabled",      Color"808080" },
        { "BorderColor@PushButton:disabled",    Color"808080" },
    },

    Space {
        unlimited = true,
        Column {
            TitleText   {   id = "status",
                            onParamChanged = { "mute",  function(widget, value)
                                                            widget:setText("Status: "..(value and "" or "not ").."muted")
                                                        end }
                        },
            Box {
                Row {
                    PushButton  {   text = "&Toggle", 
                                    onClicked = function(widget) 
                                                    params:toggleParam("mute")
                                                end
                                },
                    PushButton  {   text = "&Mute", 
                                    onClicked = function(widget) 
                                                    params:setParam("mute", true)
                                                end,
                                    onParamChanged = { "mute",  function(widget, value)
                                                                    widget:setDisabled(value)
                                                                end }
                                },
                    PushButton  {   text = "&Unmute", 
                                    onClicked = function(widget) 
                                                    params:setParam("mute", false)
                                                end,
                                    onParamChanged = { "mute",  function(widget, value)
                                                                    widget:setDisabled(not value)
                                                                end }
                                }
                }
            }
        }
    }
})

win:show()

----------------------------------------------------------------------------------------------------------
