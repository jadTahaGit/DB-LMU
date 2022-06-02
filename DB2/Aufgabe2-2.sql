CREATE TABLE L (
Lnr INTEGER PRIMARY KEY,
lname VARCHAR(100) NOT NULL,
sitz VARCHAR(100)
);


CREATE TABLE T (
tnr INTEGER PRIMARY KEY,
tname VARCHAR(100) NOT NULL,
farbe VARCHAR(100),
gewicht FLOAT,
preis DECIMAL(8,4) CHECK(preis > 0.0)
);

CREATE TABLE P (
pnr INTEGER PRIMARY KEY,
pname VARCHAR(100) NOT NULL,
ort VARCHAR(100)
);

CREATE TABLE LTP(
    lnr INTEGER REFERENCES L (lnr),
    tnr INTEGER REFERENCES T (tnr),
    pnr INTEGER REFERENCES P (pnr),
    menge INTEGER CHECK(menge > 0),
    PRIMARY KEY (lnr, tnr, pnr)
);

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- b) 



ALTER TABLE P ADD (status INT DEFAULT (5) );


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- c) Ändern Sie den DAtentyp Attr. gewicht in eine ganze Zahl größer als 0;



ALTER TABLE T MODIFY(gewicht INT);
ALTER TABLE T ADD CONSTRAINT gewicht_constraint CHECK(gewicht > 0);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- d) Löschen Sie Spalte ort aus P:

ALTER TABLE P DROP(ort);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- e) Löschen Sie Alle Tabele Ohne Refernzielle Intergrität zu verletzen.

DROP TABLE LTP;
DROP TABLE L;
DROP TABLE T;
DROP TABLE P;
