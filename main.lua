--[[ Ausführende Main Datei ]]

--[[ Inhalte die zunächst geladen werden ]]
function love.load()

    love.window.setFullscreen(false)
    --[[ "Dependencies" ähnlich zum Erben 
        um auf Inhalten aus anderen Dateien zuzugreifen ]]
    require ("source/playboard")
    require("source/figure")
    require("source/picker")
    require("source/enemy")
    require("source/background")
    require("source/player")

    --[[ Alle Load Funktionen aus den verschiedenen Dateien
    werden geladen ]]
    playboard:load()
    player:load()
    enemy:load()
    picker:load()
    background:load()
end

--[[ Nicht direkt sichtbare Inhalte 
    die mehr als sekündlich geupdated werden]]
function love.update(dt)
    
    player:update(dt)
    picker:update(dt)
end

--[[ Sichtbare Inhalte die mehr als sekündlich 
    geupdated und "gemalt" werden]]
function love.draw()

    background:draw(dt)
    playboard:draw(dt)
    picker:draw(dt)
    enemy:draw(dt)
    player:draw(dt)
    
    --[[ Love Versions Ausgabe im Spiel:  
    local major, minor, revision, codename = love.getVersion()
    local str = string.format("Version %d.%d.%d - %s", major, minor, revision, codename)
    love.graphics.print(str, 20, 20) ]]
end
