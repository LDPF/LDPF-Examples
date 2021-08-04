local ldpf  = require("ldpf")
local lpugl = require("lpugl_opengl")
local nvg   = require("nvg")
local color = require("nvg.color")
local world = lpugl.newWorld("ldpf-example02")
local scale = world:getScreenScale()

----------------------------------------------------------------------------------------------------------

world:setErrorFunc(function(err)
    io.stderr:write(string.format("**** Error in Lua script ****\n%s\n", err))
end)

----------------------------------------------------------------------------------------------------------

local MUTE_IDX = 0 -- Name for plugin parameter index

local isMuted = false

----------------------------------------------------------------------------------------------------------

local ctx

local view = world:newView
{
    title   = "ldpf-example02",
    parent  = ldpf.parentWindowId, -- nil if running as standalone application

    size    = {300*scale, 100*scale},
    minSize = {200*scale,  50*scale},
    maxSize = {500*scale, 300*scale},

    resizable = true,
    
    eventFunc = function(view, event, ...)
        print(event, ...)

        if event == "CREATE" then
            ctx = nvg.new("antialias")
            ctx:font("DejaVuSans", ldpf.getResource("DejaVuSans.ttf"))

        elseif event == "EXPOSE" then
            local w, h  = view:getSize()
            ctx:beginFrame(w, h)
            if isMuted then
                ctx:clear(color.rgb(1.0, 0.9, 0.9))
            else 
                ctx:clear(color.rgb(0.8, 1.0, 0.8))
            end
            local text = "Click to mute/unmute!"
            ctx:beginPath()
            ctx.fontFace = "DejaVuSans"
            ctx.fontSize = 28*scale
            ctx.fillStyle = color.rgb(0, 0, 0)
            local xadv, txmin, tymin, txmax, tymax = ctx:textBounds(100, 100, text)
            local tw, th = txmax-txmin, tymax-tymin
            local tx, ty = (w-tw)/2, (h-th)/2+th-(tymax-100)
            ctx:text(tx, ty, text)
            ctx:fill()
            ctx:endFrame()

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

function ldpf.getNativeWindowHandle()
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
