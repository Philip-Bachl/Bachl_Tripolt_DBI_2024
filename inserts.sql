-- Insert data into "Filiale"
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (1, 'Filiale A', 'Adresse A', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (2, 'Filiale B', 'Adresse B', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (3, 'Filiale C', 'Adresse C', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (4, 'Filiale D', 'Adresse D', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (5, 'Filiale E', 'Adresse E', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (6, 'Filiale F', 'Adresse F', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (7, 'Filiale G', 'Adresse G', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (8, 'Filiale H', 'Adresse H', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (9, 'Filiale I', 'Adresse I', NULL);
INSERT INTO Filiale (Id, Name, Adresse, Manager_Id) VALUES (10, 'Filiale J', 'Adresse J', NULL);

-- Insert data into "Mitarbeiter"
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (1, 'Max', 'Mustermann', 3000, 1);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (2, 'Erika', 'Musterfrau', 3200, 2);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (3, 'John', 'Doe', 3100, 3);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (4, 'Jane', 'Doe', 3300, 4);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (5, 'Alice', 'Smith', 3400, 5);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (6, 'Bob', 'Johnson', 3500, 6);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (7, 'Charlie', 'Brown', 3600, 7);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (8, 'David', 'Wilson', 3700, 8);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (9, 'Eva', 'Davis', 3800, 9);
INSERT INTO Mitarbeiter (Id, Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES (10, 'Frank', 'Martinez', 3900, 10);

-- Insert data into "Futter"
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter A', 2.50);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter B', 3.00);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter C', 1.75);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter D', 2.80);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter E', 3.20);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter F', 1.90);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter G', 2.60);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter H', 3.10);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter I', 1.80);
INSERT INTO Futter (Name, Preis_kg) VALUES ('Futter J', 2.70);

-- Insert data into "Art"
INSERT INTO Art (Id, Name, Beschreibung) VALUES (1, 'Art A', 'Beschreibung A');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (2, 'Art B', 'Beschreibung B');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (3, 'Art C', 'Beschreibung C');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (4, 'Art D', 'Beschreibung D');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (5, 'Art E', 'Beschreibung E');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (6, 'Art F', 'Beschreibung F');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (7, 'Art G', 'Beschreibung G');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (8, 'Art H', 'Beschreibung H');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (9, 'Art I', 'Beschreibung I');
INSERT INTO Art (Id, Name, Beschreibung) VALUES (10, 'Art J', 'Beschreibung J');

-- Insert data into "Tier"
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier A', 'Futter A', 50, 5.5, 1);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier B', 'Futter B', 60, 6.0, 2);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier C', 'Futter C', 70, 7.0, 3);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier D', 'Futter D', 80, 8.0, 4);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier E', 'Futter E', 90, 9.0, 5);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier F', 'Futter F', 100, 10.0, 6);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier G', 'Futter G', 110, 11.0, 7);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier H', 'Futter H', 120, 12.0, 8);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier I', 'Futter I', 130, 13.0, 9);
INSERT INTO Tier (Name, Futter_Name, Groesse_cm, Gewicht_kg, Art_Art_Id) VALUES ('Tier J', 'Futter J', 140, 14.0, 10);

-- Insert data into "Tier_ist_in_Filiale"
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (1, 'Tier A', 5);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (2, 'Tier B', 6);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (3, 'Tier C', 7);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (4, 'Tier D', 8);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (5, 'Tier E', 9);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (6, 'Tier F', 10);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (7, 'Tier G', 11);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (8, 'Tier H', 12);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (9, 'Tier I', 13);
INSERT INTO Tier_ist_in_Filiale (Filiale_Id, Tier_Name, Anzahl) VALUES (10, 'Tier J', 14);

-- Insert data into "Filiale_hat_Futter"
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (1, 'Futter A', 1000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (2, 'Futter B', 2000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (3, 'Futter C', 3000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (4, 'Futter D', 4000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (5, 'Futter E', 5000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (6, 'Futter F', 6000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (7, 'Futter G', 7000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (8, 'Futter H', 8000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (9, 'Futter I', 9000);
INSERT INTO Filiale_hat_Futter (Filiale_Id, Futter_Name, Gewicht_Gramm) VALUES (10, 'Futter J', 10000);

-- Insert data into "Staat"
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (1, 'Staat A', 'Bezeichnung A');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (2, 'Staat B', 'Bezeichnung B');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (3, 'Staat C', 'Bezeichnung C');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (4, 'Staat D', 'Bezeichnung D');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (5, 'Staat E', 'Bezeichnung E');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (6, 'Staat F', 'Bezeichnung F');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (7, 'Staat G', 'Bezeichnung G');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (8, 'Staat H', 'Bezeichnung H');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (9, 'Staat I', 'Bezeichnung I');
INSERT INTO Staat (Id, Name, Bezeichnung) VALUES (10, 'Staat J', 'Bezeichnung J');

-- Insert data into "Ort"
INSERT INTO Ort (PLZ, Ort) VALUES (1010, 'Ort A');
INSERT INTO Ort (PLZ, Ort) VALUES (1020, 'Ort B');
INSERT INTO Ort (PLZ, Ort) VALUES (1030, 'Ort C');
INSERT INTO Ort (PLZ, Ort) VALUES (1040, 'Ort D');
INSERT INTO Ort (PLZ, Ort) VALUES (1050, 'Ort E');
INSERT INTO Ort (PLZ, Ort) VALUES (1060, 'Ort F');
INSERT INTO Ort (PLZ, Ort) VALUES (1070, 'Ort G');
INSERT INTO Ort (PLZ, Ort) VALUES (1080, 'Ort H');
INSERT INTO Ort (PLZ, Ort) VALUES (1090, 'Ort I');
INSERT INTO Ort (PLZ, Ort) VALUES (1100, 'Ort J');

-- Insert data into "Kunde"
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (1, 'Kunde A', 'Nachname A', '123456789', 'kundeA@example.com', 'Strasse 1', 1, 1010, 'Ort A');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (2, 'Kunde B', 'Nachname B', '234567890', 'kundeB@example.com', 'Strasse 2', 2, 1020, 'Ort B');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (3, 'Kunde C', 'Nachname C', '345678901', 'kundeC@example.com', 'Strasse 3', 3, 1030, 'Ort C');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (4, 'Kunde D', 'Nachname D', '456789012', 'kundeD@example.com', 'Strasse 4', 4, 1040, 'Ort D');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (5, 'Kunde E', 'Nachname E', '567890123', 'kundeE@example.com', 'Strasse 5', 5, 1050, 'Ort E');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (6, 'Kunde F', 'Nachname F', '678901234', 'kundeF@example.com', 'Strasse 6', 6, 1060, 'Ort F');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (7, 'Kunde G', 'Nachname G', '789012345', 'kundeG@example.com', 'Strasse 7', 7, 1070, 'Ort G');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (8, 'Kunde H', 'Nachname H', '890123456', 'kundeH@example.com', 'Strasse 8', 8, 1080, 'Ort H');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (9, 'Kunde I', 'Nachname I', '901234567', 'kundeI@example.com', 'Strasse 9', 9, 1090, 'Ort I');
INSERT INTO Kunde (Id, Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort) VALUES (10, 'Kunde J', 'Nachname J', '012345678', 'kundeJ@example.com', 'Strasse 10', 10, 1100, 'Ort J');

-- Insert data into "Bestellung"
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (1, 1, 1);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (2, 2, 2);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (3, 3, 3);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (4, 4, 4);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (5, 5, 5);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (6, 6, 6);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (7, 7, 7);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (8, 8, 8);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (9, 9, 9);
INSERT INTO Bestellung (Id, Kunde_Id, Filiale_Id) VALUES (10, 10, 10);

-- Insert data into "Bestellung_hat_Tier"
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (1, 'Tier A');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (2, 'Tier B');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (3, 'Tier C');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (4, 'Tier D');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (5, 'Tier E');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (6, 'Tier F');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (7, 'Tier G');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (8, 'Tier H');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (9, 'Tier I');
INSERT INTO Bestellung_hat_Tier (Bestellung_Id, Tier_Name) VALUES (10, 'Tier J');

-- Insert data into "Bestellung_hat_Futter"
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (1, 'Futter A');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (2, 'Futter B');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (3, 'Futter C');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (4, 'Futter D');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (5, 'Futter E');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (6, 'Futter F');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (7, 'Futter G');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (8, 'Futter H');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (9, 'Futter I');
INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (10, 'Futter J');
