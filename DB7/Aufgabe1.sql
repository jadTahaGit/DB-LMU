-- a)  Bestimmen Sie Nummer und Name jedes Projektes zusammen mit der Anzahl der Lieferanten, die es beliefern.
SELECT pnr, pname, COUNT(DISTINCT lnr) 
FROM P NATURAL JOIN LTP 
GROUP BY pnr, pname; 

-- b)  Bestimmen Sie fur jeden Lieferanten (mit Nummer und Name) die Gesamtanzahl der von diesem gelie- ¨ferten Teile.

SELECT lnr, lname, SUM(menge)
FROM L NATURAL JOIN LTP
GROUP BY lnr, lname;

-- c) Bestimme fur alle Projekte, die von mindestens drei unterschiedlichen Lieferanten beliefert werden, die ¨ Nummer und den Namen des Projekts, sowie die Anzahl der unterschiedlichen gelieferten Teile.

SELECT pnr, pname, COUNT(DISTINCT tnr)
FROM P NATURAL JOIN LTP 
GROUP BY pnr, pname
HAVING COUNT(DISTINCT lnr) >=3 

-- d) Bestimmen Sie Nummer, Name und Ort jedes Projektes zusammen mit dem Namen der Teile, die dafur¨ benotigt werden, und dem Prozentsatz (gerundet auf zwei Nachkommastellen), den das Gesamtgewicht ¨ dieser Teile im Vergleich zum Gesamtgewicht aller Teile dieses Projektes ausmacht. Werden fur ein ¨ Projekt nur Teile einer Teilekategorie benotigt, so soll es nicht im Ergebnis enthalten sein. ¨ Ein Beispiel: Fur das Projekt UFO werden 200 Stecker mit einem Gewicht von je 15 ben ¨ otigt. Das Gesamtgewicht ¨ der fur UFO ben ¨ otigten Teile ist 7200. Also machen die Stecker 41.67% davon aus. Das entsprechende ¨ Ergebnistupel ist (’P1’, ’UFO’, ’BERLIN’, ’STECKER’, ’41.67’). 


-- Das Ergebnis soll sortiert werden: Aufsteigend nach der Projektnummer. Bei gleicher Projektnummer absteigend nach dem Prozentsatz, bei gleichem Prozentsatz lexikographisch nach dem Teilenamen. Runden: Zum Runden konnen Sie die Funktion ROUND benutzen. Beispielsweise wird das Ergebnis der ¨ Berechnung in folgender Anfrage auf drei Nachkommastellen gerundet : SELECT ROUND(menge*gewicht / 1000,3) FROM LTP NATURAL JOIN T Tipp: Erstellen Sie passende Views um die Anfrage ubersichtlicher zu gestalten. Benutzen Sie hierzu die ¨ Syntax aus der Vorlesung!

CREATE VIEW A AS 
SELECT pnr, pname, ort, tnr, tname,(menge * gewicht) AS liefergewicht
FROM P NATURAL JOIN LTP NATURAL JOIN T;

CREATE VIEW B AS SELECT pnr, pname, ort, tnr, tname, SUM(liefergewicht) AS TSUM 
FROM A
GROUP BY pnr, pname, ort, tnr, tname;

CREATE VIEW C AS 
SELECT pnr, pname, ort, SUM(TSUM) AS teileGesamtgewicht
FROM B
GROUP BY pnr, pname, ort;


SELECT  C.pnr, C.pname, C.ort, tname, ROUND((TSUM/teileGesamtgewicht)*100, 2) AS PERCENT
FROM C NATURAL JOIN B
WHERE TSUM < teileGesamtgewicht
ORDER BY pnr, PERCENT DESC, tname;

