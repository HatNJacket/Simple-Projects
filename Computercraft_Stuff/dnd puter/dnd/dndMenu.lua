os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

--Print Centered

function printCentered(y,s)
    local x = math.floor((w - string.len(s)) / 2)
    term.setCursorPos(x,y)
    term.clearLine()
    term.write(s)
end

--Draw Menu

local nOption = 1

local function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.write("BertOS v2.0")
    
    term.setCursorPos(w-11,1)
    if nOption == 1 then
        term.write("Tinderflick")
    elseif nOption == 2 then
        term.write("Crag")
    elseif nOption == 3 then
        term.write("Character 3")
    elseif nOption == 4 then
        term.write("Back")
    else
        end
    
end

--GUI

term.clear()
local function drawFrontend()
    printCentered(math.floor(h/2) - 3, "")
    printCentered(math.floor(h/2) - 2, "Select Character")
    printCentered(math.floor(h/2) - 1, "")
    printCentered(math.floor(h/2) + 0, ((nOption == 1 and "[Tinderflick]") or "Tinderflick"))
    printCentered(math.floor(h/2) + 1, ((nOption == 2 and "[   Crag    ]") or "Crag"))
    printCentered(math.floor(h/2) + 2, ((nOption == 3 and "[Character 3]") or "Character 3"))
    printCentered(math.floor(h/2) + 3, ((nOption == 4 and "[   Back    ]") or "Back"))
end

drawMenu()
drawFrontend()

while true do
    local e,p = os.pullEvent()
        if e == "key" then
            local key = p
            if key == 87 or key == 265 then
                if nOption > 1 then
                    nOption = nOption - 1
                    drawMenu()
                    drawFrontend()
                end
            elseif key == 83 or key == 264 then
                if nOption < 4 then
                    nOption = nOption + 1
                    drawMenu()
                    drawFrontend()
                end
            elseif key == 257 then
                break
        end
    end
end

term.clear()

--Conditions

if nOption == 1 then
    shell.run("dnd/char1/char1menu")
elseif nOption == 2 then
    shell.run("dnd/char2/char2menu")
elseif nOption == 3 then
    shell.run("dnd/char3/menu")
elseif nOption == 4 then
    shell.run("back")
else
    end
        
