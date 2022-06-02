CREATE TABLE Teilnehmer(
    TNr INTEGER PRIMARY KEY,
    Vorname VARCHAR(100),
    Nachname VARCHAR(100) NOT NULL,
    Geburtsdatun CHAR(10),
    Wohnort VARCHAR(100)
);

CREATE TABLE Gruppe(
    GNr INTEGER PRIMARY KEY,
    Gruppenname VARCHAR(100) NOT NULL,
    Leiter INTEGER REFERENCES Teilnehmer(TNr);
);

CREATE TABLE Mitglied (
    Teilnehmer INTEGER REFERENCES Teilnehmer (TNr),
    Gruppe INTEGER REFERENCES Gruppe (GNr)
);


--------

SELECT GNr, Gruppenname
FROM Gruppe NATURAL JOIN Hackathon
WHERE Hackathon.Ort = "Hannover" AND Hackathon.Kapazität > 15


SELECT Name
FROM Hackathon
WHERE Hackathon.Ort = "Hannover" AND Hackathon.Kapazität > 15


------

CREATE VIEW JAD1 AS 
SELECT Datum, COUNT(DISTINCT HNr) AS anzahlHack
FROM Hackathon
GROUP BY Datum;

SELECT Datum FROM JAD1 
WHERE anzahlHack = (SELECT MAX(anzahlHack) FROM JAD1);


-----


Create VIEW Jad2 AS
SELECT Gruppe, SUM(Punkte) AS allPunkte 
FROM Teilnahme
GROUP BY Gruppe;

SELECT Gruppe, IF(allPunkte = NULL, 0, allPunkte)  FROM  Jad2




