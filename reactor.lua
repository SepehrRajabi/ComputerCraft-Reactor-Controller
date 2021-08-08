os.loadAPI("button.lua")
monitor_handler = peripheral.wrap("right")
 
button.setMonitor(monitor_handler)
startbutton = button.create().setSize(5, 5).setColor(colors.blue)
startbutton.setPos(2, 2)
startbutton.setText("start")
 
local status = true -- which means a rs signal will be sent
startbutton.onClick(function() rs.setOutput("left", status) status = not status end)
 
function draw_bar()
    bar = math.floor(5)
    monitor_handler.setCursorPos(2, 8)
    monitor_handler.setBackgroundColor(colors.blue)
    monitor_handler.write(string.rep("  ", 9))
end

while true do
    button.await(startbutton)
    draw_bar()
end