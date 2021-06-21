--[[ Gegner "Klasse" (ist nicht wirklich eine Klasse) ]]
--[[ require "source/figure" ]]

--[[ Objekterstellung des Gegners ]]
enemy = {}

enemies = {}

enemyTimer = 0
enemyTime = 0.6

goXY = 1 --[[ Random int ob Gegner zuerst auf X oder Y Achse verfolgt]]
--[[ Parameter ]]

eneCanAttack = false
eneMoveLimit = 1
eneCanMove = true

enemy.width = figure.width
enemy.height = figure.height

eneDistX = (tile.width/2)--[[ -(enemy.width/2) ]]
eneDistY = (tile.height/2)--[[ -(enemy.height/2) ]]

function addEnemy(type,x,y)

    --[[ Der Typ könnte statt einer Zahl der Name, also ein String sein (z.B. "Wache1")
    was die Übersicht vereinfachen würde ]]
    enemy[type] = {}
    enemy[type].img = love.graphics.newImage("assets/char/Wache"..type.."/tiny Wache"..type..".png")
    enemy[type].img2 = love.graphics.newImage("assets/char/Wache"..type.."/tiny Wache"..type.." b1.png")
    enemy[type].img3 = love.graphics.newImage("assets/char/Wache"..type.."/tiny Wache"..type.." b2.png")

   --[[  enemy[type].img = love.graphics.newImage("assets/char/Wache1/tiny Wache1.png")
    enemy[type].img2 = love.graphics.newImage("assets/char/Wache1/tiny Wache1 b1.png")
    enemy[type].img3 = love.graphics.newImage("assets/char/Wache1/tiny Wache1 b2.png") ]]

    enemy[type].hp = 3
    enemy[type].posX = boardArray[x][y][1]
    enemy[type].posY = boardArray[x][y][2]
    enemy[type].movLimit = 1
    table.insert(enemies,enemy)
end


function enemy:load()

    --[[     enemy.wache1 = love.graphics.newImage("assets/char/tiny Wache 1.png")
    enemy.wache2 = love.graphics.newImage("assets/char/tiny Wache 2.png") ]]
    --[[ Start Position im Array ]]
    --[[     enemy.posX = boardArray[4][3][1]
    enemy.posY = boardArray[4][3][2] ]]
    addEnemy(1,4,4)
    --[[ addEnemy(3,2,3) ]]
    --[[ print(enemies[2].posX) ]]
end


function enemy:update(dt)
    function love.keypressed(key, scancode, isrepeat)
        if key == "r" then
            addEnemy(1,4,4)
            addEnemy(2,5,3)
        end
    end
    if not yourTurn then
        enemyTimer = enemyTimer + love.timer.getDelta()

        if enemyTimer >= enemyTime then
            enemyTurn()
            enemyTimer = 0
        end
    end
end

function enemy:draw(dt)
    --[[ Gegner wird "gemalt" ]]
    love.graphics.setColor(1,1,1,1)
    for a, enemy in ipairs(enemies) do
        print(enemy[a].hp)
        if enemy[a].hp == 3 then
            currentImg = enemy[a].img
        elseif enemy[a].hp == 2 then
            currentImg = enemy[a].img2
        elseif enemy[a].hp == 1 then
            currentImg = enemy[a].img3
        end
        
        love.graphics.draw(currentImg, enemy[a].posX + eneDistX, enemy[a].posY + eneDistY, 0, -1, 1, 60, 90)
        
        --[[ end ]]
    end
end

thisEneML = {}

function enemyTurn()

    for i, enemy in ipairs(enemies) do
        table.insert(thisEneML,enemy[i].movLimit)
    end
    if not yourTurn then
        for i, enemy in ipairs(enemies) do
            --[[ Kann der Gegner angreifen? ]]
            nearPlayer(i)
            if eneCanAttack then
                playerGotHit()
                print("Du verlierst ein Leben")
                eneCanMove = false
                eneCanAttack = false
                yourTurn = true
            end
            if love.math.random(1,2) == 1 then
                xMove(i)
                yMove(i)
            else
                yMove(i)
                xMove(i)
            end            
        end
    end
    table.remove(thisEneML)
    yourTurn = true
    eneCanMove = true
    canMove = true
