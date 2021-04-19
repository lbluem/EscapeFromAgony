--[[ "Picker" zum Navigieren und Steuern der Figuren
    (siehe Beispiel "Advance War 2") ]]

require("source/enemy")

--[[ Objekterstellung des Pickers ]]
picker = {}

--[[ Parameter ]]

--[[ Eine Figur wurde und ist ausgewählt ]]
isSelected = false
--[[ Das "gehoverte" Tile/Feld ist frei ]]
isEmpty = true
--[[ Spieler ist in Angriffsreichweite zu einem Gegner ]]
canAttack = false

function picker:load()

    --[[ Picker bekommt eigenen Array (evtl. überflüssig) ]]
    pickerArray = boardArray

    --[[ Start Position des Pickers im Array ]]
    pickPosX = pickerArray[1][2][1]
    pickPosY = pickerArray[1][2][2]

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
        love.graphics.setColor(0.8,1,0.9)
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
            if pickPosY > pickerArray[1][1][2] then
                pickPosY = pickPosY - blankY
            end
        end
        if key == "a" or key == "left" then
            if pickPosX > pickerArray[1][1][1] then
                pickPosX = pickPosX - blankX
            end
        end
        if key == "s" or key == "down" then
            if pickPosY < pickerArray[1][4][2] then
                pickPosY = pickPosY + blankY
            end
        end
        if key == "d" or key == "right" then
            if pickPosX < pickerArray[5][1][1] then
                pickPosX = pickPosX + blankX
            end
        end



        --[[ "Auswahl" Taste ]]
        if key == "space" then
            print("SELECT")
            --[[ Funktion zum Auswählen und Bestätigen ]]
            selectAndConfirm()
        end
        --[[ "Auswahl beenden" Taste ]]
        if key == "x" then
            print("DESELECT")
            isSelected = false
        end  
        --[[ "Programm schließen" Taste ]]   
        if key == "escape" then
            love.event.quit()
        end
    end
end

function selected()
    --[[ Wenn Picker auf Spieler ist wird Figur "ausgewählt" ]]
    if pickPosX == figPosX and pickPosY == figPosY then
        isSelected = true
        print("Figur ausgewaehlt")
    end
end

function selectAndConfirm()

    --[[ Falls ein Spieler bereits "ausgewählt" wurde ]]
    if isSelected then
        --[[ und das Tile/Feld leer ist ]]
        if isEmpty() then 
            --[[ bewegt sich die Figur zur Position des Pickers ]]
            print("Figur bewegt sich")
            figPosX = pickPosX
            figPosY = pickPosY
            --[[ Die Auswahl der Figur wird beendet ]]
            isSelected = false
            --[[ Nach der Bewegung wird überprüft ob ein Gegner in der Nähe ist ]]
            nearEnemy()
        --[[ Angriff falls Tile nicht leer und angegriffen werden kann ]]
        elseif not isEmpty() and canAttack then
            print("mach kaputt")
            enePosX = -100000
        end
        
    else
        --[[ Dies passiert normalerweise zuerst ]]
        selected()
    end  
end

function isEmpty()

    --[[ Überprüft ob Tile/Feld beim Picker leer ist (kein Gegner oder Terrain) 
        und gibt direkt einen boolean zurück]]
    if pickPosX == enePosX and pickPosY == enePosY then
        print("Da ist ein Gegner")
        return false
    else
        return true
    end

end

--[[ Funktion zum Testen ob ein Gegner höchstens ein Feld entfernt ist
    (nicht diagonal) ]]
function nearEnemy()

    --[[ Wenn Figur-Position auf gleicher Breite (X-Achse) wie der Gegner ist ]]
    if figPosX == enePosX then
        --[[ und dann Gegner nicht mehr als ein Tile/Feld entfernt ist kann angegriffen werden ]]
        if figPosY + blankY == enePosY or figPosY - blankY == enePosY then
            print("Gegner nearby")
            canAttack = true
        end
    --[[ Wenn Figur-Position auf gleicher Höhe (Y-Achse) wie der Gegner ist ]]
    elseif figPosY == enePosY then
        --[[ und dann Gegner nicht mehr als ein Tile/Feld entfernt ist kann angegriffen werden ]]
        if figPosX + blankX == enePosX or figPosX - blankX == enePosX  then
            print("Gegner nearby")
            canAttack = true
        end
    end

end