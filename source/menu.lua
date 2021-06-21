--[[ Datei zum Hauptmenü ]]
require "main"

local menuengine = require "source/menuengine"
menuengine.stop_on_nil_functions = true

sound = love.audio.newSource("assets/sound/118792__lmbubec__1-knife-slash-a.wav", "stream")
sound:setVolume(0.2)

-- Mainmenu
local mainmenu

menu = {}

-- Start Game
local function start_game()
	--[[ GameState wird auf "Spiel" geändert ]]
	if levelState == 0 then
		gameState = "Dialogue"
	else
		gameState = "Game"
	end
end

-- Tutorial
local function tutorial()

	gameState = "Tutorial"
end
-- Quit Game
local function quit_game()
    love.audio.play(sound)
	love.event.quit()
end

function menu:load()

	button1a = love.graphics.newImage("assets/buttons/start1.png")
	button1b = love.graphics.newImage("assets/buttons/start2.png")

	button2a = love.graphics.newImage("assets/buttons/tutorial1.png")
	button2b = love.graphics.newImage("assets/buttons/tutorial1.png")

	button3a = love.graphics.newImage("assets/buttons/exit1.png")
	button3b = love.graphics.newImage("assets/buttons/exit2.png")

	love.graphics.setFont(love.graphics.newFont(50))
	background_menu = love.graphics.newImage("assets/backgrounds/mainmenu2.jpg")
	sound_bg = love.audio.newSource("assets/sound/Medieval Song Village Consort [No Copyright Music].mp3", "stream")
	sound_bg:setVolume(0.04)
	--[[ love.audio.play(sound_bg) ]]
	
	mainmenu = menuengine.new(485,  325)
    mainmenu:addEntry("StartG am", start_game)
	mainmenu:addSep()
    mainmenu:addEntry("Tutorial     ", tutorial)
	mainmenu:addSep()
    mainmenu:addEntry("Quit Game", quit_game)
end

function menu:update(dt)
	mainmenu:update()

    function love.keypressed(key, scancode, isrepeat)
        menuengine.keypressed(scancode)
        if scancode == "escape" then
            love.event.quit()
        end
    end
end

function menu:draw(dt)

	love.graphics.setColor(1,1,1,1)
	love.graphics.clear()

	local sx = love.graphics.getWidth() / background_menu:getWidth()
    local sy = love.graphics.getHeight() / background_menu:getHeight()
	love.graphics.draw(background_menu, 0, 0, 0, sx, sy)

	mainmenu:draw()

	love.graphics.draw(button1a, absX/2-130,absY/2-45,0,0.85,0.8)
	love.graphics.draw(button2a, absX/2-130,absY/2+65,0,0.85,0.8)
	love.graphics.draw(button3a, absX/2-130,absY/2+175,0,0.85,0.8)
end



function love.mousemoved(x, y, dx, dy, istouch)
    menuengine.mousemoved(x, y)
end