end

function xMove(i)
    if round(player.posX,2) < round(enemy[i].posX,2) then
        if enemy[i].movLimit > 0 and eneCanMove then
            if not friendlyEnemyThere(i,round(enemy[i].posX - blankX,2),enemy[i].posY) then
                enemy[i].posX = round(enemy[i].posX - blankX,2)
                thisEneML[i] = thisEneML[i] - 1
                eneCanMove = false
                --[[ print("Nummer "..i.." bewegt sich horizontal") ]]
            end
        end
    elseif round(player.posX,2) > round(enemy[i].posX,2) then
        if enemy[i].movLimit > 0 and eneCanMove then
            if not friendlyEnemyThere(i,round(enemy[i].posX + blankX,2), enemy[i].posY) then
                enemy[i].posX = round(enemy[i].posX + blankX,2)
                thisEneML[i] = thisEneML[i] - 1
                eneCanMove = false
                --[[ print("Nummer "..i.." bewegt sich horizontal") ]]
            end
        end
    end
end

function yMove(i)

    if round(player.posY,2) < round(enemy[i].posY,2) then
        if enemy[i].movLimit > 0 and eneCanMove then
            if not friendlyEnemyThere(i, enemy[i].posX,round(enemy[i].posY - blankY,2)) then
                enemy[i].posY = round(enemy[i].posY - blankY,2)
                thisEneML[i] = thisEneML[i] - 1
                eneCanMove = false
                --[[ print("Nummer "..i.." bewegt sich") ]]
            end
        end
    elseif round(player.posY,2) > round(enemy[i].posY,2) then
        if enemy[i].movLimit > 0 and eneCanMove then
            if not friendlyEnemyThere(i, enemy[i].posX,round(enemy[i].posY + blankY,2)) then
                enemy[i].posY = round(enemy[i].posY + blankY,2)
                thisEneML[i] = thisEneML[i] - 1
                eneCanMove = false
                --[[ print("Nummer "..i.." bewegt sich") ]]
            end
        end
    end
end



function round(x,fact)
    return (math.floor(x * 10^fact + 0.5) / 10^fact)
end


function nearPlayer(i)

    if round(player.posX,2) == round(enemy[i].posX,2) then
        --[[ und dann Gegner nicht mehr als ein Tile/Feld entfernt ist kann angegriffen werden ]]
        if player.posY + blankY >= enemy[i].posY -1 and player.posY + blankY <= enemy[i].posY +1 
        or player.posY - blankY >= enemy[i].posY -1 and player.posY - blankY <= enemy[i].posY +1 then
            --[[ print("Gegner nearby") ]]
            eneCanAttack = true
            return
        else
            eneCanAttack = false
            --[[ print("Spieler ist nicht auf der selben Y-Achse (+/-1)") ]]
        end
    
    --[[ Wenn Figur-Position auf gleicher Höhe (Y-Achse) wie der Gegner ist ]]
    elseif round(player.posY,2) == round(enemy[i].posY,2) then
        --[[ print("Auf der gleichen Y-Achse") ]]
        --[[ und dann Gegner nicht mehr als ein Tile/Feld entfernt ist kann angegriffen werden ]]
        if player.posX + blankX >= enemy[i].posX -1 and player.posX + blankX <= enemy[i].posX +1
        or player.posX - blankX >= enemy[i].posX -1 and player.posX - blankX <= enemy[i].posX +1 then
            --[[ print("Gegner nearby") ]]
            eneCanAttack = true
            return
        else
            eneCanAttack = false
            --[[ print("Spieler ist nicht auf der selben X-Achse (+/-1)") ]]
        end
    else
        eneCanAttack = false
    end
end

function friendlyEnemyThere(MeEnemy,toX,toY)

    print("Der "..MeEnemy.."te Gegner geht an Position:"..toX, toY.."!")
    for i, enemy in ipairs(enemies) do
        print(enemy[i].posX,enemy[i].posY.."sind schon besetzt")
        if round(toX,2) == round(enemy[i].posX,2) and
        round(toY,2) == round(enemy[i].posY,2) then 
            print("Dort ist aber schon ein anderer Gegner")
            return true
        end
    end
    return false
end