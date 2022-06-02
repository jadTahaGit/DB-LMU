-- Bestimmen die Namen aller Lifernten mit Sitz Berlin und einem Status von mindestens 15.

SELECT DISTINCT lname 
FROM L 
WHERE sitz = 'BERLIN' AND status >= 15

-- b) Bestimme eine Liste aller Teilnamen und der Namen der Liefaranten, die diese liefern. Benutze dabei 
-- für die SQL Anfrage in der FROM Klausel auschließlich den Natural Join

SELECT DISTINCT tname, lname 
FROM LTP 
NATURAL JOIN L
NATURAL JOIN T

--  c) Finde die Namen aller Lieferanten, die Teile mit einem Einzelgewicht von mehr als 16 liefern! Benutze dabei für die SQL-Anfrage in der From-Klausel ausschließlich das JOIN-ON-Konstrukt.

SELECT DISTINCT lname
FROM LTP JOIN L ON LTP.lnr = L.lnr JOIN T ON LTP.tnr = T.tnr
WHERE gewicht > 16;

-- d) Bestimme die Orte der Projekte, bei denen Lieferant Schmidt beteiligt ist. Benutze dabei für die SQL Anfrage in der FROM Klausel ausschließlich das JOIN-USING-Konstrakt


SELECT DISTINCT ort
FROM LTP JOIN L USING (lnr) JOIN P USING (pnr)
WHERE lname = "SCHMIDT";


-- e) Bestimme Namen und Farben aller Teile, mit denen sowohl Projekt P3 als auch Projekt P4 beliefert werden. Benutze dabei für die SQL-Anfrage in der FROM-Klausel ausschließlich das Kreuzprodukt.

SELECT DISTINCT tname, farbe
FROM LTP ltp1, T, LTP ltp2
WHERE ltp1.tnr = T.tnr AND ltp2.tnr = T.tnr
AND ltp1.pnr = "P3"
AND ltp2.pnr = "P4";