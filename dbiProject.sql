--Mitarbeiter_Package
CREATE OR REPLACE PACKAGE Mitarbeiter_Package AS
    PROCEDURE ErhoeheGehalt(gehaltsgrenze NUMBER, erhoehung NUMBER);
    FUNCTION Durchschnittsgehalt RETURN NUMBER;
    PROCEDURE MitarbeiterDieAuchKundenSind;
    PROCEDURE EntlasseMitarbeiterAusFiliale(f_id NUMBER);
END Mitarbeiter_Package;
/

CREATE OR REPLACE PACKAGE BODY Mitarbeiter_Package AS
--Tripolt
    FUNCTION BerechneNeuesGehalt(altesGehalt NUMBER, erhoehung NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN altesGehalt + erhoehung;
    END;
--Tripolt
    PROCEDURE ErhoeheGehalt(gehaltsgrenze NUMBER, erhoehung NUMBER) IS
 	  e_no_raise EXCEPTION;
	BEGIN
    UPDATE Mitarbeiter
    SET Gehalt = BerechneNeuesGehalt(Gehalt, erhoehung)
    WHERE Gehalt < gehaltsgrenze;
	   	IF SQL%ROWCOUNT = 0 THEN
        RAISE e_no_raise; 
    	END IF;
	
	EXCEPTION
	WHEN e_no_raise THEN
		dbms_output.Put_line('Nobody got a raise');
	END;
--Tripolt
    FUNCTION Durchschnittsgehalt RETURN NUMBER IS v_durchschnitt NUMBER;
    BEGIN
      SELECT AVG(Gehalt) INTO v_durchschnitt FROM Mitarbeiter;
          return v_durchschnitt;
    END;
--Bachl
    MitarbeiterDieAuchKundenSind
    AS
        CURSOR c_mitarbeiter IS SELECT * FROM MITARBEITER;
        CURSOR c_kunden IS SELECT * FROM KUNDE;
    BEGIN
        FOR mit IN c_mitarbeiter
        LOOP
            FOR kun IN c_kunden
            LOOP
                IF mit.vorname = kun.vorname AND mit.nachname = kun.nachname THEN
                    DBMS_OUTPUT.PUT_LINE(mit.vorname||' '||mit.nachname);
                END IF;
            END LOOP;
        END LOOP;
    END;
--Bachl
    CREATE OR REPLACE PROCEDURE EntlasseMitarbeiterAusFiliale(f_id NUMBER)
    AS
        v_manager_id NUMBER(38,0);
        e_no_manager_found EXCEPTION;
    BEGIN
        SELECT m.id INTO v_manager_id 
        FROM mitarbeiter m INNER JOIN FILIALE f ON m.id = f.manager_id 
        WHERE f.id = f_id;
        
        UPDATE filiale f 
        SET f.manager_id = null
        WHERE f.id = f_id;
        
        DELETE FROM MITARBEITER m WHERE m.arbeitet_in_filiale_id = f_id;
        
        EXCEPTION WHEN no_data_found THEN
            DELETE FROM MITARBEITER m WHERE m.arbeitet_in_filiale_id = f_id;
    END;

END Mitarbeiter_Package;
/

--Filiale_Package
CREATE OR REPLACE PACKAGE Filiale_Package AS
    PROCEDURE GetFilialenMitTier(p_Tier_Name VARCHAR2);
    PROCEDURE GetMitarbeiterInFilialeWennGehaltGroesserAls (p_Filiale_Id IN NUMBER, p_Gehalt IN NUMBER);
    PROCEDURE getFilialenMitFutter (p_Futter_Name IN VARCHAR2);
    PROCEDURE fililialeWirdGeschlossen (p_OldFilialeId NUMBER , p_NewFilialeId NUMBER);
 END Filiale_Package;
/

CREATE OR REPLACE PACKAGE BODY Filiale_Package AS
--Tripolt
	PROCEDURE GetFilialenMitTier (p_Tier_Name VARCHAR2)
	IS
	BEGIN
	    FOR fil IN (
	        SELECT f.Id, f.Name
	        FROM Filiale f
	        JOIN Tier_ist_in_Filiale tf ON f.Id = tf.Filiale_Id
	        WHERE tf.Tier_Name = p_Tier_Name) 
	    LOOP
	        DBMS_OUTPUT.PUT_LINE(fil.Id || ' ' || fil.Name);
	    END LOOP;
	END;
--Tripolt
	PROCEDURE GetMitarbeiterInFilialeWennGehaltGroesserAls (p_Filiale_Id IN NUMBER, p_Gehalt IN NUMBER)
	IS
	    CURSOR mitarbeiterCursor IS
	        SELECT *
	        FROM Mitarbeiter m
	        WHERE m.Arbeitet_in_Filiale_Id = p_Filiale_Id
	          AND m.Gehalt > p_Gehalt;
	BEGIN
	    FOR mit IN mitarbeiterCursor LOOP
	        DBMS_OUTPUT.PUT_LINE('Mitarbeiter ID: ' || mit.Id || ' Vorname: ' || mit.Vorname || ' Nachname: ' || mit.Nachname || ' Gehalt: ' || mit.Gehalt);
	    END LOOP;
	END;
--Tripolt
    CREATE OR REPLACE PROCEDURE getFilialenMitFutter (p_Futter_Name IN VARCHAR2)
    IS
        CURSOR c_Futter IS
            SELECT f.Id, f.Name, ff.Gewicht_Gramm
            FROM Filiale f
            JOIN Filiale_hat_Futter ff ON f.Id = ff.Filiale_Id
            WHERE ff.Futter_Name = p_Futter_Name;
    BEGIN
        FOR fil IN c_Futter LOOP
            DBMS_OUTPUT.PUT_LINE('Filiale ID: ' || fil.Id || ' Filiale Name: ' || fil.Name || ' Verfügbare Menge in Gramm: ' || fil.Gewicht_Gramm);
        END LOOP;
    END;
--Tripolt
    PROCEDURE fililialeWirdGeschlossen (p_OldFilialeId NUMBER , p_NewFilialeId NUMBER) IS
    BEGIN
        UPDATE Bestellung
        SET Filiale_Id = p_NewFilialeId
        WHERE Filiale_Id = p_OldFilialeId;
        DBMS_OUTPUT.PUT_LINE('Filial Id bei allen Bestellungen geändert.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Fehler beim Ändern der Filial ID in der Bestellung: ');
    END;

END Filiale_Package;
/

--Kunden_Package
CREATE OR REPLACE PACKAGE Kunden_Package AS
    PROCEDURE AddGratisBestellungZuKundenInGermany;
    PROCEDURE AddVorwahlToTelefonnummer(vorwahl VARCHAR2, kunden_id NUMBER);
END Kunden_Package;
/

CREATE OR REPLACE PACKAGE BODY Kunden_Package AS
--Tripolt & Bachl
    PROCEDURE AddGratisBestellungZuKundenInGermany IS
        v_GermanyStateId NUMBER;
        v_FutterName VARCHAR2(40);
        v_BestellungId NUMBER;
        v_BestellungCount NUMBER;
    BEGIN
        SELECT Id INTO v_GermanyStateId FROM Staat WHERE Name = 'Germany';
        BEGIN
            SELECT Name INTO v_FutterName FROM Futter WHERE Name = 'Dog Food';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Futter Dog Food does not exist.');
                RETURN;
        END;


        FOR r IN (SELECT Id FROM Kunde WHERE Staat_Id = v_GermanyStateId) LOOP
            INSERT INTO Bestellung (Kunde_Id, Filiale_Id) VALUES (r.Id, 1);
            SELECT max(b.id) INTO v_BestellungCount FROM BESTELLUNG;
            INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (v_BestellungCount,v_FutterName);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Gratis Bestellungen wurden hinzugefügt.');
    END;
--Tripolt
    PROCEDURE AddVorwahlToTelefonnummer(vorwahl VARCHAR2, kunden_id NUMBER) AS
    BEGIN
        UPDATE Kunde k
        SET k.TELEFONNUMMER = CONCAT(vorwahl, k.Telefonnummer)
        WHERE  k.ID = kunden_id;
    END;
END Kunden_Package;
/

--Futter_Package
CREATE OR REPLACE PACKAGE Futter_Package AS
    PROCEDURE ErhoeheFutterPreis;
    PROCEDURE CalculateAverageFutterPrice;
END Futter_Package;
/

CREATE OR REPLACE PACKAGE BODY Futter_Package AS
--Tripolt
    PROCEDURE ErhoeheFutterPreis AS
    BEGIN
        UPDATE Futter
        SET Preis_kg = 
        CASE
            WHEN Preis_kg < 2 THEN Preis_kg + 2
            WHEN Preis_kg BETWEEN 2 AND 6 THEN Preis_kg + 1
            ELSE Preis_kg + 3
        END;
    END;
--Tripolt
    PROCEDURE CalculateAverageFutterPrice AS 
    no_Futter_Found EXCEPTION;
    avg_price NUMBER;
    futter_count NUMBER;
    BEGIN
	    
    SELECT COUNT(*) INTO futter_count
    FROM Futter;

    IF futter_count = 0 THEN
   		raise no_Futter_Found;
    END IF;

    SELECT AVG(Preis_kg) INTO avg_price
    FROM Futter;

    DBMS_OUTPUT.PUT_LINE(avg_price);
    EXCEPTION
    	WHEN no_Futter_Found THEN
			Raise_application_error(-20201,'No futter found, Cant calculate average!');
    END;
END Futter_Package;
/

--Trigger 
--Tripolt
CREATE OR REPLACE TRIGGER no_gmx
BEFORE INSERT ON Kunde
FOR EACH ROW
BEGIN
    IF REGEXP_LIKE(:NEW.Email, 'gmx', 'i') THEN
        RAISE_APPLICATION_ERROR(-20001, 'gmx is not allowed on this site');
    END IF;
END;

--Logging_Package

CREATE OR REPLACE PACKAGE logging_package AS
    PROCEDURE log_action(culprit VARCHAR2, changed_table VARCHAR);
END logging_package;
/

----

CREATE OR REPLACE PACKAGE BODY logging_package AS
--Bachl
    PROCEDURE log_action(culprit VARCHAR2, changed_table VARCHAR)
    AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(culprit||' changed table '||changed_table);
    END;
END logging_package;
/
--Bachl
CREATE OR replace TRIGGER log_ART_trigger
BEFORE INSERT OR UPDATE OR DELETE ON ART
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'ART');
END;

