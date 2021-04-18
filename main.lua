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
    
end
