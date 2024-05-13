local monitor = peripheral.find("monitor")
monitor.clear()
monitor.setCursorPos(1,1)
monitor.setTextScale(1)
monitor.write("Gildmaw's Stats")
local lineNumber = 4
for line in io.lines("dnd/char2/char2Stats.txt") do
    monitor.setCursorPos(3, lineNumber)
    monitor.write(line)
    lineNumber = lineNumber + 1
end
shell.run("dnd/char2/char2menu")
