--[[ Datei zum Hauptmenü ]]
require "main"

menu = {}

function menu:load()

end

function menu:update(dt)

    function love.keypressed(key, scancode, isrepeat)
        --[[ GameState wird auf "Spiel" geändert ]]
        if key == "space" then
            gameState = "Game"
        --[[ Spiel wird geschlossen ]]
        elseif key == "escape" then
            love.event.quit()
        end
    end
end

function menu:draw(dt)

    --[[ einfachstes Hauptmenü ]]
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",0,0,absX,absY)
    love.graphics.setColor(0.6,0.6,0.6)
    love.graphics.print("Main Menu", absX/2, absY/2, 0,3,3)

end
