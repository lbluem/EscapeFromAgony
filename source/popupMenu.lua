
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

    menuImg = love.graphics.newImage("assets/interface/menu.png")
    attackImg = love.graphics.newImage("assets/interface/Angreifen.png")
    endImg = love.graphics.newImage("assets/interface/Runde_beenden.png")

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

image_attack = love.graphics.newImage("assets/interface/Angreifen.png")
image_do_nothing = love.graphics.newImage("assets/interface/Runde_beenden.png")

function popupMenu:draw(dt)

    --[[ love.graphics.setColor(0.1,0.1,0.1,0.6) ]]
    love.graphics.draw(menuImg, option_middleX + 30, option_middleY,0,0.45,0.45)
    --[[ love.graphics.rectangle("fill",option_middleX,option_middleY,option_width,option_height,20) ]]
    love.graphics.setColor(1,1,1,0.8)
    for i, option in ipairs(popupMenu) do
        --[[ textW = font:getWidth(popupMenu[i].text) ]]
        textH = font:getHeight(popupMenu[i].text)
        textW = 100
        --[[ textH = 40 ]]
        font_middleX = option_middleX + option_width/2 - textW/2
        font_middleY = (option_middleY + option_height/2 - textH/2) - 20
        if optSelect == i then
            love.graphics.print(">                  <", font, font_middleX - 62, font_middleY + ((i-1)*50))
            love.graphics.draw(image_attack, absX/2 - 95, absY/2 - 50, 0, 0.5, 0.5)
            love.graphics.draw(image_do_nothing, absX/2 - 95, absY/2 + 10, 0, 0.5, 0.5)
        else
            love.graphics.print("                    ", font, font_middleX - 62, font_middleY + ((i-1)*50))
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