
-- -----------------------------------------------------
-- Table "Filiale"
-- -----------------------------------------------------
CREATE TABLE Filiale (
  Id NUMBER NOT NULL,
  Name VARCHAR2(45) NOT NULL,
  Adresse VARCHAR2(50) NOT NULL,
  Manager_Id NUMBER NULL,
  PRIMARY KEY (Id)
);

-- -----------------------------------------------------
-- Table "Mitarbeiter"
-- -----------------------------------------------------
CREATE TABLE Mitarbeiter (
  Id NUMBER NOT NULL,
  Vorname VARCHAR2(30) NOT NULL,
  Nachname VARCHAR2(30) NOT NULL,
  Gehalt NUMBER NOT NULL,
  Arbeitet_in_Filiale_Id NUMBER NOT NULL,
  PRIMARY KEY (Id)
);

ALTER TABLE Mitarbeiter
  ADD CONSTRAINT fk_Mitarbeiter_Filiale1
  FOREIGN KEY (Arbeitet_in_Filiale_Id)
  REFERENCES Filiale (Id);

ALTER TABLE Filiale
  ADD CONSTRAINT fk_Filiale_Mitarbeiter1
  FOREIGN KEY (Manager_Id)
  REFERENCES Mitarbeiter (Id);

-- -----------------------------------------------------
-- Table "Futter"
-- -----------------------------------------------------
CREATE TABLE Futter (
  Name VARCHAR2(40) NOT NULL,
  Preis_kg NUMBER NOT NULL,
  PRIMARY KEY (Name)
);

-- -----------------------------------------------------
-- Table "Art"
-- -----------------------------------------------------
CREATE TABLE Art (
  Id NUMBER NOT NULL,
  Name VARCHAR2(45) NULL,
  Beschreibung VARCHAR2(45) NULL,
  PRIMARY KEY (Id),
  UNIQUE (Name)
);

-- -----------------------------------------------------
-- Table "Tier"
-- -----------------------------------------------------
CREATE TABLE Tier (
  Name VARCHAR2(40) NOT NULL,
  Futter_Name VARCHAR2(40) NOT NULL,
  Groesse_cm NUMBER NOT NULL,
  Gewicht_kg NUMBER NOT NULL,
  Art_Art_Id NUMBER NOT NULL,
  PRIMARY KEY (Name)
);

ALTER TABLE Tier
  ADD CONSTRAINT fk_Tier_Futter1
  FOREIGN KEY (Futter_Name)
  REFERENCES Futter (Name);

ALTER TABLE Tier
  ADD CONSTRAINT fk_Tier_Art1
  FOREIGN KEY (Art_Art_Id)
  REFERENCES Art (Id);

-- -----------------------------------------------------
-- Table "Tier_ist_in_Filiale"
-- -----------------------------------------------------
CREATE TABLE Tier_ist_in_Filiale (
  Filiale_Id NUMBER NOT NULL,
  Tier_Name VARCHAR2(40) NOT NULL,
  Anzahl NUMBER NOT NULL,
  PRIMARY KEY (Filiale_Id, Tier_Name)
);

ALTER TABLE Tier_ist_in_Filiale
  ADD CONSTRAINT fk_Filiale_has_Tier_Filiale
  FOREIGN KEY (Filiale_Id)
  REFERENCES Filiale (Id);

ALTER TABLE Tier_ist_in_Filiale
  ADD CONSTRAINT fk_Filiale_has_Tier_Tier1
  FOREIGN KEY (Tier_Name)
  REFERENCES Tier (Name);

-- -----------------------------------------------------
-- Table "Filiale_hat_Futter"
-- -----------------------------------------------------
CREATE TABLE Filiale_hat_Futter (
  Filiale_Id NUMBER NOT NULL,
  Futter_Name VARCHAR2(40) NOT NULL,
  Gewicht_Gramm NUMBER NOT NULL,
  PRIMARY KEY (Filiale_Id, Futter_Name)
);

ALTER TABLE Filiale_hat_Futter
  ADD CONSTRAINT fk_Filiale_has_Futter_Filiale1
  FOREIGN KEY (Filiale_Id)
  REFERENCES Filiale (Id);

