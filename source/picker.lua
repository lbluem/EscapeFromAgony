--[[ "Picker" zum Navigieren und Steuern der Figuren
    (siehe Beispiel "Advance War 2") ]]

--[[ require "source/enemy" ]]

--[[ Objekterstellung des Pickers ]]
picker = {}

--[[ Parameter ]]

--[[ Eine Figur wurde und ist ausgewählt ]]
isSelected = false
--[[ Das "angehoverte" Tile/Feld ist frei ]]
isEmpty = true
--[[ Spieler ist in Angriffsreichweite zu einem Gegner ]]
canAttack = false
--[[ Dein Zug? (Zug des Spielers) ]]
yourTurn = true

chosenEnemyType = 0
--[[ Ob man sich noch bewegen kann ]]
canMove = true

--[[ Wie oft in der Runde vom Spieler angegriffen wurde ]]
aCount = 0
--[[ Infos werden zuerst einmal geladen ]]
function picker:load()

    pickerImg = love.graphics.newImage("assets/interface/picker.png")
    --[[ Picker bekommt eigenen Array (aus playboard.lua)
    (evtl. überflüssig) ]]
    pickerArray = boardArray

    --[[ Start Position des Pickers im Array ]]
    pickPosX = pickerArray[1][1][1]
    pickPosY = pickerArray[1][1][2]

    --[[ Größe des Pickers = Größe eines Tiles (aus tile.lua)]]
    picker.width = tile.width
    picker.height = tile.height

end

function picker:update(dt)

    --[[ Funktion zur Bewegung des Pickers (siehe unten) ]]
    if playMenuState ~= "PopupMenu" and playMenuState ~= "ChangeMenu" then
        movePicker()
    end
end

function picker:draw(dt)

    --[[ Farbe des Pickers abhängig ob Figur ausgewählt ist ]]
    if isSelected then
        love.graphics.setColor(0.8,0.5,0.7)
    else 
        love.graphics.setColor(0.9,0.9,0.9)
    end
    --[[ Picker wird "gemalt" ]]
    --[[ love.graphics.setLineWidth(5)
    love.graphics.rectangle("line", pickPosX, pickPosY, picker.width, picker.height) ]]
    
    love.graphics.draw(pickerImg, pickPosX, pickPosY, 0, 0.125, 0.13, 65, 65)

end

--[[ Funktion zur Picker Bewegung
    UND weitere Optionen ]]
