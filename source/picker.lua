--[[ "Picker" zum Navigieren und Steuern der Figuren
    (siehe Beispiel "Advance War 2") ]]

--[[ require "source/enemy" ]]

--[[ Objekterstellung des Pickers ]]
picker = {}

--[[ Parameter ]]
pickDist = 0
--[[ Eine Figur wurde und ist ausgewählt ]]
isSelected = false
--[[ Das "gehoverte" Tile/Feld ist frei ]]
isEmpty = true
--[[ Spieler ist in Angriffsreichweite zu einem Gegner ]]
canAttack = false
--[[ Dein Zug? ]]
yourTurn = true

function picker:load()

    --[[ Picker bekommt eigenen Array (evtl. überflüssig) ]]
    pickerArray = boardArray

    --[[ Start Position des Pickers im Array ]]
    pickPosX = pickerArray[1][1][1]
    pickPosY = pickerArray[1][1][2]

    --[[ Größe des Pickers = Größe eines Tiles ]]
    picker.width = tile.width
    picker.height = tile.height

end

function picker:update(dt)

    --[[ Funktion zur Bewegung des Pickers (siehe unten) ]]
    movePicker()

end

function picker:draw(dt)

    --[[ Farbe des Pickers welche sich bei Auswahl eines Spielers verändert ]]
    if isSelected then
        love.graphics.setColor(0.8,0.5,0.7)
    else 
        love.graphics.setColor(0.9,0.9,0.9)
    end
    --[[ Picker wird "gemalt" ]]
    love.graphics.rectangle("fill", pickPosX, pickPosY, picker.width, picker.height)

end

--[[ Funktion zur Picker Bewegung
    UND weitere Optionen ]]
function movePicker()

    --[[ Bewegung sowohl mit WASD als auch mit Pfeiltasten möglich; 
        eingeschränkt um nicht außerhalb des Arrays zu navigieren]]
    function love.keypressed(key, scancode, isrepeat)
        if key == "w" or key == "up" then
            if pickPosY > pickerArray[1][1][2]+1 then
                pickPosY = pickPosY - blankY
            end
        end
        if key == "a" or key == "left" then
            if pickPosX > pickerArray[1][1][1]+1 then
                pickPosX = pickPosX - blankX
                figureDir = 1
            end
        end
        if key == "s" or key == "down" then
            if pickPosY < pickerArray[1][4][2]-1 then
                pickPosY = pickPosY + blankY
            end
        end
        if key == "d" or key == "right" then
            if pickPosX < pickerArray[5][1][1]-1 then
                pickPosX = pickPosX + blankX
                figureDir = -1
            end
        end



        --[[ "Auswahl" Taste ]]
        if key == "space" then
            --[[ print("SELECT") ]]
            nearEnemy()
            --[[ Funktion zum Auswählen und Bestätigen ]]
            if yourTurn then selectAndConfirm(playPosX, playPosY) else selectAndConfirm(enePosX, enePosY) end
        end
        --[[ "Auswahl beenden" Taste ]]
        if key == "x" then
            --[[ print("DESELECT") ]]
            isSelected = false
        end  
        --[[ "Programm schließen" Taste ]]   
        if key == "escape" then
            gameState = "MainMenu"
            --[[ love.event.quit() ]]
        end
        --[[ Reset Button ]]
        if key == "r" then
            isSelected = false
            yourTurn = true
            playPosX = boardArray[1][1][1]
            playPosY = boardArray[1][1][2]
            enePosX = boardArray[4][3][1]
            enePosY = boardArray[4][3][2]
            pickPosX = pickerArray[1][1][1]
            pickPosY = pickerArray[1][1][2]
        end
    end
end

function selected(thisPosX, thisPosY)
    --[[ Wenn Picker auf Spieler ist wird Figur "ausgewählt" ]]
    if pickPosX >= thisPosX-1 and pickPosX <= thisPosX +1 and pickPosY >= thisPosY-1 and pickPosY <= thisPosY +1 then
        isSelected = true
        --[[ print("Figur ausgewaehlt") ]]
    --[[ else ]]
        --[[ nur für Print ]]
        --[[ figPickDistX = pickPosX - thisPosX
        figPickDistY = pickPosY - thisPosY ]]
        --[[ print("Entfernung: ",figPickDistX, figPickDistY) ]]
    end
end

