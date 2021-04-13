function love.load()
    love.window.setFullscreen(false)
    require ("source/playboard")
end

function love.update(dt)

end

function love.draw()
    playboard:draw(dt)
end
