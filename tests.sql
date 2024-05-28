--Test Mitarbeiter_Package
DECLARE
    gehalt number := 50000; 
    erhoehung number := 5000; 
BEGIN
    Mitarbeiter_Package.ErhoeheGehalt(gehalt, erhoehung);
    Mitarbeiter_Package.Durchschnittsgehalt();
END;
----
DECLARE
    f_id NUMBER := 2;
BEGIN
    Mitarbeiter_Package.EntlasseMitarbeiterAusFiliale(f_id);
END;
----
BEGIN
    Mitarbeiter_Package.MitarbeiterDieAuchKundenSind();
END;


--Test Filiale_Package
DECLARE
    v_Tier_Name VARCHAR2(40) := 'Cat'; 
BEGIN
    Filiale_Package.GetFilialenMitTier(v_Tier_Name);
END;
----
DECLARE
    v_Filiale_Id Number := 1; 
   	v_mindest_Gehalt Number := 50000;
BEGIN
    Filiale_Package.GetMitarbeiterInFilialeWennGehaltGroesserAls(v_Filiale_Id, v_mindest_Gehalt);
END;
----
BEGIN
    Filiale_Package.getFilialenMitFutter('Fish Flakes');
END;
----
BEGIN
    Filiale_Package.ChangeFilialeForBestellungen(1,2);
END;


--Test Kunden_Package
BEGIN
    Kunden_Package.AddGratisBestellungZuKundenInGermany;
END;
----
BEGIN
    Kunden_Package.AddVorwahlToTelefonnummer('+43', 1);
END;


--Test Futter_Package
BEGIN
    Futter_Package.ErhoeheFutterPreis;
END;
----
BEGIN
    Futter_Package.CalculateAverageFutterPrice;
END;


--Test Trigger
BEGIN
    INSERT INTO Kunde 
    (Vorname, Nachname, Telefonnummer, Email, StraßeUndHausnummer, Staat_Id, Ort_PLZ, Ort_Ort)
    VALUES 
    ('Max', 'Mustermann', '0123456789', 'test@gmx.com', 'Musterstraße 1', 1, 10115, 'Berlin');
END;

----

--Test Logging
DECLARE
    v_culprit VARCHAR2(30) := 'Max-Mustermann';
    v_changed_table VARCHAR2(30) := 'MusterTable';
BEGIN
    logging_package.log_action(v_culprit, v_changed_table);
END;
BEGIN
    INSERT INTO Mitarbeiter (Vorname, Nachname, Gehalt, Arbeitet_in_Filiale_Id) VALUES ('Herman', 'Ruin', 50000, 10);
END;