local monitor = peripheral.find("monitor")
monitor.clear()
monitor.setTextScale(0.5)
monitor.setCursorPos(2,1)
monitor.write("Tinderflick's Skills")
local lineNumber = 1
for line in io.lines("dnd/char1/char1Skills.txt") do
    monitor.setCursorPos(13, lineNumber)
    monitor.write(line)
    lineNumber = lineNumber + 1
end
shell.run("dnd/char1/char1menu")
