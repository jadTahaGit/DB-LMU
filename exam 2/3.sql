SELECT Vorname, Nachname 
FROM Person 
WHERE PLZ < 80798 AND Nachname = "Huber";




SELECT Person.ID, Person.Vorname, Person.Nachname 
FROM Mitglied JOIN Person
ON Mitglied.Person = Person.ID
GROUP BY Person.ID 
Having COUNT(Distinct Mitglied.Verein)>=3
ORDER BY Person.Vorname DESC;



-- i) Vereine die am meisten gewonenn haben

CREATE VIEW MatchView AS 
SELECT 
ID,
if(Tore1 > Tore2, Verein1, Verein2) as Gewinner 
FROM MATCH 
WHERE Tore1 != Tore2


SELECT Gewinner, Verein.name, COUNT(Gewinner) as Gewonnen
FROM MatchView JOIN ON MatchView.Gewinner = Verein.ID
GROUP BY Gewinner
ORDER BY Gewonnen DESC