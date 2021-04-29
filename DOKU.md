## **Dokumentation**

### zum Development von "Escape from Agony "

---

So kompliziert wie nötig so simpel wie möglich

Mithilfe dieser Dokumentation und den Kommentaren zwischen dem Code soll das angestrebte Konzept und die Herangehensweise des Projekts aus der Development Sicht kleinteilig erläutert werden

Sie dient außerdem dazu den momentanen Status darzustellen

---

### **Konfiguration** {conf}

- Die Konfiguration Datei bietet die Möglichkeit bestimmte Eigenschaften des Spiels (vorerst) als Standard festzulegen (Titel, Fenster Größe)
- Die Konsole wird während des Ausführens wie dort beschrieben auch automatisch gestartet um die Suche nach Fehlern und das Debuggen zu vereinfachen

---

### **Haupt** {main}

- Die "Main" Datei ist die Datei die ausgeführt wird und in der alle Spiel-Elemente direkt oder indirekt untergebracht werden müssen

- Dort wird neben den wichtigen Funktionen ein GameState {gameState} beschrieben, das im Grunde nur ein String ist, welcher beschreibt in welchem Status sich das Spiel befindet (Spiel Status {"Game"}, Haupt/Pausen Menü {"MainMenu"}).
  An den entsprechenden Stellen (in anderen Dateien) wird der String dann passend verändert um in den gewünschten GameState zu kommen. Der GameState wird logisch in der Main Datei abgefragt um die entsprechenden Funktionen zum dazugehörigen GameState auszuführen.

- In gleicher Form kann das Level System umgesetzt werden
  - Dadurch könnten die einzelnen Level aus dem Hauptmenü aufgerufen werden und somit auch das Speichern des Spiels überflüssig gemacht werden

---

### **Feld** {tile}

- Eine alleinstehende Datei die als eine der wenigen nicht auf Elemente aus anderen Dateien zugreift
- Vorausgehend muss klar sein wie viele "Tiles" (zukünftig auch Felder genannt) das Spiel haben soll
- Um ein skalierbares Spiel zu haben muss die Höhe {tile.height} und Breite {tile.width} der Felder abhängig von der Höhe {absY} und Breite {absX} des Spiel Fensters sein
  - Die Höhe und Breite sind somit prozentual festgelegt

---

### **Spielfeld** {playboard}

- Auch hier müssen die prozentualen Werte des Playboards, also Spielfelds, schon bekannt sein
- Der Startpunkt {startX,startY}, der Leerraum zwischen den Feldern {disX,disY} und der Abstand wo ein Feld und das nächste Feld anfängt {blankX,blankY} werden festgelegt (alle abhängig von der Fenster Größe)
- Mit der gewünschten Anzahl an Feldern wird ein 2 dimensionales Array {boardArray}
  (ähnlich zu der Felder Beschreibung von Schach nur exklusiv mit Zahlen) erschaffen und zunächst mit leerem einem leeren Array gefüllt
- In der Load Funktion {playboard:load()}werden die Quadranten dann mit den X- und Y-Achsen Pixel Positionen vervollständigt
  - Dabei ist zu beachten, dass die ersten beiden eckigen Klammern die "Quadranten" Position beschreibt (Array[QuadrantX][QuadrantY]; wie bei Schach a8 (oben links) = boardArray[1][1]). Die dritte in eckigen Klammern stehende Zahl steht für die X oder Y Position ( [1] oder [2])
    - Dadurch enstehen zwar redundante Informationen, da z.B. alle Felder in der zweiten Y-Reihe den selben Y-Wert haben sprich: "boardArray[2][1][2] == boardArray[4][1][2]", jedoch kann dadurch jede einzelne mögliche Position genau angesprochen und angefragt werden
- In der Draw Funktion {playboard:draw(dt)} wird das eben vervollständigte Spielfeld als Rechtecke "gemalt"
  - Dies kann auch durch ein Spielfeld Sprite ersetzt werden und ist ausschließlich zur visuellen Darstellung

---

### **Hintergrund** {background}

- Lädt und setzt das Hintergrundbild (muss in der Main Datei als erstes gemalt werden um auf der "untersten Ebene" zu sein)
  - durch Einführen eines "LevelStates" könnten die verschiedenen Background Sprites gesetzt werden

---

### **Figur** {figure}