function movePicker()

    --[[ Bewegung sowohl mit WASD als auch mit Pfeiltasten möglich; 
        wird eingeschränkt um nicht außerhalb des Arrays zu navigieren]]
    function love.keypressed(key, scancode, isrepeat)
        if key == "w" or key == "up" then
            if pickPosY > pickerArray[1][1][2]+1 then
                pickPosY = round(pickPosY - blankY,2)
            end
        end
        if key == "a" or key == "left" then
            if pickPosX > pickerArray[1][1][1]+1 then
                pickPosX = round(pickPosX - blankX,2)
                if pickPosX < player.posX then
                    figureDir = 1
                end
            end
        end
        if key == "s" or key == "down" then
            if pickPosY < pickerArray[1][4][2]-1 then
                pickPosY = round(pickPosY + blankY,2)
            end
        end
        if key == "d" or key == "right" then
            if pickPosX < pickerArray[5][1][1]-1 then
                pickPosX = round(pickPosX + blankX,2)
                if pickPosX >= player.posX then
                    figureDir = -1
                end
            end
        end


        --[[ "Auswahl" Taste ]]
        if key == "space" then
            --[[ print("SELECT") ]]
            --[[ Funktion zum Auswählen und Bestätigen wird ausgeführt
            mit Argument der Position der ausgewählten Figur]]
            selectAndConfirm()
        end
        --[[ "Auswahl beenden" Taste ]]
        if key == "x" then
            --[[ print("DESELECT") ]]
            isSelected = false
            --[[ gameState = "Dialogue" ]]
        end  
        --[[ "Pause Menu" Taste ]]   
        if key == "escape" then
            if playMenuState ~= "PopupMenu" and playMenuState ~= "ChangeMenu" then
                --[[ "Spiel Status" wird auf Pausenmenü geschaltet ]]
                gameState = "MainMenu"
            end
        end
        --[[ Reset Button (Nur für Development)]]
        if key == "r" then
            print(#enemies)
            isSelected = false
            yourTurn = true
            canAttack = false
            canMove = true
            player.posX = boardArray[1][1][1]
            player.posY = boardArray[1][1][2]
            if #enemies == 0 then
                x1 = love.math.random(3,5)
                y1 = love.math.random(2,4)
                addEnemy(1,x1,y1)
                repeat
                    x2 = love.math.random(3,5)
                    y2 = love.math.random(2,4)
                until x1 ~= x2 and y1 ~= y2
                addEnemy(2,x2,y2)
            end
            pickPosX = pickerArray[1][1][1]
            pickPosY = pickerArray[1][1][2]
        end
        --[[ Spielfigur wechseln ]]
        if key == "c" then
            print(canMove)
            if canMove then
                isSelected = false
                refreshChars()
                playMenuState = "ChangeMenu"
            end
        end

        if key == "1" then
            levelState = 1
        end
        if key == "2" then
            levelState = 2
        end
        if key == "3" then
            levelState = 3
        end
    end
end

--[[ Auswahl einer Figur, falls sich Picker an entsprechender Position befindet ]]
function selected()
    --[[ Ganz eventuell muss noch gerundet werden ]]
    if pickPosX == player.posX and pickPosY == player.posY  then
        isSelected = true
    end
  
end

--[[ Die ALLES Funktion ]]
function selectAndConfirm()
    if playMenuState ~= "PopupMenu" and playMenuState ~= "ChangeMenu" then

        --[[ Falls ein Spieler bereits "ausgewählt" wurde ]]
        if isSelected then

            nearEnemy(players[playerOnBoard].aRange)
            isEmptyFunc()
            --[[ das Tile/Feld leer ist und das Bewegungs Limit nicht überschritten wurde]]
            if isEmpty and moveLimit(player.posX,player.posY) and canMove then 
                --[[ bewegt sich die Figur zur Position des Pickers ]]
                --[[ print("Figur bewegt sich") ]]
                player.posX = round(pickPosX,2)
                player.posY = round(pickPosY,2)
                
                --[[ Nach der Bewegung wird überprüft ob ein Gegner in der Nähe ist ]]
                nearEnemy(players[playerOnBoard].aRange)
                canMove = false
                --[[ Zug wird beendet ]]
                if not canAttack then
                    aCount = 0
                    yourTurn = false
                else
                    playMenuState = "PopupMenu"
                end
                --[[ Die Auswahl der Figur wird beendet ]]
                isSelected = false
                
            --[[ Angriff falls Tile nicht leer und angegriffen werden kann ]]
            elseif not isEmpty and canAttack then
                --[[ print("ich greife an") ]]
                
                if players[playerOnBoard].combo == 1 then
                    aCount = aCount + 1
                end             
                enemy[chosenEnemyType].hp = enemy[chosenEnemyType].hp - 1
    
                if enemy[chosenEnemyType].hp <= 0 then
                    table.remove(enemy,chosenEnemyType)
                    table.remove(enemies,chosenEnemyType)
                    print("Der "..chosenEnemyType.."te Gegner wurde deleted")
                end
                if #enemies == 0 then
                    gameState = "Dialogue"
                end
                if players[playerOnBoard].combo ~= 1 or aCount >= 2 then 
                    aCount = 0
                    yourTurn = false
                    isSelected = false
                end
                nearEnemy(players[playerOnBoard].aRange)
                isEmptyFunc()
                if isEmpty and not canMove then
                    yourTurn = false
                    print("ich tue was ich soll")
                end
                
            elseif not isEmpty then
                --[[ print("Da ist ein Gegnaaaaar") ]]
            end
        --[[ Falls noch kein Spieler ausgewählt ist 
        (Dies passiert normalerweise zuerst) ]]
        else
            selected()
        end  
    end
end

--[[ Checkt ob Gegner in unmittelbarer Reichweite ist 
    "isNotEnemy" wäre zur Zeit eig. ein passenderer Name]]
function isEmptyFunc()

    --[[ Die Plus und Minus Einsen sind um minimalste Fehler zu vermeiden
    eleganter wäre wohl das Runden Pixel Position ]]

    --[[ Überprüft ob Tile/Feld beim Picker leer ist (kein Gegner oder Terrain) 
        und gibt direkt einen boolean zurück]]
    for i, enemy in ipairs(enemies) do
        if pickPosX >= enemies[i][i].posX -1 and pickPosX <= enemies[i][i].posX +1 and pickPosY >= enemies[i][i].posY -1 and pickPosY <= enemies[i][i].posY +1 then
            isEmpty = false
            return
        else
            --[[ Debugging:
            enePickDistX = pickPosX - enemy.posX
            enePickDistY = pickPosY - enemy.posY
            print("Picker-Gegner Entfernung: ", enePickDistX, enePickDistY) ]]
            isEmpty = true
        end
    end
end

--[[ Funktion zum Testen ob ein Gegner höchstens ein Feld entfernt ist
    (nicht diagonal) ]]
function nearEnemy(atkRange)

    --[[ Auch hier sollte das +1, -1 durch das Runden ersetzt werden ]] 

    for i, enemy in ipairs(enemies) do
        --[[ Wenn Figur-Position auf gleicher Breite (X-Achse) wie der Gegner ist ]]
        if round(player.posX,2) == round(enemy[i].posX,2) then
            --[[ und dann Gegner nicht mehr als ein Tile/Feld entfernt ist kann angegriffen werden ]]
            if round(player.posY + (blankY*atkRange),2) >= round(enemies[i][i].posY,2) 
            and round(player.posY - (blankY*atkRange),2) <= round(enemies[i][i].posY,2) then
                --[[ print("Gegner nearby") ]]
                chosenEnemyType = i
                canAttack = true
                return
            else
                canAttack = false
            end
        
        --[[ Wenn Figur-Position auf gleicher Höhe (Y-Achse) wie der Gegner ist ]]
        elseif round(player.posY,2) == round(enemy[i].posY,2) then
            --[[ print("Auf der gleichen Y-Achse") ]]
            --[[ und dann Gegner nicht mehr als ein Tile/Feld entfernt ist kann angegriffen werden ]]
            if round(player.posX + (blankX*atkRange),2) >= round(enemies[i][i].posX,2)
            and round(player.posX - (blankX*atkRange),2) <= round(enemies[i][i].posX,2) then
                --[[ print("Gegner nearby") ]]
                chosenEnemyType = i
                canAttack = true
                return
            else
                canAttack = false
            end
        else
            canAttack = false
        end
    end
end

--[[ Boolean ob sich Figur zur ausgewählten Position bewegen kann ]]
function moveLimit(thisPosX, thisPosY)

    --[[ Distanz zwischen Picker und bewegende Figur
    darf nicht über MoveLimit sein ]]

    --[[ Eigenes MoveLimit momentan aus "player.lua" (evtl. überflüssig) ]]
    thisMoveLimit = playMoveLimit

    if isSelected then
        if math.abs(pickPosX - thisPosX) <= thisMoveLimit*blankX+1 and
        math.abs(pickPosY - thisPosY) <= thisMoveLimit*blankY+1 then

            --[[ Abstand wird gerundet um es 
            mit dem MoveLimit vergleichen zu können]]
            xDist = math.floor(math.abs((pickPosX - thisPosX) / blankX)*1+.5)/1
            yDist = math.floor(math.abs((pickPosY - thisPosY) / blankY)*1+.5)/1
            if xDist + yDist > thisMoveLimit then
                return false
            else
                return true
            end
        else
            return false
        end
    end
end

function round(x,fact)
    return (math.floor(x * 10^fact + 0.5) / 10^fact)
end