--Bachl
CREATE OR replace TRIGGER log_BESTELLUNG_trigger
BEFORE INSERT OR UPDATE OR DELETE ON BESTELLUNG
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'BESTELLUNG');
END;

--Bachl
CREATE OR replace TRIGGER log_BESTELLUNG_HAT_FUTTER_trigger
BEFORE INSERT OR UPDATE OR DELETE ON BESTELLUNG_HAT_FUTTER
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'BESTELLUNG_HAT_FUTTER');
END;

--Bachl
CREATE OR replace TRIGGER log_BESTELLUNG_HAT_TIER_trigger
BEFORE INSERT OR UPDATE OR DELETE ON BESTELLUNG_HAT_TIER
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'BESTELLUNG_HAT_TIER');
END;

--Bachl
CREATE OR replace TRIGGER log_FILIALE_trigger
BEFORE INSERT OR UPDATE OR DELETE ON FILIALE
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'FILIALE');
END;

--Bachl
CREATE OR replace TRIGGER log_FILIALE_HAT_FUTTER_trigger
BEFORE INSERT OR UPDATE OR DELETE ON FILIALE_HAT_FUTTER
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'FILIALE_HAT_FUTTER');
END;

--Bachl
CREATE OR replace TRIGGER log_FUTTER_trigger
BEFORE INSERT OR UPDATE OR DELETE ON FUTTER
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'FUTTER');
END;

