os.loadAPI("button.lua")

-- setting the monitor handler and getting its size
monitor_handler = peripheral.wrap("right")
width, height = monitor_handler.getSize()

-- reactor peripheral wrapper
reactor = peripheral.wrap("ic2:reactor_chamber_0")
core = reactor.getReactorCore()
curr_power_output = core.getOfferedEnergy()
reactor_info = core.getMetadata()

button.setMonitor(monitor_handler)
startbutton = button.create().setSize(5, 5).setColor(colors.blue)
startbutton.setPos(2, 2)
startbutton.setText("start")

-- the start button functionality
local isOn = true -- which means a rs signal will be sent
startbutton.onClick(function() rs.setOutput("left", isOn) isOn = not isOn end)

-- getting the reactor heat percentage
function get_heat_perc()
    max_heat = info.reactor.maxHeat
    curr_heat = info.reactor.heat
    perc = (curr_heat / max_heat) * 100
    return perc
end

function write_at_center(text, line)
    monitor_handler.setBackgroundColor(colors.black)
    monitor_handler.setTextColor(colors.blue)
    text_len = (string.len(text))
    diff = math.floor(width - text_len)
    text_x = math.floor(diff / 2)
    monitor_handler.setCursorPos(text_x + 1, line)
    monitor_handler.write(text)
end

function draw_bar()
    bar = curr_power_output
    monitor_handler.setCursorPos(2, 4)
    monitor_handler.setBackgroundColor(colors.red)
    monitor_handler.write(string.rep(" ", bar))
end

while true do
    button.await(startbutton)
    write_at_center(" Nuclear Reator 0 ", 1)
end