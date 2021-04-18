require("source/enemy")

picker = {}

--[[ Parameter ]]

isSelected = false
isEmpty = true
canAttack = false

function picker:load()

    pickerArray = boardArray

    pickPosX = pickerArray[1][2][1]
    pickPosY = pickerArray[1][2][2]

    picker.width = tile.width
    picker.height = tile.height
end

function picker:update(dt)

    movePicker()

end

function picker:draw(dt)

    if isSelected then
        love.graphics.setColor(0.8,0.5,0.7)
    else 
        love.graphics.setColor(0.8,1,0.9)
    end

    love.graphics.rectangle("fill", pickPosX, pickPosY, picker.width, picker.height)

end


function movePicker()

    function love.keypressed(key, scancode, isrepeat)
        if key == "w" or key == "up" then
            if pickPosY > pickerArray[1][1][2] then
                pickPosY = pickPosY - blankY
            end
        end
        if key == "a" or key == "left" then
            if pickPosX > pickerArray[1][1][1] then
                pickPosX = pickPosX - blankX
            end
        end
        if key == "s" or key == "down" then
            if pickPosY < pickerArray[1][4][2] then
                pickPosY = pickPosY + blankY
            end
        end
        if key == "d" or key == "right" then
            if pickPosX < pickerArray[5][1][1] then
                pickPosX = pickPosX + blankX
            end
        end




        if key == "space" then
            print("SELECT")
            --[[ selected() ]]
            selectAndConfirm()
        end
        if key == "x" then
            print("DESELECT")
            isSelected = false
        end     
        if key == "escape" then
            love.event.quit()
        end
    end
end

function selected()

    if pickPosX == figPosX and pickPosY == figPosY then
        isSelected = true
        print("Figur ausgewaehlt")
    end
end

function selectAndConfirm()


    if isSelected then
        if isEmpty() then 
            print("Figur bewegt sich")
            figPosX = pickPosX
            figPosY = pickPosY
            isSelected = false
            nearEnemy()
        elseif not isEmpty() and canAttack then
            print("mach kaputt")
            enePosX = -100000
        end
        
    else
        selected()
    end
    
    
end

function isEmpty()

    if pickPosX == enePosX and pickPosY == enePosY then
        print("Da ist ein Gegner")
        return false
    else
        return true
    end

end

function nearEnemy()

    if figPosX == enePosX then
        if figPosY + blankY == enePosY or figPosY - blankY == enePosY then
            print("Gegner nearby")
            canAttack = true
        end
    elseif figPosY == enePosY then
        if figPosX + blankX == enePosX or figPosX - blankX == enePosX  then
            print("Gegner nearby")
            canAttack = true
        end
    end

end