--Bachl
CREATE OR replace TRIGGER log_KUNDE_trigger
BEFORE INSERT OR UPDATE OR DELETE ON KUNDE
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'KUNDE');
END;

--Bachl
CREATE OR replace TRIGGER log_MITARBEITER_trigger
BEFORE INSERT OR UPDATE OR DELETE ON MITARBEITER
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'MITARBEITER');
END;

--Bachl
CREATE OR replace TRIGGER log_ORT_trigger
BEFORE INSERT OR UPDATE OR DELETE ON ORT
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'ORT');
END;

--Bachl
CREATE OR replace TRIGGER log_STAAT_trigger
BEFORE INSERT OR UPDATE OR DELETE ON STAAT
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'STAAT');
END;

--Bachl
CREATE OR replace TRIGGER log_TIER_trigger
BEFORE INSERT OR UPDATE OR DELETE ON TIER
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'TIER');
END;

--Bachl
CREATE OR replace TRIGGER log_TIER_IST_IN_FILIALE_trigger
BEFORE INSERT OR UPDATE OR DELETE ON TIER_IST_IN_FILIALE
DECLARE
    v_user VARCHAR2(30);
BEGIN
    SELECT USER INTO v_user FROM dual;

    logging_package.log_action(v_user, 'TIER_IST_IN_FILIALE');
