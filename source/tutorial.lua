
tutorial = {}

function tutorial:load()

    tutImg = love.graphics.newImage("assets/interface/tutorial.jpg")

end


function tutorial:update(dt)

    function love.keypressed(key, scancode, isrepeat)
        if key == "space" then
            gameState = "MainMenu"
        end
    end
end

function tutorial:draw(dt)

    love.graphics.draw(tutImg,0,0,0,0.67,0.67)
end