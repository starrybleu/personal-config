-- rcmd 를 한영전환을 위한 f18 키로 remap
-- @source https://www.philgineer.com/2021/01/m1-hammerspoon.html
-- capslock 을 마우스 클릭으로 사용하기 위한 f19 키로 remap
-- @source https://stackoverflow.com/questions/45203657/macos-sierra-emulate-mouse-down-and-up/45270374#45270374
-- @source https://github.com/Hammerspoon/hammerspoon/issues/1496

local FRemap = require('foundation_remapping')
local remapper = FRemap.new()
remapper:remap('rcmd', 'f18')
remapper:remap('capslock', 'f19')
remapper:register()

--

now = hs.timer.secondsSinceEpoch

evt = hs.eventtap
evte = evt.event
evtypes = evte.types
evp=evte.properties

drag_last = now(); drag_intv = 0.01 -- we only synth drags from time to time

mp = {['x']=0, ['y']=0} -- mouse point. coords and last posted event
l = hs.logger.new('keybmouse', 'debug')
dmp = hs.inspect

-- The event tap. Started with the keyboard click:
handled = {evtypes.mouseMoved, evtypes.keyUp }
handle_drag = evt.new(handled, function(e)

    if e:getType() == evtypes.keyDown then return true end

    if e:getType() == evtypes.keyUp then
        handle_drag:stop()
        post_evt(2)
        return nil -- otherwise the up seems not processed by the OS
    end

    mp['x']  = mp['x'] + e:getProperty(evp.mouseEventDeltaX)
    mp['y']  = mp['y'] + e:getProperty(evp.mouseEventDeltaY)

    -- giving the key up a chance:
    if now() - drag_last > drag_intv then
        -- l.d('pos', mp.x, 'dx', dx)
        post_evt(6) -- that sometimes makes dx negative in the log above
        drag_last = now()
    end
    return true -- important
end)

function post_evt(mode)
    -- 1: down, 2: up, 6: drag
    if mode == 1 or mode == 2 then
        local p = hs.mouse.getAbsolutePosition()
        mp['x'] = p.x
        mp['y'] = p.y
    end
    local e = evte.newMouseEvent(mode, mp)
    if mode == 6 then cs = 0 else cs=1 end
    e:setProperty(evte.properties.mouseEventClickState, cs)
    e:post()
end

hs.hotkey.bind({}, "f19",
  function(event)
    post_evt(1)
    handle_drag:start()
  end
)