END;





--Tests
CREATE OR REPLACE PACKAGE Test_Package AS
    -- Tests für Mitarbeiter_Package
    PROCEDURE Test_ErhoeheGehalt;
    PROCEDURE Test_Durchschnittsgehalt;
    PROCEDURE Test_MitarbeiterDieAuchKundenSind;
    PROCEDURE Test_EntlasseMitarbeiterAusFiliale;

    -- Tests für Filiale_Package
    PROCEDURE Test_GetFilialenMitTier;
    PROCEDURE Test_GetMitarbeiterInFilialeWennGehaltGroesserAls;
    PROCEDURE Test_getFilialenMitFutter;
    PROCEDURE Test_fililialeWirdGeschlossen;

    -- Tests für Kunden_Package
    PROCEDURE Test_AddGratisBestellungZuKundenInGermany;
    PROCEDURE Test_AddVorwahlToTelefonnummer;

    -- Tests für Futter_Package
    PROCEDURE Test_ErhoeheFutterPreis;
    PROCEDURE Test_CalculateAverageFutterPrice;

    -- Tests für Trigger
    PROCEDURE Test_Trigger_No_Gmx;


    -- Tests für Logging
    PROCEDURE Test_Logging_LogAction;
    PROCEDURE Test_Logging_InsertMitarbeiter;
END Test_Package;
/

