
popupMenu = {}

local font = nil

optSelect = 1

function newOption(text)
    return {
        text = text
        --[[ func = func ]]
    }
end

function popupMenu:load()

    font = love.graphics.newFont(32)

    option_width = absX * 0.3
    option_height = absY * 0.3

    option_middleX = (absX*0.5)-(option_width*0.5)
    option_middleY = (absY*0.5)-(option_height*0.5)
    


    table.insert(popupMenu, newOption(
        "Attack"))
        --[[ function()
            playMenuState = "Playing"
        end ))  ]]
    table.insert(popupMenu, newOption(
        "End turn"))
        --[[ function()
            if yourTurn then yourTurn = false else yourTurn = true end
            playMenuState = "Playing"
         end )) ]]

    popupMenu_height = option_height * #popupMenu
end

function popupMenu:update(dt)

    function love.keypressed(key, scancode, isrepeat)
        if key == "w" or key == "up" then
            if optSelect == 1 then
                optSelect = 2
            elseif optSelect == 2 then
                optSelect = 1
            end
        end
        if key == "s" or key == "down" then
            if optSelect == 1 then
                optSelect = 2
            elseif optSelect == 2 then
                optSelect = 1
            end
        end 
        if key == "space" or key == "return" then
            chosenOption()
        end
        if key == "escape" or key == "x" then
            playMenuState = "Playing"
        end
    end
end

function popupMenu:draw(dt)

    love.graphics.setColor(0.1,0.1,0.1,0.6)
    love.graphics.rectangle("fill",option_middleX,option_middleY,option_width,option_height,20)
    love.graphics.setColor(1,1,1,0.8)
    for i, option in ipairs(popupMenu) do
        textW = font:getWidth(popupMenu[i].text)
        textH = font:getHeight(popupMenu[i].text)
        font_middleX = option_middleX + option_width/2 - textW/2
        font_middleY = (option_middleY + option_height/2 - textH/2) - 20
        if optSelect == i then
            love.graphics.print(">"..popupMenu[i].text.."<",font,font_middleX,font_middleY + ((i-1)*50))
        else
            love.graphics.print(popupMenu[i].text,font,font_middleX,font_middleY + ((i-1)*50))
        end
    end
end


function chosenOption()

    if optSelect == 1 then
        isSelected = true
        playMenuState = "Playing"
    elseif optSelect == 2 then
        print("Zug beendet")
        if yourTurn then yourTurn = false else yourTurn = true end
            playMenuState = "Playing"
    end

end