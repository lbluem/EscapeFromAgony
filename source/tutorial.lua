
tutorial = {}

currentTut = 1

function tutorial:load()

    tutImg = {}
    tutImg[1] = love.graphics.newImage("assets/interface/tutorial1.jpg")
    tutImg[2] = love.graphics.newImage("assets/interface/tutorial2.jpg")

end


function tutorial:update(dt)

    function love.keypressed(key, scancode, isrepeat)
        if key == "space" then
            if currentTut == 1 then
                currentTut = currentTut + 1
            else
                currentTut = 1
                gameState = "MainMenu"
            end
        end
    end
end

function tutorial:draw(dt)
    love.graphics.draw(tutImg[currentTut],0,0,0,0.67,0.67)
end