CREATE OR REPLACE PACKAGE BODY Test_Package AS

    -- Tests für Mitarbeiter_Package

    PROCEDURE Test_ErhoeheGehalt IS
        gehalt NUMBER := 50000; 
        erhoehung NUMBER := 5000; 
    BEGIN
        Mitarbeiter_Package.ErhoeheGehalt(gehalt, erhoehung);
    END;

    PROCEDURE Test_Durchschnittsgehalt IS
        avg_gehalt NUMBER;
    BEGIN
        avg_gehalt := Mitarbeiter_Package.Durchschnittsgehalt;
        DBMS_OUTPUT.PUT_LINE('Durchschnittsgehalt: ' || avg_gehalt);
    END;

    PROCEDURE Test_MitarbeiterDieAuchKundenSind IS
    BEGIN
        Mitarbeiter_Package.MitarbeiterDieAuchKundenSind;
    END;

    PROCEDURE Test_EntlasseMitarbeiterAusFiliale IS
        f_id NUMBER := 2;
    BEGIN
        Mitarbeiter_Package.EntlasseMitarbeiterAusFiliale(f_id);
    END;

    -- Tests für Filiale_Package

    PROCEDURE Test_GetFilialenMitTier IS
        v_Tier_Name VARCHAR2(40) := 'Cat'; 
    BEGIN
        Filiale_Package.GetFilialenMitTier(v_Tier_Name);
    END;

    PROCEDURE Test_GetMitarbeiterInFilialeWennGehaltGroesserAls IS
        v_Filiale_Id NUMBER := 1; 
        v_mindest_Gehalt NUMBER := 50000;
    BEGIN
        Filiale_Package.GetMitarbeiterInFilialeWennGehaltGroesserAls(v_Filiale_Id, v_mindest_Gehalt);
    END;

    PROCEDURE Test_getFilialenMitFutter IS
    BEGIN
        Filiale_Package.getFilialenMitFutter('Fish Flakes');
    END;

    PROCEDURE Test_fililialeWirdGeschlossen IS
    BEGIN
        Filiale_Package.fililialeWirdGeschlossen(1, 2);
    END;

    -- Tests für Kunden_Package

    PROCEDURE Test_AddGratisBestellungZuKundenInGermany IS
    BEGIN
        Kunden_Package.AddGratisBestellungZuKundenInGermany;
    END;

    PROCEDURE Test_AddVorwahlToTelefonnummer IS
    BEGIN
        Kunden_Package.AddVorwahlToTelefonnummer('+43', 1);
    END;

    -- Tests für Futter_Package

    PROCEDURE Test_ErhoeheFutterPreis IS
    BEGIN
        Futter_Package.ErhoeheFutterPreis;
    END;

    PROCEDURE Test_CalculateAverageFutterPrice IS
    BEGIN
        Futter_Package.CalculateAverageFutterPrice;
    END;

    -- Tests für Trigger

    PROCEDURE Test_Trigger_No_Gmx IS
    BEGIN
        INSERT INTO Kunde 
        (Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort)
        VALUES 
        ('Max', 'Mustermann', '0123456789', 'test@gmx.com', 'Musterstraße 1', 1, 10115, 'Berlin');
    END;
 

    -- Tests für Logging

    PROCEDURE Test_Logging_LogAction IS
        v_culprit VARCHAR2(30) := 'Max-Mustermann';
        v_changed_table VARCHAR2(30) := 'MusterTable';
    BEGIN
        logging_package.log_action(v_culprit, v_changed_table);
    END;

    PROCEDURE Test_Logging_InsertMitarbeiter IS
    BEGIN
        INSERT INTO Mitarbeiter (Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES ('Herman', 'Ruin', 50000, 10);
    END;

END Test_Package;
/




--Testpaket Testen
BEGIN
    --Test_Package.Test_ErhoeheGehalt;
    --Test_Package.Test_Durchschnittsgehalt;
    --Test_Package.Test_MitarbeiterDieAuchKundenSind;
    --Test_Package.Test_EntlasseMitarbeiterAusFiliale;

    --Test_Package.Test_GetFilialenMitTier;
    --Test_Package.Test_GetMitarbeiterInFilialeWennGehaltGroesserAls;
    --Test_Package.Test_getFilialenMitFutter;
    --Test_Package.Test_fililialeWirdGeschlossen;

    --Test_Package.Test_AddGratisBestellungZuKundenInGermany;
    --Test_Package.Test_AddVorwahlToTelefonnummer;

    --Test_Package.Test_ErhoeheFutterPreis;
    --Test_Package.Test_CalculateAverageFutterPrice;

    --Test_Package.Test_Trigger_InsertKunde;

    --Test_Package.Test_Logging_LogAction;
    --Test_Package.Test_Logging_InsertMitarbeiter;
END;
/