--[[ Ausführende Main Datei ]]


--[[ Gamestate ]]
gameState = "MainMenu"


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

    --[[ Alle Load Funktionen aus den verschiedenen Dateien
    werden geladen ]]
    playboard:load()

    player:load()
    enemy:load()
    picker:load()
    background:load()
    colorTiles:load()
    menu:load()
end

--[[ Nicht direkt sichtbare Inhalte 
    die mehr als sekündlich geupdated werden]]
function love.update(dt)
    
    if gameState == "MainMenu" then
        menu:update(dt)
    else
        player:update(dt)
        picker:update(dt)
    end
end

--[[ Sichtbare Inhalte die mehr als sekündlich 
    geupdated und "gemalt" werden]]
function love.draw()

    if gameState == "MainMenu" then
        menu:draw(dt)
    else
        background:draw(dt)
        playboard:draw(dt)
        colorTiles:draw(dt)
        picker:draw(dt)
        enemy:draw(dt)
        player:draw(dt)
    end
    
    --[[ Love Versions Ausgabe im Spiel:  
    local major, minor, revision, codename = love.getVersion()
    local str = string.format("Version %d.%d.%d - %s", major, minor, revision, codename)
    love.graphics.print(str, 20, 20) ]]
end
