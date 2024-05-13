local monitor = peripheral.find("monitor")
local w,h = monitor.getSize()
local currentTerm = term.current()

monitor.clear()
monitor.setTextScale(1)

countSpecific = 0
local stats = {}
local weapons = {}
for line in io.lines("dnd/char1/char1Combat.txt") do
    if not string.find(line, "Comment") then
        if (countSpecific < 5) then
            countSpecific = countSpecific + 1
            stats[countSpecific] = line
        else
            table.insert(weapons, line)
        end
    end
io.close()
end

function drawSheet()
    monitor.clear()
    monitor.setTextScale(1)
    monitor.setCursorPos(2,1)
    monitor.write("Tinderflick")
    monitor.setCursorPos(3,3)
    monitor.write("Speed:")
    monitor.setCursorPos(10,3)
    monitor.write(stats[1])
    monitor.setCursorPos(5,2)
    monitor.write("AC: "..stats[4])
end

function drawHealthBar()
    term.redirect(monitor)
    monitor.setCursorPos(21,1)
    monitor.write("HP:")
    paintutils.drawFilledBox(w-13,2,w-1,2,healthColor(stats[2],stats[3],10))
    monitor.setCursorPos(21,2)
    monitor.write(stats[3])
    if tonumber(stats[3])>=10 then
        monitor.setCursorPos(23,2)
    else
        monitor.setCursorPos(22,2)
    end
    monitor.write("/"..stats[2])
    monitor.setCursorPos(22,2)
    term.redirect(currentTerm)
    --monitor.write("AC: "..stats[4])
    
    --term.redirect(monitor)
    --paintutils.drawBox(w-13,3,w-1,5,colors.white)
    --endBar = healthPercent(stats[2],stats[3],10)
    --if endBar > 0 then
    --    paintutils.drawLine(w-12,4,(w-12+endBar),4,((endBar>4) and colors.green) or colors.red)
    --end
    --monitor.setBackgroundColor(colors.black)
    --term.redirect(currentTerm)
end

function healthColor(max, current, w)
    local percent = current/max
    if percent>=0.5 then
        return colors.green
    elseif percent>=0.25 then
        return colors.yellow
    else
        return colors.red
    end
end

drawSheet()
drawHealthBar()
monitor.setBackgroundColor(colors.black)
shell.run("dnd/char1/char1menu")
