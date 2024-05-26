
CREATE OR REPLACE PACKAGE Mitarbeiter_Package AS
  PROCEDURE ErhoeheGehalt(gehaltsgrenze NUMBER, erhoehung NUMBER);
  FUNCTION Durchschnittsgehalt RETURN NUMBER;
  FUNCTION BerechneNeuesGehalt(altesGehalt NUMBER, erhoehung NUMBER) RETURN NUMBER;
END Mitarbeiter_Package;
/

CREATE OR REPLACE PACKAGE BODY Mitarbeiter_Package AS

  FUNCTION BerechneNeuesGehalt(altesGehalt NUMBER, erhoehung NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN altesGehalt + erhoehung;
  END;

  PROCEDURE ErhoeheGehalt(gehaltsgrenze NUMBER, erhoehung NUMBER) IS
	BEGIN
    UPDATE Mitarbeiter
    SET Gehalt = BerechneNeuesGehalt(Gehalt, erhoehung)
    WHERE Gehalt < gehaltsgrenze;
	END;
	
  FUNCTION Durchschnittsgehalt RETURN NUMBER IS v_durchschnitt NUMBER;
    BEGIN
      SELECT AVG(Gehalt) INTO v_durchschnitt FROM Mitarbeiter;
          return v_durchschnitt;
    END Durchschnittsgehalt;

END Mitarbeiter_Package;
/

DECLARE
    gehalt number := 50000; 
    erhoehung number := 5000; 
BEGIN
  Mitarbeiter_Package.ErhoeheGehalt(gehalt, erhoehung);
  Mitarbeiter_Package.Durchschnittsgehalt();
END;




CREATE OR REPLACE PROCEDURE getFilialenMitTier (p_Tier_Name IN VARCHAR2)
IS
BEGIN
    FOR fil IN (
        SELECT f.Id, f.Name
        FROM Filiale f
        JOIN Tier_ist_in_Filiale tf ON f.Id = tf.Filiale_Id
        WHERE tf.Tier_Name = p_Tier_Name) 
    LOOP
        DBMS_OUTPUT.PUT_LINE('Filiale ID: ' || fil.Id);
        DBMS_OUTPUT.PUT_LINE('Filiale Name: ' || fil.Name);
    END LOOP;
END;




DECLARE
    v_Tier_Name VARCHAR2(40) := 'Cat'; 
BEGIN
    getFilialenMitTier(v_Tier_Name);
END;















--No package works
CREATE OR REPLACE PACKAGE testpkg AS
  FUNCTION testFunction(radius NUMBER) RETURN NUMBER;
END testpkg;


CREATE OR REPLACE PACKAGE BODY testpkg AS

  FUNCTION testFunction(radius NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN radius * 2;
  END testFunction;

END testpkg;


BEGIN 
  DBMS_OUTPUT.PUT_LINE(testpkg.testFunction(20));
END;
DROP PACKAGE testpkg;

--THis works 
CREATE OR REPLACE PROCEDURE ErhoeheGehaltUnterGrenze(erhoehung NUMBER, grenze NUMBER) IS
BEGIN
  UPDATE Mitarbeiter
  SET Gehalt = Gehalt + erhoehung
  WHERE Gehalt < grenze;
END ErhoeheGehaltUnterGrenze;


BEGIN
  ErhoeheGehaltUnterGrenze(500, 53000);
END;