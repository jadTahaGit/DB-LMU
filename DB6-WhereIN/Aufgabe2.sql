-- a) Finden Sie die Namen aller Lieferanten, die alle Projekte in Wetter beliefern.
SELECT lname FROM L WHERE NOT EXISTS(SELECT * 
FROM P WHERE ort ="BERLIN"
AND NOT EXISTS(SELECT * FROM LTP 
WHERE LTP.pnr = P.nr
AND LTP.lnr = L.lnr))



-- b) Finden Sie die Namen aller Lieferanten, die kein Projekt in Berlin beliefern.
SELECT lname 
FROM L 
WHERE NOT EXISTS (SELECT * FROM P NATURAL JOIN LTP 
WHERE ort = "BERLIN" 
AND lnr = L.lnr)