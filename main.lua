--[[ Ausführende Main Datei ]]


--[[ Gamestate ]]
gameState = "MainMenu" --[[ "MainMenu", "Game", "Dialogue", "Tutorial" ]]
playMenuState = "Playing" --[[ "Playing", "PopupMenu", "ChangeMenu" ]]
dialogueState = 0 --[[ Dialog: 0, 1, 2, 3 ]]
levelState = 0  --[[ Level: 0, 1, 2, 3 ]]

--[[ Inhalte die zunächst geladen werden ]]
function love.load()

    love.window.setFullscreen(false)
    --[[ "Dependencies" ähnlich zum Erben 
        um auf Inhalten / Funktionen aus anderen Dateien zuzugreifen ]]
    require "source/playboard"
    require "source/figure"
    require "source/picker" 
    require "source/enemy"
    require "source/background"
    require "source/player"
    require "source/colorTiles"
    require "source/menu"
    require "source/popupMenu"
    require "source/dialogue"
    require "source/changePopup"
    require "source/tutorial"

    --[[ Alle Load Funktionen aus den verschiedenen Dateien
    werden geladen ]]
    playboard:load()
    dialogue:load()
    player:load()
    enemy:load()
    picker:load()
    background:load()
    colorTiles:load()
    menu:load()
    popupMenu:load()
    changePopup:load()
    tutorial:load()
end

--[[ Nicht direkt sichtbare Inhalte 
    die mehr als sekündlich geupdated werden]]
function love.update(dt)
    
    if gameState == "MainMenu" then
        menu:update(dt)
    elseif gameState == "Game" then
        if playMenuState == "PopupMenu" then
            popupMenu:update(dt)
        elseif playMenuState == "ChangeMenu" then
            changePopup:update(dt)
        else
            player:update(dt)
            enemy:update(dt)
            picker:update(dt)
        end
    elseif gameState == "Dialogue" then
        dialogue:update(dt)
    elseif gameState == "Tutorial" then
        tutorial:update(dt)
    end

    --[[ function love.keypressed(key, scancode, isrepeat)
        if key == "o" then
            levelState = 2
        end
    end ]]
end

--[[ Sichtbare Inhalte die mehr als sekündlich 
    geupdated und "gemalt" werden]]
function love.draw()

    if gameState == "MainMenu" then
        menu:draw(dt)
    elseif gameState == "Tutorial" then
        tutorial:draw(dt)
    elseif playMenuState ~= "PopupMenu" and playMenuState ~= "ChangeMenu" then
        if gameState == "Dialogue" then
            background:draw(dt)
            dialogue:draw()
        else 
            background:draw(dt)
            playboard:draw(dt)
            colorTiles:draw(dt)
            picker:draw(dt)
            enemy:draw(dt)
            player:draw(dt)
        end
    end
    if playMenuState == "PopupMenu" then
        background:draw(dt)
        playboard:draw(dt)
        enemy:draw(dt)
        player:draw(dt)
        popupMenu:draw(dt)
    end
    if playMenuState == "ChangeMenu" then
        background:draw(dt)
        playboard:draw(dt)
        enemy:draw(dt)
        player:draw(dt)
        changePopup:draw(dt)
    end
    
    
    --[[ Love Versions Ausgabe im Spiel:  
    local major, minor, revision, codename = love.getVersion()
    local str = string.format("Version %d.%d.%d - %s", major, minor, revision, codename)
    love.graphics.print(str, 20, 20) ]]
end