--[[ Die ALLES Funktion ]]
function selectAndConfirm(thisPosX, thisPosY)

    --[[ Falls ein Spieler bereits "ausgewählt" wurde ]]
    if isSelected then
        --[[ und das Tile/Feld leer ist ]]
        if isEmpty() and moveLimit(thisPosX,thisPosY) then 
            --[[ bewegt sich die Figur zur Position des Pickers ]]
            print("Figur bewegt sich")
            if yourTurn then
                playPosX = pickPosX
                playPosY = pickPosY
            else
                enePosX = pickPosX
                enePosY = pickPosY
            end
            --[[ Nach der Bewegung wird überprüft ob ein Gegner in der Nähe ist ]]
            nearEnemy()
            --[[ thisPosX = pickPosX
                thisPosY = pickPosY ]]
            --[[ Zug wird beendet ]]
            if yourTurn then yourTurn = false else yourTurn = true end
            --[[ Die Auswahl der Figur wird beendet ]]
            isSelected = false
            
        --[[ Angriff falls Tile nicht leer und angegriffen werden kann ]]
        elseif not isEmpty() and canAttack then
            isSelected = false
            if yourTurn then
                enePosX = -100000
            else
            playPosX = -10000
            end
        elseif not isEmpty() then
            --[[ print("Da ist ein Gegnaaaaar") ]]
        end
        
    else
        --[[ Dies passiert normalerweise zuerst ]]
        selected(thisPosX, thisPosY)
    end  
end

--[[ Checkt ob Gegner da ist ]]
function isEmpty()

    --[[ Überprüft ob Tile/Feld beim Picker leer ist (kein Gegner oder Terrain) 
        und gibt direkt einen boolean zurück]]
    if yourTurn then
        if pickPosX >= enePosX -1 and pickPosX <= enePosX +1 and pickPosY >= enePosY -1 and pickPosY <= enePosY +1 then
            --[[ print("Da ist ein Gegner") ]]
            return false
        else
            enePickDistX = pickPosX - enePosX
            enePickDistY = pickPosY - enePosY
            --[[ print("Picker-Gegner Entfernung: ", enePickDistX, enePickDistY) ]]
            return true
        end
    else
        if pickPosX >= playPosX -1 and pickPosX <= playPosX +1 and pickPosY >= playPosY -1 and pickPosY <= playPosY +1 then
            --[[ print("Da ist ein Gegner") ]]
            return false
        else
            return true
        end
    end

end

--[[ Funktion zum Testen ob ein Gegner höchstens ein Feld entfernt ist
    (nicht diagonal) ]]
function nearEnemy()

    --[[ Wenn Figur-Position auf gleicher Breite (X-Achse) wie der Gegner ist ]]
    if playPosX >= enePosX -1 and playPosX <= enePosX +1 then
        --[[ und dann Gegner nicht mehr als ein Tile/Feld entfernt ist kann angegriffen werden ]]
        if playPosY + blankY >= enePosY -1 and playPosY + blankY <= enePosY +1 
        or playPosY - blankY >= enePosY -1 and playPosY - blankY <= enePosY +1 then
            if not yourTurn then
                print("Gegner nearby")
            end
            canAttack = true
        else
            canAttack = false
        end
    
    --[[ Wenn Figur-Position auf gleicher Höhe (Y-Achse) wie der Gegner ist ]]
    elseif playPosY >= enePosY -1 and playPosY <= enePosY +1 then
        --[[ print("Auf der gleichen Y-Achse") ]]
        --[[ und dann Gegner nicht mehr als ein Tile/Feld entfernt ist kann angegriffen werden ]]
        if playPosX + blankX >= enePosX -1 and playPosX + blankX <= enePosX +1
        or playPosX - blankX >= enePosX -1 and playPosX - blankX <= enePosX +1 then
            if not yourTurn then
                print("Gegner nearby")
            end
            canAttack = true
        else
            canAttack = false
        end
    else
        canAttack = false
    end
        

end

function moveLimit(thisPosX, thisPosY)

    --[[ Distanz zwischen Picker und bewegende Figur
    darf nicht über MoveLimit sein ]]

    --[[     print("x Abstand",math.abs(pickPosX - thisPosX),"Reichweite", 2*blankX+1)
    print("y Abstand",math.abs(pickPosY - thisPosY),"Reichweite", 2*blankY+1) ]]
    thisMoveLimit = playMoveLimit

    --[[ print(math.abs(pickPosY - thisPosY) % blankY) ]]
    if isSelected then
        if math.abs(pickPosX - thisPosX) <= thisMoveLimit*blankX+1 and
        math.abs(pickPosY - thisPosY) <= thisMoveLimit*blankY+1 then
            --[[ math.abs(pickPosY - thisPosY) / blankY ]]
            --[[ Rundet Abstand ]]
            yDist = math.floor(math.abs((pickPosY - thisPosY) / blankY)*1+.5)/1
            xDist = math.floor(math.abs((pickPosX - thisPosX) / blankX)*1+.5)/1
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