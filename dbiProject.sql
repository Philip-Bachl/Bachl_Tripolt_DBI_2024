--
CREATE OR REPLACE PACKAGE Mitarbeiter_Package AS
  PROCEDURE ErhoeheGehalt(gehaltsgrenze NUMBER, erhoehung NUMBER);
  FUNCTION Durchschnittsgehalt RETURN NUMBER;
END Mitarbeiter_Package;
/

CREATE OR REPLACE PACKAGE BODY Mitarbeiter_Package AS
  FUNCTION BerechneNeuesGehalt(altesGehalt NUMBER, erhoehung NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN altesGehalt + erhoehung;
  END;

  PROCEDURE ErhoeheGehalt(gehaltsgrenze NUMBER, erhoehung NUMBER) IS
 	  e_no_raise EXCEPTION;
	BEGIN
    UPDATE Mitarbeiter
    SET Gehalt = BerechneNeuesGehalt(Gehalt, erhoehung)
    WHERE Gehalt < gehaltsgrenze;
	   	IF SQL%NOTFOUND THEN
			RAISE e_no_raise; 
		END IF;
	
	EXCEPTION
	WHEN e_no_raise THEN
		dbms_output.Put_line('Nobody got a raise');
	END;
	
  FUNCTION Durchschnittsgehalt RETURN NUMBER IS v_durchschnitt NUMBER;
    BEGIN
      SELECT AVG(Gehalt) INTO v_durchschnitt FROM Mitarbeiter;
          return v_durchschnitt;
    END;

END Mitarbeiter_Package;
/
--Test
DECLARE
    gehalt number := 50000; 
    erhoehung number := 5000; 
BEGIN
  Mitarbeiter_Package.ErhoeheGehalt(gehalt, erhoehung);
  Mitarbeiter_Package.Durchschnittsgehalt();
END;




CREATE OR REPLACE PACKAGE Filiale_Package AS
  PROCEDURE GetFilialenMitTier(p_Tier_Name VARCHAR2);
  Procedure GetMitarbeiterInFilialeWennGehaltGroesserAls (p_Filiale_Id IN NUMBER, p_Gehalt IN NUMBER)
 END Filiale_Package;
/

CREATE OR REPLACE PACKAGE BODY Filiale_Package AS
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


END Filiale_Package;
/

--Test GetFilialenMitTier
DECLARE
    v_Tier_Name VARCHAR2(40) := 'Cat'; 
BEGIN
    Filiale_Package.GetFilialenMitTier(v_Tier_Name);
END;




--Test GetMitarbeiterInFilialeWennGehaltGroesserAls
DECLARE
    v_Filiale_Id Number := 1; 
   	v_mindest_Gehalt Number := 50000;
BEGIN
    Filiale_Package.GetMitarbeiterInFilialeWennGehaltGroesserAls(v_Filiale_Id, v_mindest_Gehalt);
END;


CREATE OR REPLACE PROCEDURE AddGratisBestellungZuKundenInGermany IS
    v_GermanyStateId NUMBER;
    v_FutterName VARCHAR2(40);
    v_BestellungId NUMBER;
BEGIN
    SELECT Id INTO v_GermanyStateId FROM Staat WHERE Name = 'Germany';
    BEGIN
        SELECT Name INTO v_FutterName FROM Futter WHERE Name = 'Dog Food';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Futter "Dog Food" does not exist.');
            RETURN;
    END;


    FOR r IN (SELECT Id FROM Kunde WHERE Staat_Id = v_GermanyStateId) LOOP
        INSERT INTO Bestellung (Kunde_Id, Filiale_Id) VALUES (r.Id, 1);
        INSERT INTO Bestellung_hat_Futter (Bestellung_Id, Futter_Name) VALUES (14,v_FutterName);/*14 ersetzen mit der id der bestellung in der Zeile darüber*/
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Gratis-Bestellungen wurden hinzugefügt.');
END;

--Test
BEGIN
    AddGratisBestellungZuKundenInGermany;
END;

