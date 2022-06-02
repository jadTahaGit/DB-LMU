-- a) Finden Sie die Artikelnummer, die Artikelbezeichnung, den Lagerort und den Lagerbestand aller in Hamburg oder Munchen gelagerten Artikel.

SELECT art_nr, art_bez, lagerort, Lagerbest 
FROM Inventar
WHERE lagerort = "Muenchen" OR lagerort = "Hamburg"


-- b) Finden Sie fur alle in der Tabelle ¨ Auftragsposten gespeicherten Bestellungen des Artikels mit der Nummer 203333 die Auftragsnummer, die Artikelnummer, die bestellte Menge und alle Lagerbestaende und Lagerorte, an denen eine ausreichende Stuckzahl des Artikels 203333 vorhanden ist. 

SELECT auftr_nr , art_nr, menge, lagerbest, lagerort
FROM Inventar NATURAL JOIN Auftragsposten
WHERE lagerbest >= menge AND art_nr = 203333;

-- c) Finden Sie die Kundennummern derjenigen Kunden, die keinen Auftrag erteilt haben
SELECT  Kunde.kund_nr
FROM Verkauf RIGHT JOIN Kunde ON Verkauf.kund_nr = Kunde.kund_nr  
WHERE  Verkauf.kund_nr IS NULL;

-- ALternaive Mit NOT IN
SELECT kund_nr
FROM Kunde
WHERE kund_nr NOT IN (SELECT kund_nr FROM Verkauf);

-- Aternative Mit EXCEPT
SELECT kund_nr FROM Kunde 
EXCEPT 
SELECT kund_nr FROM Verkauf;



-- d) Gesucht sind die verschiedenen Lagerorte von Artikeln in der Tabelle Inventar, die einen Lagerbestand von mindestens 8 Exemplaren haben.

SELECT DISTINCT lagerort FROM Inventar WHERE lagerbest < 8;

-- e) Finden Sie den Vornamen und den Nachnamen derjenigen Angestellten, die einen oder mehrere Verkaeufe an Kunden aus Stuttgart bearbeitet haben.

SELECT DISTINCT vorname, nachname 
FROM Verkauf NATURAL JOIN Kunde  NATURAL JOIN Personal
WHERE ort = "Stuttgart";

-- f) Finden Sie den Nachnamen, Vornamen, Einsatzort und das Gehalt aller in der Tabelle Personal gespeicherten Angestellten. Das Ergebnis soll lexikographisch nach dem Einsatzort sortiert werden. Bei gleichem Einsatzort soll in absteigender Reihenfolge nach dem Gehalt sortiert werden.

SELECT nachname,vorname, einsatz, gehalt
FROM Personal
ORDER BY einsatz, gehalt DESC;


-- g) Finden Sie die Personalnummern und das Gehalt der Angestellten mit minimalem oder maximalem Gehalt.
SELECT pers_nr, gehalt FROM Personal 
WHERE gehalt = (SELECT MIN(gehalt) FROM Personal)
OR gehalt = (SELECT MAX(gehalt) FROM Personal);

-- h) Finden Sie fur jeden Einsatzort die Anzahl der dort eingesetzten Angestellten. ¨
SELECT COUNT(DISTINCT pers_nr)
FROM Personal
GROUP BY einsatz;

-- i) Wie hoch ist die durchschnittliche Anzahl Angestellter uber alle Einsatzorte?
CREATE VIEW A AS
SELECT einsatz, COUNT(DISTINCT pers_nr) AS NumOfPers
FROM Personal
GROUP BY einsatz;

CREATE VIEW B AS
SELECT SUM(NumOfPers) AS sum
FROM A;

CREATE VIEW C AS
SELECT COUNT(DISTINCT einsatz) AS num
FROM A;

SELECT (sum/num) AS durchschnittlicheAnzahl FROM B NATURAL JOIN C;

-- ALTERNATIV:
SELECT avg(temp.anzahl)
FROM (SELECT einsatz, COUNT(*) AS anzahl 
FROM Personal 
GROUP BY einsatz)temp;


-- j)Finden Sie fur jeden Artikel die Artikelnummer und die Summe der Lagerbestaende in den Lagerorten die den Artikel fuhren. Es sollen nur solche Artikel ausgegeben werden, die einen Gesamtbestand von ¨ mehr als 10 Stuck haben. 

CREATE VIEW J AS 
SELECT 	art_nr, SUM(lagerbest) AS allLagerbest 
FROM Inventar 
GROUP BY art_nr;


SELECT 	* FROM J
WHERE allLagerbest > 10;

-- ALTERNATIV:
SELECT 	art_nr, SUM(lagerbest) AS allLagerbest 
FROM Inventar
GROUP BY art_nr
HAVING sum(lagerbest) > 10;