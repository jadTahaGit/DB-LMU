-- Formulieren Sie folgende Anfragen in der Datenbanksprache SQL. Formulieren Sie die Teilaufgaben a) und b)
-- jeweils einmal mit Hilfe von Join-Operationen und einmal nur mittels Unterabfragen ohne Join oder Kreuzprodukt.

-- a) Finden Sie die Nummern und Namen aller Projekte in denjenigen Orten, in denen Lieferant Meier oder Lieferant Krause seinen Sitz hat. (Zusatzanforderung beachten!)

-- Mit JOIN
SELECT DISTINCT  P.pnr, pname
FROM LTP NATURAL JOIN P NATURAL JOIN L
WHERE lname = "Meier" AND ort = sitz   OR  lname =  "Krause"   AND ort = sitz

-- Ohne Join:
SELECT P.pnr, pname FROM P WHERE ort IN (SELECT sitz FROM L WHERE lname = "Meier" OR lname = "Krause")


-- b) Finden Sie die Namen aller Projekte, fur die Lieferant L2 Teile liefert, deren Gewicht h ¨ ochstens 18 ist. ¨(Zusatzanforderung beachten!)

-- Mit Join
SELECT DISTINCT pname FROM LTP NATURAL JOIN T NATURAL JOIN P NATURAL JOIN L WHERE L.lnr = "L2" AND gewicht < 18

--Ohne Join
SELECT pname FROM P WHERE pnr IN (SELECT pnr FROM LTP WHERE lnr = "L2" AND tnr IN (SELECT 
tnr FROM T WHERE gewicht < 18))


-- c) Erzeugen Sie eine Liste aller Teile mit Gewicht, Farbe und Name und zwar alphabetisch absteigend sortiert nach der Farbe, bei gleicher Farbe aufsteigend sortiert nach dem Gewicht.

SELECT tname, farbe, gewicht FROM T ORDER BY farbe DESC, gewicht ASC

-- d) Bestimmen Sie Name, Farbe und Gewicht des Teils bzw. der Teile mit dem kleinsten Gewicht, d.h. es gibt kein Teil mit geringerem Gewicht.

SELECT tname, farbe, gewicht FROM T T1 WHERE NOT EXISTS (SELECT * FROM T T2 WHERE T1.gewicht>T2.gewicht)


SELECT tname, farbe, gewicht FROM T WHERE gewicht <= ALL (SELECT gewicht FROM T)

SELECT tname, farbe, gewicht FROM T WHERE gewicht = (SELECT MIN(gewicht) FROM T)


-- e) Finden Sie die Nummern und Namen aller Projekte, die von mindestens zwei Lieferanten mit einem Status von jeweils hochstens 25 beliefern werden.

-- Looping on this one
-- SELECT COUNT(DISTINCT L.lnr) FROM L NATURAL JOIN LTP WHERE status <= 25 AND pnr = "p1"

SELECT pnr FROM P WHERE (SELECT COUNT(DISTINCT L.lnr) FROM L NATURAL JOIN LTP WHERE status <= 25 AND P.pnr = LTP.pnr) >=2