ALTER TABLE Filiale_hat_Futter
  ADD CONSTRAINT fk_Filiale_has_Futter_Futter1
  FOREIGN KEY (Futter_Name)
  REFERENCES Futter (Name);

-- -----------------------------------------------------
-- Table "Staat"
-- -----------------------------------------------------
CREATE TABLE Staat (
  Id NUMBER NOT NULL,
  Name VARCHAR2(45) NULL,
  Bezeichnung VARCHAR2(45) NULL,
  PRIMARY KEY (Id)
);

-- -----------------------------------------------------
-- Table "Ort"
-- -----------------------------------------------------
CREATE TABLE Ort (
  PLZ NUMBER NOT NULL,
  Ort VARCHAR2(45) NOT NULL,
  PRIMARY KEY (PLZ, Ort)
);

-- -----------------------------------------------------
-- Table "Kunde"
-- -----------------------------------------------------
CREATE TABLE Kunde (
  Id NUMBER NOT NULL,
  Vorname VARCHAR2(45) NULL,
  Nachname VARCHAR2(45) NULL,
  Telefonnummer VARCHAR2(45) NULL,
  Email VARCHAR2(45) NULL,
  StraßeUndHausnummer VARCHAR2(45) NULL,
  Staat_Id NUMBER NOT NULL,
  Ort_PLZ NUMBER NOT NULL,
  Ort_Ort VARCHAR2(45) NOT NULL,
  PRIMARY KEY (Id)
);

ALTER TABLE Kunde
  ADD CONSTRAINT fk_Kunde_Staat1
  FOREIGN KEY (Staat_Id)
  REFERENCES Staat (Id);

ALTER TABLE Kunde
  ADD CONSTRAINT fk_Kunde_Ort1
  FOREIGN KEY (Ort_PLZ, Ort_Ort)
  REFERENCES Ort (PLZ, Ort);

-- -----------------------------------------------------
-- Table "Bestellung"
-- -----------------------------------------------------
CREATE TABLE Bestellung (
  Id NUMBER NOT NULL,
  Kunde_Id NUMBER NOT NULL,
  Filiale_Id NUMBER NOT NULL,
  PRIMARY KEY (Id)
);

ALTER TABLE Bestellung
  ADD CONSTRAINT fk_Bestellung_Kunde1
  FOREIGN KEY (Kunde_Id)
  REFERENCES Kunde (Id);

ALTER TABLE Bestellung
  ADD CONSTRAINT fk_Bestellung_Filiale1
  FOREIGN KEY (Filiale_Id)
  REFERENCES Filiale (Id);

-- -----------------------------------------------------
-- Table "Bestellung_hat_Tier"
-- -----------------------------------------------------
CREATE TABLE Bestellung_hat_Tier (
  Bestellung_Id NUMBER NOT NULL,
  Tier_Name VARCHAR2(40) NOT NULL,
  PRIMARY KEY (Bestellung_Id, Tier_Name)
);

ALTER TABLE Bestellung_hat_Tier
  ADD CONSTRAINT fk_Bestellung_has_Tier_Bestellung1
  FOREIGN KEY (Bestellung_Id)
  REFERENCES Bestellung (Id);

ALTER TABLE Bestellung_hat_Tier
  ADD CONSTRAINT fk_Bestellung_has_Tier_Tier1
  FOREIGN KEY (Tier_Name)
  REFERENCES Tier (Name);

-- -----------------------------------------------------
-- Table "Bestellung_hat_Futter"
-- -----------------------------------------------------
CREATE TABLE Bestellung_hat_Futter (
  Bestellung_Id NUMBER NOT NULL,
  Futter_Name VARCHAR2(40) NOT NULL,
  PRIMARY KEY (Bestellung_Id, Futter_Name)
);

ALTER TABLE Bestellung_hat_Futter
  ADD CONSTRAINT fk_Bestellung_has_Futter_Bestellung1
  FOREIGN KEY (Bestellung_Id)
  REFERENCES Bestellung (Id);

ALTER TABLE Bestellung_hat_Futter
  ADD CONSTRAINT fk_Bestellung_has_Futter_Futter1
  FOREIGN KEY (Futter_Name)
  REFERENCES Futter (Name);
