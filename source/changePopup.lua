
changePopup = {}

local font = nil

charSelect = 1

--[[ function newOption(text)
    return {
        text = text
    }
end ]]

function changePopup:load()

    font = love.graphics.newFont(32)

    option_width = absX * 0.3
    option_height = absY * 0.3

    option_middleX = (absX*0.5)-(option_width*0.5)
    option_middleY = (absY*0.5)-(option_height*0.5)

    --[[ table.insert(changePopup,"will")
    table.insert(changePopup,"helena") ]]
    
    changePopup_height = option_height * #changePopup
    
end

function changePopup:update(dt)

    function love.keypressed(key, scancode, isrepeat)
        if #changePopup > 1 then
            if key == "w" or key == "up" then
                if charSelect == 1 then
                    charSelect = #changePopup
                else
                    charSelect = charSelect + 1
                end
            end
            if key == "s" or key == "down" then
                if charSelect == #changePopup then
                    charSelect = 1
                else
                    charSelect = charSelect - 1
                end
            end 
        end
        if key == "space" or key == "return" then
            chosenChar()
        end
        if key == "escape" or key == "x" then
            playMenuState = "Playing"
        end
    end
end

--[[ Player Auswahl Bilder ]]
image_char_helena = love.graphics.newImage("assets/char/Helena/tiny Helena.png")
image_char_will = love.graphics.newImage("assets/char/Will/tiny Will.png")

function changePopup:draw(dt)

    --[[ Menü Hintergrund Bild ]]
    bg_image = love.graphics.newImage("assets/interface/UI_board_Medium_stone1.png")
    love.graphics.draw(bg_image, love.graphics.getWidth()/2 - bg_image:getWidth()/2, love.graphics.getHeight()/2 - bg_image:getHeight()/2, 0, 0.6, 0.6, -230, -150)

    --[[ Picker Bild ]]
    pickerImg = love.graphics.newImage("assets/interface/picker.png")
    love.graphics.draw(pickerImg, absX/2-75,absY/2-56,0, 0.15, 0.15)

    for i, option in ipairs(changePopup) do
        textW = font:getWidth(changePopup[i])
        textH = font:getHeight(changePopup[i])
        font_middleX = option_middleX + option_width/2 - textW/2
        font_middleY = (option_middleY + option_height/2 - textH/2) - 20
        if charSelect == i then
            love.graphics.print(" ",font,font_middleX,font_middleY + ((i-1)*50))
            if playerString == "will" then
                love.graphics.draw(image_char_helena, absX/2-70,absY/2-45,0)
            elseif playerString == "helena" then
                love.graphics.draw(image_char_will, absX/2-70,absY/2-45,0)
            end
        else
            love.graphics.print(changePopup[i],font,font_middleX,font_middleY + ((i-1)*50))
        end
    end
end


function chosenChar()

    print("Char geaendert")
    playerString = changePopup[charSelect]
    playMenuState = "Playing"
    yourTurn = false

    --[[ if charSelect == 1 then
        isSelected = true
        playMenuState = "Playing"
    elseif charSelect == 2 then
        if yourTurn then yourTurn = false else yourTurn = true end
            playMenuState = "Playing"
    end ]]

end

function refreshChars()

    for i, player in ipairs(changePopup) do
        changePopup[i] = nil
    end
    table.insert(changePopup,"will")
    table.insert(changePopup,"helena")

--[[     if levelState >= 3 then
        table.insert(changePopup,"godfired")
    end ]]

    for i, player in ipairs(changePopup) do
        if changePopup[i] == playerString then
            table.remove(changePopup, i)
        end
    end
end