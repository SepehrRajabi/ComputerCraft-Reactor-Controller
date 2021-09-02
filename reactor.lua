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
function get_heat_info()
    max_heat = reactor_info.reactor.maxHeat
    curr_heat = reactor_info.reactor.heat
    perc = (curr_heat / max_heat) * 100
    return max_heat, curr_heat, perc
end

-- to write a text at the center of the screen at a given line
function write_at_center(text, line)
    monitor_handler.setBackgroundColor(colors.black)
    monitor_handler.setTextColor(colors.blue)
    text_len = (string.len(text))
    diff = math.floor(width - text_len)
    text_x = math.floor(diff / 2)
    monitor_handler.setCursorPos(text_x + 1, line)
    monitor_handler.write(text)
end

function draw_bar_heat()
    max_heat, curr_heat, perc = get_heat_info()
    bar = math.floor(((curr_heat / max_heat) * (width - 2)) + 0.5)
    -- drawing the blue bar
    monitor_handler.setPos(2, height - 4)
    monitor_handler.setBackgroundColor(colors.blue)
    monitor_handler.write(string.rep(" ", width - 2))
    -- drawing the percentage bar on top of the full blue bar
    monitor_handler.setCursorPos(2, height - 4)
    monitor_handler.setBackgroundColor(colors.red)
    monitor_handler.write(string.rep(" ", bar))
end

-- main loop
while true do
    button.await(startbutton)
    write_at_center(" Nuclear Reator 0 ", 1)
    draw_bar_heat()
end
