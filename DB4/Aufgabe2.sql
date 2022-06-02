--   Geben Sie die fur jede Teilaufgabe n ¨ otigen ¨ Anderungsbefehle ¨ in einer geeigneten Reihenfolge an, so dass keine hangenden Verweise (dangling references) entstehen

-- a) Das silberfarbige Teil mit der Bezeichnung Fluxkompensator und einem Gewicht von 140 kommt auf den Markt und soll in die Teileliste aufgenommen werden. Der Lieferant Krause beliefert die Projekte P1 und P5, jeweils mit genau einem dieser Teile.

INSERT T (tnr, tname, farbe, gewicht)
VALUES ("T7", "FLUXKOMPENSATOR", "SILBER", 140);


INSERT LTP (lnr ,tnr, pnr, menge)
VALUES ("L5", "T7", "P1",1);

INSERT LTP (lnr ,tnr, pnr, menge)
VALUES ("L5", "T7", "P5",1);


-- b) Die Mengen aller bei Projekt P4 von Lieferant mit Nummer L1 gelieferten Teile sollen verdoppelt werden.

UPDATE LTP
SET menge = 2*menge;
WHERE pnr = "P4" AND lnr="L1";


-- c) Der Lieferant Schulz wird vom Konkurrenten Schmidt aufgekauft. Der Lieferant Schulz sol daher aus der Datenbank gelöscht werden. Der neue Name des Lieferanten Schmidt ¨ andert sich auf Schmidt-Schulz ¨und der Status erhoht sich um 10. Alle Projekte die von Schulz beliefert werden sollten, werden nun ¨ von Schmidt-Schulz beliefert. (Es kann davon ausgegangen werden, dass Schmidt und Schulz nicht die gleichen Teile an die gleichen Projekte liefern.)

UPDATE L
SET lname = "SCHMIDT-SHULZ", status = status + 10
WHERE lnr = "L3";

UPDATE LTP 
SET lname = "SCHMIDT-SHULZ"
WHERE lnr = "L4"

DELETE FROM L WHERE lnr = "L4";