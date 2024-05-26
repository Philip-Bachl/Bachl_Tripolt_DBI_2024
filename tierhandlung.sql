CREATE TABLE Staat (
  Id INT PRIMARY KEY,
  Name VARCHAR2(45),
  Bezeichnung VARCHAR2(45)
);

CREATE TABLE Ort (
  PLZ INT NOT NULL,
  Ort VARCHAR2(45) NOT NULL,
  PRIMARY KEY (PLZ, Ort)
);

CREATE TABLE Futter (
  Name VARCHAR2(40) PRIMARY KEY,
  Preis_kg DECIMAL NOT NULL
);

CREATE TABLE Art (
  Id INT PRIMARY KEY,
  Name VARCHAR2(45),
  Beschreibung VARCHAR2(45)
);

CREATE TABLE Tier (
  Name VARCHAR2(40) PRIMARY KEY,
  Futter_Name VARCHAR2(40) NOT NULL,
  Groesse_cm INT NOT NULL,
  Gewicht_kg DECIMAL NOT NULL,
  Art_Art_Id INT NOT NULL,
  CONSTRAINT fk_Tier_Futter1 FOREIGN KEY (Futter_Name)
    REFERENCES Futter (Name),
  CONSTRAINT fk_Tier_Art1 FOREIGN KEY (Art_Art_Id)
    REFERENCES Art (Id)
);

CREATE TABLE Mitarbeiter (
  Id INT PRIMARY KEY,
  Vorname VARCHAR2(30) NOT NULL,
  Nachname VARCHAR2(30) NOT NULL,
  Gehalt DECIMAL NOT NULL,
  Arbeitet_in_Filiale_Id INT
);

CREATE TABLE Filiale (
  Id INT PRIMARY KEY,
  Name VARCHAR2(45) NOT NULL,
  Manager_Id INT,
  StraßeUndHausnummer VARCHAR2(45),
  Ort_PLZ INT NOT NULL,
  Ort_Ort VARCHAR2(45) NOT NULL,
  Staat_Id INT NOT NULL,
  CONSTRAINT fk_Filiale_Mitarbeiter1 FOREIGN KEY (Manager_Id)
    REFERENCES Mitarbeiter (Id),
  CONSTRAINT fk_Filiale_Ort1 FOREIGN KEY (Ort_PLZ, Ort_Ort)
    REFERENCES Ort (PLZ, Ort),
  CONSTRAINT fk_Filiale_Staat1 FOREIGN KEY (Staat_Id)
    REFERENCES Staat (Id)
);

CREATE TABLE Tier_ist_in_Filiale (
  Filiale_Id INT NOT NULL,
  Tier_Name VARCHAR2(40) NOT NULL,
  Anzahl INT NOT NULL,
  PRIMARY KEY (Filiale_Id, Tier_Name),
  CONSTRAINT fk_Filiale_has_Tier_Filiale FOREIGN KEY (Filiale_Id)
    REFERENCES Filiale (Id),
  CONSTRAINT fk_Filiale_has_Tier_Tier FOREIGN KEY (Tier_Name)
    REFERENCES Tier (Name)
);

CREATE TABLE Filiale_hat_Futter (
  Filiale_Id INT NOT NULL,
  Futter_Name VARCHAR2(40) NOT NULL,
  Gewicht_Gramm INT NOT NULL,
  PRIMARY KEY (Filiale_Id, Futter_Name),
  CONSTRAINT fk_Filiale_has_Futter_Filiale FOREIGN KEY (Filiale_Id)
    REFERENCES Filiale (Id),
  CONSTRAINT fk_Filiale_has_Futter_Futter FOREIGN KEY (Futter_Name)
    REFERENCES Futter (Name)
);

CREATE TABLE Kunde (
  Id INT PRIMARY KEY,
  Vorname VARCHAR2(45),
  Nachname VARCHAR2(45),
  Telefonnummer VARCHAR2(45),
  Email VARCHAR2(45),
  StraßeUndHausnummer VARCHAR2(45),
  Staat_Id INT NOT NULL,
  Ort_PLZ INT NOT NULL,
  Ort_Ort VARCHAR2(45) NOT NULL,
  CONSTRAINT fk_Kunde_Staat1 FOREIGN KEY (Staat_Id)
    REFERENCES Staat (Id),
  CONSTRAINT fk_Kunde_Ort1 FOREIGN KEY (Ort_PLZ, Ort_Ort)
    REFERENCES Ort (PLZ, Ort)
);

CREATE TABLE Bestellung (
  Id INT PRIMARY KEY,
  Kunde_Id INT NOT NULL,
  Filiale_Id INT NOT NULL,
  CONSTRAINT fk_Bestellung_Kunde1 FOREIGN KEY (Kunde_Id)
    REFERENCES Kunde (Id),
  CONSTRAINT fk_Bestellung_Filiale1 FOREIGN KEY (Filiale_Id)
    REFERENCES Filiale (Id)
);

CREATE TABLE Bestellung_hat_Tier (
  Bestellung_Id INT NOT NULL,
  Tier_Name VARCHAR2(40) NOT NULL,
  PRIMARY KEY (Bestellung_Id, Tier_Name),
  CONSTRAINT fk_Bestellung_has_Tier_Bestellung FOREIGN KEY (Bestellung_Id)
    REFERENCES Bestellung (Id),
  CONSTRAINT fk_Bestellung_has_Tier_Tier FOREIGN KEY (Tier_Name)
    REFERENCES Tier (Name)
);

CREATE TABLE Bestellung_hat_Futter (
  Bestellung_Id INT NOT NULL,
  Futter_Name VARCHAR2(40) NOT NULL,
  PRIMARY KEY (Bestellung_Id, Futter_Name),
  CONSTRAINT fk_Bestellung_has_Futter_Bestellung FOREIGN KEY (Bestellung_Id)
    REFERENCES Bestellung (Id),
  CONSTRAINT fk_Bestellung_has_Futter_Futter FOREIGN KEY (Futter_Name)
    REFERENCES Futter (Name)
);