- Soll allgemeine Parameter beschreiben, die jede Figur haben soll
  - Figur Höhe {figur.height} und Breite {figure.width} (in dieser Form durch Benutzung von Sprites überflüssig geworden)
  - Die Distanz der Figur zu der oberen linken Ecke {figDistX,figDistY} um die Figur mittig auf einem Feld/Tile zu positionieren
  - Bewegungs Limit {moveLimit} (Wie viele Felder weit kann sich die Figur bewegen)
  - In welche Richtung "guckt" die Figur {figureDir} (Sprite wird gespiegelt, oder nicht)

### **Spieler / Gegner** {player}/{enemy}

- Relevante Figuren Parameter sollen überschrieben werden (Move Limit)
- Spieler / Gegner Informationen werden geladen
  - Sprites werden geladen
  - Platzierung auf Spielfeld {playPosX,playPosY}/{enePosX,enePosY}
- Blickrichtung des Spielers /Gegners werden geupdated
- Figuren werden "gemalt"

---

### **Picker** {picker}

- Die wohl wirklich wichtigste Datei
- Der Picker existiert zur Bewegung, Steuerung und Navigierung auf dem Spielfeld
- Die Datei umschließt verschiedene Booleans
  - Ist eine Figur ausgewählt {isSelected}
  - Ist angehovertes Feld leer {isEmpty}
  - Kann angegriffen werden {canAttack}(muss bei mehreren Spieler/Gegner Figuren angepasst werden)
  - Ist Zug des Spielers {yourTurn}
- Der Picker bedient sich aus dem Spielfeld Array für die Positionen und der Feld Größen für die eigene Größe, wobei ersteres in einer Laden Funktion geladen werden muss, weil das Spielfeld auch erst in einer Laden Funktion bestückt wird (möglicherweise muss dies nicht der Fall sein)
  - Die Dimensionen des Pickers {picker.width,picker.height} entsprechen denselben eines einzelnen Feldes/ Tiles 
  - Hier bekommt der Picker auch seine Start Position {pickPosX,pickPosY}
- Die Update Funktion {picker:update(dt)} führt nur die Bewegungs-Funktion {movePicker()} aus

  - **!!Jegliche Bewegungen sollten noch gerundet werden um "Mikro" Fehler zu vermeiden!!**
  - Das Drücken einer Taste wird durch eine weitere Funktion {love.keypressed(...)} erfasst
    - Bewegungen des Pickers sind mit den WASD und den Pfeiltasten möglich, solange der Picker mit der Eingabe nicht ein non existierendes Feld außerhalb des Spielfelds ansteuert
    - Es kann sich nur ein Feld pro Tasten Anschlag weiter beweget werden. Diagonale Bewegungen sind nicht möglich
    - Bei passender Eingabe wird der entsprechende Koordinaten Wert (Bei "W","S" = Y; "A","D" = X) angepasst und direkt aktualisiert. Die zurückgelegte Distanz ist identisch zu der im Playboard beschrieben Distanz zwischen den Anfängen zweier nebeneinander liegenden Felder {blankX,blankY}, damit sich der Picker komplett auf den bestehenden Spielfeldern bewegt
    - Die Leertaste "Auswahl"-Taste führt die später beschriebene "Auswahl und Bestätigung" Funktion {selectAndConfirm(...)} aus, mit dem Argument der Position der ausgewählten Figur (eine elegantere Lösung wäre das einfache Übergeben der Figur und nicht nur ihre Position, was jedoch ein in Java Klassen ähnliches Verhalten vorschreibt)
    - Die X "Auswahl beenden" Taste beendet die Auswahl einer Figur und setzt dafür den Boolean {isSelected} auf false
    - Mit der Escape Taste soll das der GameState auf {"PauseMenu"} geändert und somit das Pausen Menü aufgerufen werden
    - Mit der R "Reset" Taste wird das Spielfeld auf den Anfangs Zustand zurückgesetzt (Hauptsächlich notwendig für Test Zwecke)

