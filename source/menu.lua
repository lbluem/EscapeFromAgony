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
    gameState = "Game"
end

-- Quit Game
local function quit_game()
    love.audio.play(sound)
	love.event.quit()
end

function menu:load()
	love.graphics.setFont(love.graphics.newFont(50))
	background_menu = love.graphics.newImage("assets/backgrounds/menu_bg.jpg")
	sound_bg = love.audio.newSource("assets/sound/Medieval Song Village Consort [No Copyright Music].mp3", "stream")
	sound_bg:setVolume(0.04)
	love.audio.play(sound_bg)
	
	
	
	mainmenu = menuengine.new(100,  500)
    mainmenu:addEntry("Start Game", start_game)
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

    --[[ einfachstes Hauptmenü ]]
    --[[ love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",0,0,absX,absY)
    love.graphics.setColor(0.6,0.6,0.6)
    love.graphics.print("Main Menu", absX/2, absY/2, 0,3,3) ]]
	love.graphics.setColor(1,1,1,1)
	love.graphics.clear()
	for i = 0, love.graphics.getWidth() / background_menu:getWidth() do
        for j = 0, love.graphics.getHeight() / background_menu:getHeight() do
            love.graphics.draw(background_menu, i * background_menu:getWidth(), j * background_menu:getHeight())
        end
    end

	mainmenu:draw()
end



function love.mousemoved(x, y, dx, dy, istouch)
    menuengine.mousemoved(x, y)
end
