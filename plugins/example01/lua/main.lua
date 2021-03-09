local ldpf  = require("ldpf")
local lpugl = require("lpugl_cairo")
local world = lpugl.newWorld("ldpf-example01")
local scale = world:getScreenScale()

----------------------------------------------------------------------------------------------------------

world:setErrorFunc(function(err)
    io.stderr:write(string.format("**** Error in Lua script ****\n%s\n", err))
end)

----------------------------------------------------------------------------------------------------------

local MUTE_IDX = 0 -- Name for plugin parameter index

local isMuted = false

----------------------------------------------------------------------------------------------------------

local view = world:newView
{
    title  = "ldpf-example01",
    parent = ldpf.parentWindowId, -- nil if running as standalone application
    size   = {300*scale, 100*scale},
    resizable = true,
    
    eventFunc = function(view, event, ...)
        print(event, ...)

        if event == "EXPOSE" then
            local cairo = view:getDrawContext()
            local w, h  = view:getSize()
            if isMuted then
                cairo:set_source_rgb(1.0, 0.9, 0.9)
            else 
                cairo:set_source_rgb(0.8, 1.0, 0.8)
            end
            cairo:rectangle(0, 0, w, h)
            cairo:fill()
            cairo:set_source_rgb(0, 0, 0)
            cairo:select_font_face("sans-serif", "normal", "normal")
            cairo:set_font_size(24*scale)
            local text = "Click to mute/unmute!"
            local ext = cairo:text_extents(text)
            cairo:move_to((w - ext.width)/2, (h - ext.height)/2 + ext.height)
            cairo:show_text(text)

        elseif event == "BUTTON_PRESS" then
            local bx, by, bn = ...
            if bn == 1 then
                isMuted = not isMuted
                ldpf.setParameterValue(MUTE_IDX, isMuted and 1 or 0)
                view:postRedisplay()
            end
        
        elseif event == "CLOSE" then
            -- user requests closing the window 
            -- if running plugin as standalone application
            view:close()
        end
    end
}
view:show()

----------------------------------------------------------------------------------------------------------
-- Implement callbacks for LDPF

function ldpf.getWindowId()
    return view:getNativeHandle()
end

function ldpf.parameterChanged(index, value)
    if index == MUTE_IDX then
        isMuted = (value == 1)
        view:postRedisplay()
    end
end

function ldpf.getWidth()
    local w,h = view:getSize()
    return w
end

function ldpf.getHeight()
    local w,h = view:getSize()
    return h
end

-- update callback if plugin ui is embedded in host
function ldpf.idle()
    if lpugl.platform ~= "MAC" then
        world:update(0)
    end
    return world:hasViews()
end

-- update loop if plugin is running standalone
function ldpf.exec(idleCallback)
    while world:hasViews() do
        world:update(0.030)
        idleCallback()
    end
end

function ldpf.close()
    view:close()
end

----------------------------------------------------------------------------------------------------------
