CREATE TABLE PERSON (
    Personen-ID INTEGER NOT NULL PRIMARY KEY,
    Vorname VARCHAR(50),
    Nachname VARCHAR(50),
);

CREATE TABLE Band (
    Bandname VARCHAR(50) NOT NULL PRIMARY KEY,
    Genre VARCHAR(50)
);


CREATE TABLE Musiker (
    Steuer-ID INTEGER NOT NULL PRIMARY KEY CHECK(Steuer-ID > 1407),
    Stimmlage VARCHAR(50),
    Instrument-ID INTEGER,
    Bezeichnung VARCHAR(50),
    Bandname VARCHAR(50) REFERENCES Band(Bandname) ON DELETE SET NULL,
    SeitJahr INTEGER CHECK(SeitJahr>=1900 AND SeitJahr<=2022)
);

CREATE TABLE Ticketkauf(
    Personen-ID INTEGER REFERENCES PERSON (Personen-ID) ON DELETE CASCADE,
    Bandname VARCHAR(50) REFERENCES Band (Bandname) ON DELETE CASCADE,
    Hallenname VARCHAR(50) NOT NULL,
    Stadt VARCHAR(50) NOT NULL,
    Preis DECIMAL(6,2) CHECK(Preis > Rabatt),
    Rabatt DECIMAL(6,2),
    FOREIGN KEY (Hallenname, Stadt) REFERENCES Konzerthalle ON DELETE CASCADE,
    PRIMARY KEY (Personen-ID, Bandname, Konzerthalle)
);


CREATE TABLE Konzerthalle (
    Hallenname VARCHAR(50) NOT NULL,
    Stadt VARCHAR(50) NOT NULL,
    PLZ INT CHECK(PLZ>0),
    PRIMARY KEY (Hallenname, Stadt)
);

CREATE TABLE PersonKennt(
    Person_1 REFERENCES PERSON (Personen-ID) ON DELETE CASCADE,
    Person_2 REFERENCES PERSON (Personen-ID) ON DELETE CASCADE,
    PRIMARY KEY (Person_1, Person_2)
);


CREATE TABLE PersonIstEinMusiker(
    Person-ID REFERENCES PERSON (Personen-ID) ON DELETE CASCADE,
    Steuer-ID REFERENCES Musiker (Steuer-ID) ON DELETE CASCADE,
    PRIMARY KEY (Person-ID, Steuer-ID)
);
