## **Dokumentation**

### zum Development von "Escape from Agony "

---

So kompliziert wie nötig so simpel wie möglich

### **Conf** (Konfiguration)

- Die conf Datei bietet die Möglichkeit bestimmte Eigenschaften des Spiels als Standard festzulegen (Titel, Fenster Größe)
- Die Konsole wird während des Ausführens dadurch beschrieben automatisch gestartet

---

### **Main**

- Die Main Datei ist die Datei die ausgeführt wird und in der alle Spiel-Elemente direkt oder indirekt untergebracht werden müssen

- Dort wird neben den wichtigen Funktionen ein GameState beschrieben, das im Grunde nur ein String ist, welcher beschreibt in welchem Status sich das Spiel befindet (Spiel Status, Haupt/Pausen Menü).
  An den entsprechenden Stellen (in anderen Dateien) wird der String dann passend verändert um in den gewünschten GameState zu kommen. Der GameState wird logisch in der Main Datei abgefragt um die entsprechenden Funktionen zum dazugehörigen GameState auszuführen.

- In gleicher Form kann das Level System umgesetzt werden
  - Dadurch könnten die einzelnen Level aus dem Hauptmenü aufgerufen werden und somit auch das Speichern des Spiels überflüssig gemacht werden

---

### **Tile** (Felder)

- Eine alleinstehende Datei die als eine der wenigen nicht auf Elemente aus anderen Dateien zugreift
- Vorausgehend muss klar sein wie viele Felder das Spiel haben soll
- Um ein skalierbares Spiel zu haben muss die Höhe und Breite der Felder abhängig von der Höhe und Breite des Spiel Fensters sein
  - Die Höhe und Breite sind somit prozentual festgelegt

---

### **Playboard** (Spielfeld)

- Auch hier müssen die prozentualen Werte des Feldes schon bekannt sein
- Der Startpunkt, der Leerraum zwischen den Feldern und der Abstand wo ein Feld und das nächste Feld anfängt werden festgelegt (alle abhängig von der Fenster Größe)
- Mit der gewünschten Anzahl an Feldern wird ein 2 dimensionales Array
  (ähnlich zu der Felder Beschreibung von Schach nur exklusiv mit Zahlen) erschaffen und zunächst mit leerem Inhalt gefüllt
- In der Load Funktion werden die Quadranten dann mit der X- und Y-Achsen Pixel Position vervollständigt
  - Dabei ist zu beachten, dass die ersten beiden eckigen Klammern die "Quadranten" Position beschreibt (Array[QuadrantX][quadranty]; wie bei Schach a8 (oben links) = [1][1]). Die dritte in eckigen Klammern stehende Zahl steht für die X oder Y Achse ( [1] oder [2])
- In der Draw Funktion wird das eben vervollständigte Spielfeld als Rechtecke "gemalt"
  - Dies kann auch durch ein Spielfeld Sprite ersetzt werden und ist ausschließlich zur visuellen Veranschaulichung

---

### **Background**

- Lädt und setzt das Hintergrundbild (muss in der Main Datei als erstes gemalt werden um auf der "untersten Ebene" zu sein)
  - durch Einführen eines "LevelStates" könnten die verschiedenen Background Sprites gesetzt werden

---

### **Figure**

- Soll allgemeine Parameter beschreiben, die jede Figur haben soll
  - Figur Höhe und Breite (Durch Benutzung von Sprites überflüssig geworden)
  - Die Distanz der Figur zu der oberen linken Ecke um die Figur mittig zu positionieren
  - Bewegungs Limit (Wie viele Felder weit kann sich die Figur bewegen)
  - In welche Richtung guckt die Figur

### **Player / Enemy**

- Relevante Figuren Parameter sollen überschrieben werden (Move Limit)
- Spieler / Gegner Informationen werden geladen
  - Sprites werden geladen
  - Platzierung auf Spielfeld
- Blickrichtung des Spielers /Gegners werden geupdated
- Figuren werden "gemalt"

---

### **Picker**

- Die wohl wirklich wichtigste Datei
- Der Picker existiert zur Bewegung, Steuerung und Navigierung auf dem Spielfeld
- Die Datei umschließt verschiedene Booleans
  - Ist eine Figur ausgewählt
  - Ist angehovertes Feld leer
  - Kann angegriffen werden (muss bei mehreren Spieler/Gegnern Figuren angepasst werden)
  - Ist Zug des Spielers
-
