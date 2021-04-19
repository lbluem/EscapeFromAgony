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

    --[[ Alle Load Funktionen aus den verschiedenen Dateien
    werden geladen ]]
    playboard:load()
    figure:load()
    enemy:load()
    picker:load()
end

--[[ Nicht direkt sichtbare Inhalte 
    die mehr als sekündlich geupdated werden]]
function love.update(dt)
    
    picker:update(dt)
end

--[[ Sichtbare Inhalte die mehr als sekündlich 
    geupdated und "gemalt" werden]]
function love.draw()

    playboard:draw(dt)
    picker:draw(dt)
    enemy:draw(dt)
    figure:draw(dt)
    
    --[[ Love Versions Ausgabe im Spiel:  
    local major, minor, revision, codename = love.getVersion()
    local str = string.format("Version %d.%d.%d - %s", major, minor, revision, codename)
    love.graphics.print(str, 20, 20) ]]
end
