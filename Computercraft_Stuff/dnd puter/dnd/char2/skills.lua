local monitor = peripheral.find("monitor")
monitor.clear()
monitor.setTextScale(0.5)
monitor.setCursorPos(2,1)
monitor.write("Gildmaw")
local lineNumber = 1
for line in io.lines("dnd/char2/char2Skills.txt") do
    monitor.setCursorPos(13, lineNumber)
    monitor.write(line)
    lineNumber = lineNumber + 1
end
shell.run("dnd/char2/char2menu")