- Die "Auswahl" Funktion {selected} (nicht zu verwechseln mit der "Auswahl und Bestätigung" Funktion {selectAndConfirm}) prüft ob auf der Position des Pickers sich die Position des übergebenen Argumentes (z.B der Spieler Figur) befindet, wenn dies der Fall ist wird der Boolean, das eine Figur ausgewählt ist {isSelected} auf "true" gesetzt
- Die "Auswahl und Bestätigung" Funktion {selectAndConfirm} beinhaltet eine Vielzahl an Überprüfungen und löst, falls noch keine Figur ausgewählt ist, die "Auswahl" Funktion {selected} aus
  - Bei ausgewählter Figur {isSelected} wird zunächst mithilfe der "Ist leer" Funktion {isEmpty()} überprüft ob das ausgewählte Feld leer ist und ebenso die auch später näher erläuterte Funktion MoveLimit {moveLimit(...)} ausgeführt, beides um sicher zu stellen, dass die gewünschte Bewegung zulässig ist
    - Die Figur Position wird dann einfach mit der Position des Pickers überschrieben (Hier würde im besten Fall eine Bewegungs Animation noch aufgerufen werden)
    - Folgend wird die ebenfalls später erklärte "Nahe Gegner" Funktion {nearEnemy()} ausgeführt
    - Der Zug des Spielenden wird beendet. Dafür wird der entsprechende Boolean {yourTurn} "geswitched"
    - Die Auswahl einer Figur {isSelected} wird beendet
  - Falls das angesteuerte Feld nicht leer ist {isEmpty()}, aber angegriffen werden kann {canAttack}, wird das angegriffene Objekt ins Jenseits befördert und der Spielzug beendet (!Beachte kommende Problematik bei der "Ist leer" Funktion!)

- Die "Ist leer" Funktion {isEmpty()} wird ausschließlich in konditionalen Abfragen ausgeführt und gibt direkt einen boolean Wert zurück
  - !Problematik! 
    - Es wurde zunächst ausgegangen mit dieser Funktion auch durch Terrain / Umgebung nicht begehbare Felder zu beachten, jedoch wird praktisch nur die Positionen der Figuren beachtet und ist auch nur als solches umgesetzt (mit eingeführtem Terrain würde man dieses durch die Umsetzung noch angreifen können, solange auch ein Gegner in Reichweite ist)
    - Der Name "ist kein Gegner" {isNotEnemy()} wäre passender und eine seperate Funktion für Umgebung wäre möglicherweise die bessere Lösung
    - Zusätzlich müsste die Funktion mit einem Argument aufgerufen werden müssen, mit einer Liste aller Positionen der gegnerischen Figuren
  - Es findet eine Abfrage statt, ob auf der mit dem Picker ausgewählten Postion sich schon eine gegnerische Figur befindet

- Die "nahe Gegner" Funktion {nearEnemy()} ist dafür verantwortlich den "Kann angegriffen" Boolean zu verändern
  - Wenn sich ein Gegner in unmittelbarer Reichweite befindet (direkt an eigenem Feld anschließend) kann angegriffen werden
  - Auch diese Funktion bräuchte Argumente um die ausgewählte Figur zu bestimmen und die Gegner Positionen zu wissen

- Die "Bewegungs Limit" Funktion {moveLimit(...)} gibt nach Ausführung, wie die "ist Leer" Funktion, einen Boolean zurück
  - Der Boolean ist erfüllt, wenn die Bewegungs Limitation der ausgewählten Figur nicht überschritten wird
    - Dafür wird die absolute Differenz der gewünschten Position und der momentanen Position in Relation mit dem Abstand zweier Felder gesetzt und das ganze noch gerundet um Fehler zu umgehen
    - Dies kann dann mit der individuellen Bewegungs Limitation der ausgewählten Figur verglichen werden und ein entsprechender Boolean Wert zurückgegeben werden

---

### **Farbige Felder** {colorTiles}
- Um eine visuelle Unterstützung für den Spieler zu bieten wie weit sich eine Figur bewegen kann werden die erreichbaren Felder nach Auswahl der Figur farbig markiert
  - Die Datei nimmt sich zuerst die Informationen über das Spielfeld {boardArray} => {colorTilesBoard}
  - In der Draw Funktion wird sobald eine Figur ausgewählt wird das eigene Array durchlaufen und nach dem Vorbild der "Bewegungs Limit" Funktion aus der Picker Datei, jedes erreichbare Feld markiert

---
 ### **Menü** {menu}
 - Mit dieser Datei wird sowohl das Haupt als auch, noch kommend, das Pausenmenü definiert
 - Diese Datei wird nur ausgeführt wenn der GameState mit dem Hauptmenü beschrieben ist
 - In der Update Funktion wird auf Tastendruck gewartet
    - Mit der Leertaste wird das GameState auf Spiel {"Game"} geändert
    - Mit Escape wird das ganze Programm geschlossen
    - Mit einem funktionalem Menü wird eine Menü Führung durch die Unterpunkte mit den WASD und Pfeiltasten möglich sein
  - In der Draw Funktion wird das noch sehr "minimalistische" Menü gemalt, welches auch durch ein Sprite ersetzt werden könnte




## **Ende der DOKU**
