local monitor = peripheral.find("monitor")
local w,h = term.getSize()

monitor.clear()
monitor.setTextScale(0.5)

function splitString(s)
    local t = {}
    for word in string.gmatch(s, "%S+") do
        table.insert(t, word)
    end
    return t
end

features = {}
lineCount = 0

local nOption = 0

for line in io.lines("dnd/char2/char2Features.txt") do
    if not string.find(line, "Comment") then
        features[lineCount] = line
        lineCount = lineCount + 1
    end
io.close()
end

function printCentered(y,s)
    local x = math.floor((w-string.len(s))/2)
    term.setCursorPos(x,y)
    term.clearLine()
    term.write(s)
end

function printCenterBlock(s)
    local words = splitString(s)
    currentLine = ""
    charsOnLine = 0
    numLinesPrinted = 0
    for i,w in ipairs(words) do
        if(45 >= (string.len(currentLine)+string.len(w))) then
            currentLine = currentLine..w.." "
            charsOnLine = charsOnLine + string.len(w)
            --print("Read")
        else
            monitor.setCursorPos(6,4+numLinesPrinted)
            monitor.write(currentLine)
            currentLine = w.." "
            charsOnLine = string.len(w)
            numLinesPrinted = numLinesPrinted + 1
            --print("Elsed")
        end
    end
    if charsOnLine>0 then
        monitor.setCursorPos(6,4+numLinesPrinted)
        monitor.write(currentLine)    
    end
end

function drawFeatures(option)
    --print(option)
    --print(features[option])
    monitor.clear()
    monitor.setCursorPos(6,2)
    monitor.write(features[option*2])
    printCenterBlock(features[(option*2)+1])
end

local function getFeature(option)
    return features[option*2]
end

term.clear()
term.setCursorPos(2,1)
term.write("BertOS v2.0")
term.setCursorPos(2,2)
term.write("Features Menu")

local function drawMenu()
    printCentered(math.floor(h/2) - 5, "")
    printCentered(math.floor(h/2) - 4, "Features")
    printCentered(math.floor(h/2) - 3, "")
    printCentered(math.floor(h/2) - 2, getFeature(nOption))
    printCentered(math.floor(h/2) - 1, "<<<Last                   Next>>>")
end

drawMenu()
drawFeatures(nOption)

while true do
    local e,p = os.pullEvent()
    if e == "key" then
        local key = p
        if (key == 262 or key == 68) and nOption < 1 then
            nOption = nOption + 1
            drawMenu()
            drawFeatures(nOption)
        elseif (key == 263 or key == 65) and nOption > 0 then
            nOption = nOption - 1
            drawMenu()
            drawFeatures(nOption)
        elseif key == 257 or key == 32 then
            break
        end
    end
end

shell.run("dnd/char2/char2menu")
