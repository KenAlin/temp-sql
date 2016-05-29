-- ::::::::::::::::::::::::::::::::::::::::
CREATE OR REPLACE TRIGGER limiteInscription
BEFORE INSERT ON Coureur
FOR EACH ROW
DECLARE
	nbCoureurs NUMBER(3);
	ERR_TROP_COUREURS EXCEPTION;
BEGIN
	SELECT COUNT(*) INTO nbCoureurs FROM Coureur WHERE Ville = :new.Ville;
	IF nbCoureurs >= 5 THEN
		INSERT INTO Coureur_Reserve VALUES (:new.Idc, :new.Idc, :new.age, :new.Ville, sysdate);
		RAISE ERR_TROP_COUREURS;
	END IF;
EXCEPTION
    WHEN ERR_TROP_COUREURS THEN
        BEGIN
            RAISE_APPLICATION_ERROR(-20001,'Coureur placé en réserve (déjà 5 coureurs dans sa ville).');
        END;
END;
/

SELECT * FROM coureur;
SELECT * FROM coureur_reserve;

DELETE FROM coureur WHERE IdC > 4;
DELETE FROM Coureur_Reserve;

INSERT INTO coureur(IdC, NomC, Age, Ville) VALUES (1, 'Test01', 20, 'Montpellier');
INSERT INTO coureur(IdC, NomC, Age, Ville) VALUES (2, 'Test02', 20, 'Montpellier');
INSERT INTO coureur(IdC, NomC, Age, Ville) VALUES (3, 'Test03', 20, 'Montpellier');
INSERT INTO coureur(IdC, NomC, Age, Ville) VALUES (4, 'Test04', 20, 'Montpellier');
INSERT INTO coureur(IdC, NomC, Age, Ville) VALUES (5, 'Test05', 20, 'Montpellier');
INSERT INTO coureur(IdC, NomC, Age, Ville) VALUES (6, 'Test06', 20, 'Montpellier');


DROP TRIGGER MISE_EN_RESERVE;