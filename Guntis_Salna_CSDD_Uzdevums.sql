--------------------------------------------------------------------------------
/*
    Vehicle Colors (2.1 Kr�su uztur��ana)
*/
DROP TABLE vehicle_colors;
CREATE TABLE vehicle_colors (
    code VARCHAR2(5) NOT NULL,
    name VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_name PRIMARY KEY (name));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_color (
    p_code IN VARCHAR2,
    p_name IN VARCHAR2)
AS
BEGIN
    INSERT INTO vehicle_colors VALUES (p_code, p_name);
    dbms_output.put_line('Kr�sa '||p_name||' ar kodu '||p_code||' veiksm�gi pievienota datub�zei!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('K��da! Kr�su kodam j�sast�v no 5 simboliem un/vai kr�sas nosaukums nevar b�t liel�ks par 100 simboliem!');
END;
/
--P�rbaude:
BEGIN
    insert_color('64768', 'Pel�ks');
END;
---------------------------------[ Update ]-------------------------------------
CREATE OR REPLACE PROCEDURE update_color (
    p_code IN VARCHAR2,
    p_name IN VARCHAR2,
    p_new_code IN VARCHAR2)
AS
BEGIN
    UPDATE vehicle_colors SET code = p_new_code, name = p_name WHERE code = p_code;
    dbms_output.put_line('Kr�sa '||p_name||' ar kodu '||p_code||' veiksm�gi atjaunota!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('K��da! Kr�sa datub�z� nav atrodama!');
END;
/
--P�rbaude:
BEGIN
    update_color('60A91', 'Melns', '90A91');
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_color (
    p_code IN VARCHAR2)
AS
BEGIN
    DELETE FROM vehicle_colors WHERE code = p_code;
    dbms_output.put_line('Kr�sa ar kodu '||p_code||' veiksm�gi izdz�sta!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('K��da! Kr�sa datub�z� nav atrodama!');
END;
/
--P�rbaude:
BEGIN
    delete_color('90A91');
END;
---------------------------------[ Select ]-------------------------------------
--Vienk�r�s select's par visiem datiem tabul�
SELECT
    code AS "Kods",
    name AS "Kr�sa"
FROM vehicle_colors;
--------------------------------------------------------------------------------
/*
    Vehicle Makes and Model (2.2 Marku un mode�u uztur��ana)
*/
DROP TABLE vehicles;
CREATE TABLE vehicles (
    makes VARCHAR2(20) NOT NULL,
    model VARCHAR2(20) NOT NULL,
    CONSTRAINT check_make CHECK (makes = upper(makes)),
    CONSTRAINT check_model CHECK (model = upper(model)),
    CONSTRAINT vehicle_pk PRIMARY KEY (model),
    CONSTRAINT uk_make UNIQUE (makes, model));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_vehicles (
    p_makes IN VARCHAR2,
    p_model IN VARCHAR2)
AS
BEGIN
    
    INSERT INTO vehicles VALUES (p_makes, p_model);
    dbms_output.put_line('Marka: '||p_makes||' (modelis: '||p_model||') veiksm�gi pievienots datub�zei!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('K��da! Markas un/vai mode�a nosaukums nevar b�t liel�ks par 20 simboliem!');
        dbms_output.put_line('K��da! Markas un/vai mode�a nosaukums var b�t tikai ar lielajiem burtiem!');
END;
/
--P�rbaude:
BEGIN
    insert_vehicles('AUDI', 'A4');
    insert_vehicles('AUDI', 'A5');
    insert_vehicles('BMW', '330');
    insert_vehicles('BMW', '530');
    insert_vehicles('OPEL', 'VECTRA');
    insert_vehicles('OPEL', 'ZAFIRA');
    insert_vehicles('FORD', 'ESCORT');
    insert_vehicles('FORD', 'FIESTA');
END;
---------------------------------[ Update ]-------------------------------------
CREATE OR REPLACE PROCEDURE update_vehicles (
    p_makes IN VARCHAR2,
    p_model IN VARCHAR2,
    p_new_model IN VARCHAR2)
AS
BEGIN
    UPDATE vehicles SET makes = p_makes, model = p_new_model WHERE model = p_model;
    dbms_output.put_line('Markas '||p_makes||' modelis '||p_new_model||' veiksm�gi atjaunots!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('K��da! Modelis datub�z� nav atrodams!');
END;
/
--P�rbaude:
BEGIN
    update_vehicles('AUDI', 'A4', 'A8');
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_vehicles (
    p_model IN VARCHAR2)
AS
BEGIN
    DELETE FROM vehicles WHERE model = p_model;
    dbms_output.put_line('Kr�sa ar kodu '||p_model||' veiksm�gi izdz�sta!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('K��da! Modelis datub�z� nav atrodams!');
END;
/
--P�rbaude:
BEGIN
    delete_vehicles('A8');
END;
---------------------------------[ Select ]-------------------------------------
--Vienk�r�s select's par visiem datiem tabul�
SELECT
    makes AS "Markas nosaukums",
    model AS "Mode�a nosaukums"
FROM vehicles;
--------------------------------------------------------------------------------
/*
    CSDD (3.1 CSDD strukt�rvien�bas)
*/
DROP TABLE csdd;
CREATE TABLE csdd (
    name VARCHAR2(50) NOT NULL,
    number_plate_no_start VARCHAR2(7),
    number_plate_no_end VARCHAR2(7),
    number_plate_status VARCHAR2(10),
    registration_certificate_start VARCHAR2(9),
    registration_certificate_end VARCHAR2(9),
    registration_certificate_status VARCHAR2(10),
    CONSTRAINT pk_csdd_name PRIMARY KEY (name));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_csdd (
    p_name IN VARCHAR2,
    p_number_plate_no_start IN VARCHAR2,
    p_number_plate_no_end IN VARCHAR2,
    p_number_plate_status IN VARCHAR2,
    p_registration_certificate_start IN VARCHAR2,
    p_registration_certificate_end IN VARCHAR2,
    p_registration_certificate_status IN VARCHAR2)
AS
BEGIN
    INSERT INTO csdd VALUES (p_name, p_number_plate_no_start, p_number_plate_no_end, p_number_plate_status,
                        p_registration_certificate_start, p_registration_certificate_end, p_registration_certificate_status);
    dbms_output.put_line('Dati veiksm�gi pievienoti datub�zei!');
END;
/
--P�rbaude:
BEGIN
    insert_csdd('Aizkraukle', 'MR0000', 'MR9999', '�ener�ts', '', '', '');
    insert_csdd('Al�ksne', 'MU001', 'MU999', '�ener�ts', 'AK0000000', 'AK9999999', '�ener�ts');
    insert_csdd('Balvi', '', '', '', 'KA0000000', 'KA9999999', '�ener�ts');
    insert_csdd('Bauska', 'GJ0000', 'GJ9999', '�ener�ts', 'GA0000000', 'GA9999999', '�ener�ts');
    insert_csdd('C�sis', 'GM0000', 'GM9999', '�ener�ts', 'ZF0000000', 'ZF9999999', '�ener�ts');
    insert_csdd('Daugavpils', 'HM0000', 'HM9999', '', 'AZ0000000', 'AZ9999999', '�ener�ts');
    insert_csdd('Dobele', 'GV0000', 'GV9999', '�ener�ts', '', '', '�ener�ts');
    insert_csdd('Gulbene', '', '', '', 'EK0000000', 'EK9999999', '�ener�ts');
    insert_csdd('J�kabpils', '', '', '', 'UV0000000', 'UV9999999', '�ener�ts');
    insert_csdd('Jelgava', '', '', '', 'ZF0000000', 'ZF9999999', '�ener�ts');
END;
---------------------------------[ Update ]-------------------------------------
CREATE OR REPLACE PROCEDURE update_csdd (
    p_name IN VARCHAR2,
    p_number_plate_no_start IN VARCHAR2,
    p_number_plate_no_end IN VARCHAR2,
    p_number_plate_status IN VARCHAR2,
    p_registration_certificate_start IN VARCHAR2,
    p_registration_certificate_end IN VARCHAR2,
    p_registration_certificate_status IN VARCHAR2,
    p_name_new IN VARCHAR2)
AS
BEGIN
    UPDATE csdd SET
        name = p_name_new,
        number_plate_no_start = p_number_plate_no_start,
        number_plate_no_end = p_number_plate_no_end,
        number_plate_status = p_number_plate_status,
        registration_certificate_start = p_registration_certificate_start,
        registration_certificate_end = p_registration_certificate_end,
        registration_certificate_status = p_registration_certificate_status
    WHERE name = p_name;
    dbms_output.put_line('CSDD strukt�rvien�ba veiksm�gi atjaunota!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('K��da! Strukt�rvien�ba datub�z� nav atrodama!');
END;
/
--P�rbaude:
BEGIN
    update_csdd('Aizkraukle', 'MR0000', 'MR9999', '�ener�ts', '', '', '', 'Atjaunotais');
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_csdd (
    p_name IN VARCHAR2)
AS
    exception_name EXCEPTION;
BEGIN
    IF p_name IS NULL THEN
        RAISE exception_name;
    ELSE
        DELETE FROM csdd WHERE name = p_name;
        dbms_output.put_line('CSDD strukt�ra '||p_name||' veiksm�gi izdz�sta!');
    END IF;
EXCEPTION
    WHEN exception_name THEN
        dbms_output.put_line('K��da! Strukt�rvien�ba datub�z� nav atrodams!');
END;
/
--P�rbaude:
BEGIN
    delete_csdd('');
END;
---------------------------------[ Select ]-------------------------------------
--Vienk�r�s select's par visiem datiem tabul�
SELECT
    name AS "Nosaukums",
    number_plate_no_start AS "Ma��nu numuri no",
    number_plate_no_end AS "Ma��nu numuri l�dz",
    number_plate_status AS "No�ener�ti numuri",
    registration_certificate_start AS "Re�istr�cijas apliec�ba no",
    registration_certificate_end AS "Re�istr�cijas apliec�ba l�dz",
    registration_certificate_status AS "No�ener�tas apliec�bas"
FROM csdd;
--------------------------------------------------------------------------------
/*
    Vehicle Number Plates (4.1 Ma��nu numuru uztur��ana)
*/
DROP TABLE vehicle_number_plates;
CREATE TABLE vehicle_number_plates (
    plate_no VARCHAR2(8),
    plate_status VARCHAR2(9),
    plate_special VARCHAR2(3),
    CONSTRAINT pk_plate_no PRIMARY KEY (plate_no),
    CONSTRAINT chk_plate_status CHECK (plate_status IN ('Br�vs', 'Aiz�emts', 'Neakt�vs')),
    CONSTRAINT chk_plate_special CHECK (plate_special IN ('J�', NULL)));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_vehicle_number_plates (
    p_plate_no IN VARCHAR2,
    p_plate_status IN VARCHAR2,
    p_plate_special IN VARCHAR2)
AS
BEGIN
    IF ((p_plate_special IS NULL) OR (p_plate_special = 'J�')) THEN
        INSERT INTO vehicle_number_plates VALUES (p_plate_no, p_plate_status, p_plate_special);
        dbms_output.put_line('Transportl�dzek�a numurs veiksm�gi pievienots datub�zei!');
    ELSE
        dbms_output.put_line('K��da! Paz�me var b�t "J�" vai tuk�a');
    END IF;
END;
/
--P�rbaude:
BEGIN
    insert_vehicle_number_plates('MR8386', 'Aiz�emts', NULL);
    insert_vehicle_number_plates('MU778', 'Aiz�emts', 'J�');
    insert_vehicle_number_plates('GJ5739', 'Aiz�emts', NULL);
    insert_vehicle_number_plates('GM4524', 'Aiz�emts', NULL);
    insert_vehicle_number_plates('GV2766', 'Aiz�emts', NULL);
    insert_vehicle_number_plates('HM6659', 'Aiz�emts', NULL);
    insert_vehicle_number_plates('AB1234', 'Br�vs', '');
    insert_vehicle_number_plates('GOOD', 'Neakt�vs', 'J�');
    insert_vehicle_number_plates('DE3507', 'Neakt�vs', '');
END;
---------------------------------[ Update ]-------------------------------------
CREATE OR REPLACE PROCEDURE update_vehicle_number_plates (
    p_plate_no IN VARCHAR2,
    p_plate_status IN VARCHAR2,
    p_plate_special IN VARCHAR2,
    p_plate_no_new IN VARCHAR2)
AS
BEGIN
    UPDATE
        vehicle_number_plates 
    SET 
        plate_no = p_plate_no_new,
        plate_status = p_plate_status,
        plate_special = p_plate_special
    WHERE 
        plate_no = plate_no;
    dbms_output.put_line('Numurz�me veiksm�gi atjaunota!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('K��da! Numurz�m� datub�z� nav atrodama!');
END;
/
--P�rbaude:
BEGIN
    update_vehicle_number_plates('MR8386', 'Aiz�emts', NULL, 'ES678');
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_vehicle_number_plates (
    p_plate_no IN VARCHAR2)
AS
    exception_plate EXCEPTION;
    exception_plate_v2 EXCEPTION;
BEGIN
    IF p_plate_no IS NULL THEN
        RAISE exception_plate;
    ELSIF SQL%NOTFOUND THEN
        RAISE exception_plate_v2;
    ELSE
        DELETE FROM vehicle_number_plates WHERE plate_no = p_plate_no;
        dbms_output.put_line('Numurz�me '||p_plate_no||' veiksm�gi izdz�sta!');
    END IF;
EXCEPTION
    WHEN exception_plate THEN
        dbms_output.put_line('K��da! Tuk�a Numurz�me datub�z� nav atrodama!');
    WHEN exception_plate_v2 THEN
        dbms_output.put_line('K��da! Numurz�me datub�z� nav atrodama!');
END;
/
--P�rbaude:
BEGIN
    delete_vehicle_number_plates('MR8386');
END;
---------------------------------[ Select ]-------------------------------------
--Vienk�r�s select's par visiem datiem tabul�

SELECT
    plate_no AS "Numurs",
    plate_status AS "Statuss",
    plate_special AS "Ir speci�ls"
FROM vehicle_number_plates;
--------------------------------------------------------------------------------
/*
    - (4.2 Re�istr�cijas apliec�bu uztur��ana)
*/
--------------------------------------------------------------------------------
--Kad ir sesija, nomaina sist�mas datuma form�tu no YYYY.MM.DD -> DD.MM.YYYY,
--attiec�gi, kad tiks restart�ta sist�ma, atgriez�sies atpaka� pie "vec�" form�ta
SELECT * FROM nls_session_parameters WHERE parameter = 'NLS_DATE_FORMAT';
ALTER SESSION SET nls_date_format = 'DD.MM.YYYY';
------------------------------[ CREATE TABLE ]----------------------------------
DROP TABLE certification;
CREATE TABLE certification (
    certificate_no VARCHAR2(10),
    certificate_status VARCHAR2(9),
    certificate_start_date DATE,
    certificate_end_date DATE,
    CONSTRAINT pk_certificate_no PRIMARY KEY (certificate_no),
    CONSTRAINT chk_certificate_status CHECK (certificate_status IN ('Br�vs', 'Aiz�emts', 'Neakt�vs')));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_certification (
    p_certificate_no IN VARCHAR2,
    p_certificate_status IN VARCHAR2,
    p_certificate_start_date IN VARCHAR2,
    p_certificate_end_date IN VARCHAR2)
AS
BEGIN
    IF p_certificate_end_date < p_certificate_start_date THEN
        dbms_output.put_line('K��da! Der�guma termi�am j�b�t liel�kam par izdo�anas datumu!');
    ELSE
        INSERT INTO certification VALUES (p_certificate_no, p_certificate_status, p_certificate_start_date, p_certificate_end_date);
        dbms_output.put_line('Re�istr�cijas apliec�ba veiksm�gi pievienota datub�zei!');
    END IF;
END;
/
--P�rbaude:
BEGIN
    insert_certification('AK1720640', 'Aiz�emts', TO_DATE('01.02.2017', 'DD.MM.YYYY'), TO_DATE('01.02.2027', 'DD.MM.YYYY'));
    insert_certification('KA7483645', 'Aiz�emts', TO_DATE('09.11.2020', 'DD.MM.YYYY'), TO_DATE('09.11.2030', 'DD.MM.YYYY'));
    insert_certification('GA2543432', 'Aiz�emts', TO_DATE('25.05.2014', 'DD.MM.YYYY'), TO_DATE('25.05.2024', 'DD.MM.YYYY'));
    insert_certification('ZF0912224', 'Aiz�emts', TO_DATE('17.06.2012', 'DD.MM.YYYY'), TO_DATE('17.06.2022', 'DD.MM.YYYY'));
    insert_certification('AZ7365322', 'Aiz�emts', TO_DATE('30.12.2016', 'DD.MM.YYYY'), TO_DATE('30.12.2026', 'DD.MM.YYYY'));
    insert_certification('EK1242156', 'Br�vs', NULL, NULL);
    insert_certification('UV6786214', 'Neakt�vs', TO_DATE('22.07.2002', 'DD.MM.YYYY'), TO_DATE('22.07.2012', 'DD.MM.YYYY'));
    insert_certification('ZF5782416', 'Neakt�vs', TO_DATE('05.01.2001', 'DD.MM.YYYY'), TO_DATE('05.01.2011', 'DD.MM.YYYY'));
END;
---------------------------------[ Update ]-------------------------------------
CREATE OR REPLACE PROCEDURE update_certification (
    p_certificate_no IN VARCHAR2,
    p_certificate_status IN VARCHAR2,
    p_certificate_start_date IN VARCHAR2,
    p_certificate_end_date IN VARCHAR2)
AS
BEGIN
    UPDATE
        certification 
    SET 
        certificate_no = p_certificate_no,
        certificate_status = p_certificate_status,
        certificate_start_date = p_certificate_start_date,
        certificate_end_date = p_certificate_end_date
    WHERE 
        certificate_no = p_certificate_no;
    dbms_output.put_line('Re�istr�cijas apliec�ba veiksm�gi atjaunota!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('K��da! Re�istr�cijas apliec�ba ar Nr.'||p_certificate_no||' datub�z� nav atrodama!');
END;
/
--P�rbaude:
BEGIN
    update_certification('AK1720640', 'Br�vs', TO_DATE('01.02.2017', 'DD.MM.YYYY'), TO_DATE('01.02.2027', 'DD.MM.YYYY'));
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_certification (
    p_certificate_no IN VARCHAR2)
AS
    exception_certification EXCEPTION;
    exception_certification_v2 EXCEPTION;
BEGIN
    IF p_certificate_no IS NULL THEN
        RAISE exception_certification;
    ELSIF SQL%NOTFOUND THEN
        RAISE exception_certification_v2;
    ELSE
        DELETE FROM certification WHERE certificate_no = p_certificate_no;
        dbms_output.put_line('Re�istr�cijas apliec�ba ar Nr. '||p_certificate_no||' veiksm�gi izdz�sta!');
    END IF;
EXCEPTION
    WHEN exception_certification THEN
        dbms_output.put_line('K��da! Tuk�a re�istr�cijas apliec�ba datub�z� nav atrodama!');
    WHEN exception_certification_v2 THEN
        dbms_output.put_line('K��da! Re�istr�cijas apliec�ba datub�z� nav atrodama!');
END;
/
--P�rbaude:
BEGIN
    delete_certification('AK1720640');
END;
---------------------------------[ Select ]-------------------------------------
--Vienk�r�s select's par visiem datiem tabul�
SELECT
    certificate_no AS "Apliec�ba",
    certificate_status AS "Statuss",
    certificate_start_date AS "Izdo�anas datums",
    certificate_end_date AS "Der�guma termi��"
FROM certification;
--------------------------------------------------------------------------------
/*
    - (5.1 Ma��nu re�istr�cija)
*/
DROP TABLE vehicle_registration;
CREATE TABLE vehicle_registration (
    vin VARCHAR2(17) NOT NULL,
    release_year NUMBER(4) NOT NULL,
    gross_weight NUMBER(6) NOT NULL,
    unladen_weight NUMBER(6) NOT NULL,
    model VARCHAR2(20) NOT NULL,
    color_name VARCHAR2(50) NOT NULL,
    csdd_location VARCHAR2(50) NOT NULL,
    certificate_no VARCHAR2(9) NOT NULL,
    plate_no VARCHAR2(7) NOT NULL,
    owner VARCHAR2(100) NOT NULL,
    notes VARCHAR2(500) NOT NULL,
    CONSTRAINT pk_vin PRIMARY KEY (vin),
    CONSTRAINT fk_model FOREIGN KEY (model) REFERENCES vehicles (model),
    CONSTRAINT fk_color_name FOREIGN KEY (color_name) REFERENCES vehicle_colors (name),
    CONSTRAINT fk_csdd FOREIGN KEY (csdd_location) REFERENCES csdd (name),
    CONSTRAINT fk_certificate_no FOREIGN KEY (certificate_no) REFERENCES certification (certificate_no),
    CONSTRAINT fk_plate_no FOREIGN KEY (plate_no) REFERENCES vehicle_number_plates (plate_no),
    CONSTRAINT fk_owner FOREIGN KEY (owner) REFERENCES ownership (personal_no));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_vehicle_registration (
    p_vin IN VARCHAR2,
    p_release_year IN NUMBER,
    p_gross_weight IN NUMBER,
    p_unladen_weight IN NUMBER,
    p_model IN VARCHAR2,
    p_color_name IN VARCHAR2,
    p_csdd_location IN VARCHAR2,
    p_certificate_no IN VARCHAR2,
    p_plate_no IN VARCHAR2,
    p_owner IN VARCHAR2,
    p_notes IN VARCHAR2)
AS
BEGIN
    INSERT INTO vehicle_registration
        VALUES (
            p_vin,
            p_release_year,
            p_gross_weight,
            p_unladen_weight,
            p_model,
            p_color_name,
            p_csdd_location,
            p_certificate_no,
            p_plate_no,
            p_owner,
            p_notes);
END;
/
--P�rbaude:
BEGIN
insert_vehicle_registration(
    'WAUZZZ8E54A008867', 2003, 2000, 1525, 'A4', 'Pel�ks', 'Al�ksne', 'AK1720640', 'MU778' , '120156-12345', 'Piez�me #1');
insert_vehicle_registration(
    'WAUZZZ8T7AA055568', 2010, 2250, 1795, 'A5', 'Oran�s', 'Aizkraukle', 'KA7483645', 'MR8386' , '231267-08076', 'Piez�me #2');
insert_vehicle_registration(
    'WBAAL71020KE22911',  1999, 1875, 1350, '330', 'Sarkans', 'J�kabpils', 'UV6786214', 'GJ5739' , '270315-12120', 'Piez�me #3');
insert_vehicle_registration(
    'WBADL81030GJ68189',  1999, 2125, 1585, '530', 'Sarkans', 'C�sis', 'ZF0912224', 'GM4524' , '111111-33420', 'Piez�me #4');
insert_vehicle_registration(
    'W0L000036T5123362',  1996, 1805, 1275, 'VECTRA', 'Pel�ks', 'Dobele', 'GA2543432', 'GV2766' , '180492-00091', 'Piez�me #5');
insert_vehicle_registration(
    'WUG1GFUGU78674474',  2000, 2065, 1505, 'ZAFIRA', 'Za��', 'Daugavpils', 'AZ7365322', 'HM6659' , '090697-23352', 'Piez�me #6');
insert_vehicle_registration(
    'W7687SFA812451250',  2007, 1625, 1105, 'ESCORT', 'Violets', 'Gulbene', 'EK1242156', 'GOOD' , '270315-12120', 'Piez�me #7');
insert_vehicle_registration(
    'HSFA78730252S0001',  1999, 1160, 730, 'FIESTA', 'Za��', 'Jelgava', 'ZF5782416', 'DE3507' , '090478-10092', 'Piez�me #8');
END;
---------------------------------[ Update ]-------------------------------------
CREATE OR REPLACE PROCEDURE update_vehicle_registration (
    p_vin IN VARCHAR2,
    p_release_year IN NUMBER,
    p_gross_weight IN NUMBER,
    p_unladen_weight IN NUMBER,
    p_model IN VARCHAR2,
    p_color_name IN VARCHAR2,
    p_csdd_location IN VARCHAR2,
    p_certificate_no IN VARCHAR2,
    p_plate_no IN VARCHAR2,
    p_owner IN VARCHAR2,
    p_notes IN VARCHAR2,
    p_vin_new IN VARCHAR2)
AS
BEGIN
    UPDATE
        vehicle_registration 
    SET 
        vin = p_vin_new,
        release_year = p_release_year,
        gross_weight = p_gross_weight,
        unladen_weight = p_unladen_weight,
        model = p_model,
        color_name = p_color_name,
        csdd_location = p_csdd_location,
        certificate_no = p_certificate_no,
        plate_no = p_plate_no,
        owner = p_owner,
        notes = p_notes
    WHERE 
        vin = p_vin;
    dbms_output.put_line('Transportl�dzek�a re�istr�cijas dati veiksm�gi atjaunoti!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('K��da! Transportl�dzek�a �asijas nr.'||p_vin||' datub�z� nav atrodams!');
END;
/
--P�rbaude:
BEGIN
    update_vehicle_registration('WAUZZZ8E54A008867', 2003, 2000, 1525, 'A4', 'Pel�ks', 'Al�ksne', 'AK1720640', 'MU778' , '120156-12345', 'Piez�me #10', 'WAUZZZ8E54A008867');
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_vehicle_registration (
    p_vin IN VARCHAR2)
AS
    exception_vin EXCEPTION;
    exception_vin_v2 EXCEPTION;
BEGIN
    IF p_vin IS NULL THEN
        RAISE exception_vin;
    ELSIF SQL%NOTFOUND THEN
        RAISE exception_vin_v2;
    ELSE
        DELETE FROM vehicle_registration WHERE vin = p_vin;
        dbms_output.put_line('Transportl�dzeklis ar �asijas nr. '||p_vin||' veiksm�gi izdz�sts!');
    END IF;
EXCEPTION
    WHEN exception_vin THEN
        dbms_output.put_line('K��da! Tuk�s �asijas nr. datub�z� nav atrodams!');
    WHEN exception_vin_v2 THEN
        dbms_output.put_line('K��da! �asijas nr. datub�z� nav atrodams!');
END;
/
--P�rbaude:
BEGIN
    delete_vehicle_registration('');
END;
---------------------------------[ Select ]-------------------------------------
--Vienk�r�s select's par visiem datiem tabul�
SELECT
    vin AS "�asijas numurs",
    release_year AS "Izlaiduma gads",
    gross_weight AS "Pilna masa",
    unladen_weight AS "Pa�masa",
    model AS "Modelis",
    color_name AS "Kr�sa",
    csdd_location AS "CSDD strukt�rvien�ba",
    certificate_no AS "Apliec�ba",
    plate_no AS "Numurs",
    owner AS "�pa�nieks",
    notes AS "Piez�mes"
FROM vehicle_registration;

INSERT INTO vehicle_registration VALUES (
    'WAUZZZ8E54A008867', 2003, 2000, 1525, 'A4', 'Pel�ks', 'Al�ksne', 'AK1720640', 'MU778' , '120156-12345', 'Piez�me #1');
    
INSERT INTO vehicle_registration VALUES (
    'WAUZZZ8T7AA055568', 2010, 2250, 1795, 'A5', 'Oran�s', 'Aizkraukle', 'KA7483645', 'MR8386' , '231267-08076', 'Piez�me #2');
    
INSERT INTO vehicle_registration VALUES (
    'WBAAL71020KE22911',  1999, 1875, 1350, '330', 'Sarkans', 'J�kabpils', 'UV6786214', 'GJ5739' , '270315-12120', 'Piez�me #3');
    
INSERT INTO vehicle_registration VALUES (
    'WBADL81030GJ68189',  1999, 2125, 1585, '530', 'Sarkans', 'C�sis', 'ZF0912224', 'GM4524' , '111111-33420', 'Piez�me #4');
    
INSERT INTO vehicle_registration VALUES (
    'W0L000036T5123362',  1996, 1805, 1275, 'VECTRA', 'Pel�ks', 'Dobele', 'GA2543432', 'GV2766' , '180492-00091', 'Piez�me #5');
    
INSERT INTO vehicle_registration VALUES (
    'WUG1GFUGU78674474',  2000, 2065, 1505, 'ZAFIRA', 'Za��', 'Daugavpils', 'AZ7365322', 'HM6659' , '090697-23352', 'Piez�me #6');
    
INSERT INTO vehicle_registration VALUES (
    'W7687SFA812451250',  2007, 1625, 1105, 'ESCORT', 'Violets', 'Gulbene', 'EK1242156', 'GOOD' , '270315-12120', 'Piez�me #7');
    
INSERT INTO vehicle_registration VALUES (
    'HSFA78730252S0001',  1999, 1160, 730, 'FIESTA', 'Za��', 'Jelgava', 'ZF5782416', 'DE3507' , '090478-10092', 'Piez�me #8');
--------------------------------------------------------------------------------
/*
    Ownership (5.2 �pa�nieku re�istr�cija)
*/
DROP TABLE ownership;
CREATE TABLE ownership (
    name VARCHAR2(50) NOT NULL,
    surname VARCHAR2(50) NOT NULL,
    personal_no VARCHAR2(12) NOT NULL,
    CONSTRAINT pk_personal_no PRIMARY KEY (personal_no));--,
    --CONSTRAINT chk_personal_no CHECK (regexp_like (personal_no, '(\d{6})(\d{5})', '\1-\2')));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_ownership (
    p_name IN VARCHAR2,
    p_surname IN VARCHAR2,
    p_personal_no IN VARCHAR2)
AS
BEGIN
    INSERT INTO ownership VALUES (p_name, p_surname, regexp_replace(p_personal_no, '(\d{6})(\d{5})', '\1-\2'));
    dbms_output.put_line('�pa�nieks veiksm�gi pievienots datub�zei!');
END;
/
--P�rbaude:
BEGIN
    insert_ownership('Lauris', 'Reiniks', '12015612345');
    insert_ownership('K�mi��', 'Lapsa', '23126708076');
    insert_ownership('Oto', 'Traktors', '11111133420');
    insert_ownership('J�nis', 'B�rzi��', '18049200091');
    insert_ownership('Ein�rs', 'Re�etins', '09069723352');
    insert_ownership('Daiga', 'Up�te', '27031512120');
    insert_ownership('Di�na', 'Lap�enovska', '09047810092');
    insert_ownership('Gun�rs', 'Ugunsgr�ks', '10089023219');
END;
---------------------------------[ Update ]-------------------------------------
CREATE OR REPLACE PROCEDURE update_ownership (
    p_name IN VARCHAR2,
    p_surname IN VARCHAR2,
    p_personal_no IN VARCHAR2)
AS
BEGIN
    UPDATE
        ownership 
    SET 
        name = p_name,
        surname = p_surname,
        personal_no = regexp_replace(p_personal_no, '(\d{6})(\d{5})', '\1-\2')
    WHERE 
        personal_no = p_personal_no;
    dbms_output.put_line('�pa�nieka dati veiksm�gi atjaunoti!');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('K��da! �pa�nieks datub�z� nav atrodams!');
END;
/
--P�rbaude:
BEGIN
    update_ownership('Lauris', 'Aps�tis', '12015612345');
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_ownership (
    p_personal_no IN VARCHAR2)
AS
    exception_plate EXCEPTION;
    exception_plate_v2 EXCEPTION;
BEGIN
    IF p_personal_no IS NULL THEN
        RAISE exception_plate;
    ELSIF SQL%NOTFOUND THEN
        RAISE exception_plate_v2;
    ELSE
        DELETE FROM ownership WHERE personal_no = regexp_replace(p_personal_no, '(\d{6})(\d{5})', '\1-\2');
        dbms_output.put_line('Persona ar personas kodu '||p_personal_no||' veiksm�gi izdz�sts!');
    END IF;
EXCEPTION
    WHEN exception_plate THEN
        dbms_output.put_line('K��da! Tuk�s personas kods datub�z� nav atrodams!');
    WHEN exception_plate_v2 THEN
        dbms_output.put_line('K��da! Personas kods datub�z� nav atrodama!');
END;
/
--P�rbaude:
BEGIN
    delete_ownership('09069723352');
END;
---------------------------------[ Select ]-------------------------------------
--Vienk�r�s select's par visiem datiem tabul�
SELECT
    name AS "V�rds",
    surname AS "Uzv�rds",
    personal_no AS "Personas kods"
FROM ownership;
--------------------------------------------------------------------------------
/*
    - (6.1 Re�istr�cijas apliec�ba)
*/
--Variants #1 (izdruk� visu iesp�jamo inform�ciju par vis�m apliec�bas nr.)
DROP VIEW certification_view;
CREATE VIEW certification_view AS
    SELECT 
        vnp.plate_no AS "Re�istr�cijas numurs",
        v.makes AS "Marka",
        v.model AS "Modelis",
        vr.release_year AS "Izlaiduma gads",
        vr.vin AS "�asijas Nr.",
        vr.gross_weight AS "Pilna masa /kg/",
        vr.unladen_weight AS "Pa�masa /kg/",
        c.certificate_no AS "Re�istr�cijas apliec�bas numurs",
        vr.notes AS "Piez�mes",
        o.surname AS "Uzv�rds",
        o.name AS "V�rds",
        c.certificate_start_date AS "Kad",
        cs.name AS "Kur",
        c.certificate_end_date AS "Der�ga l�dz"
    FROM
        vehicle_number_plates vnp,
        vehicles v,
        vehicle_registration vr,
        certification c,
        ownership o,
        csdd cs
    WHERE
        vnp.plate_no = vr.plate_no AND
        v.model = vr.model AND
        c.certificate_no = vr.certificate_no AND
        cs.name = vr.csdd_location AND
        o.personal_no = vr.owner
    ORDER BY notes ASC;
        
SELECT * FROM certification_view;

--Variants #2 (izdruk� konkr�tu inform�ciju par konkr�tu apliec�bas nr.)
CREATE OR REPLACE PROCEDURE view_certification (
    p_certification_no IN VARCHAR2)
AS
    l_plate_no vehicle_number_plates.plate_no%type;
    l_makes vehicles.makes%type;
    l_model vehicles.model%type;
    l_release_year vehicle_registration.release_year%type;
    l_vin vehicle_registration.vin%type;
    l_gross_weight vehicle_registration.gross_weight%type;
    l_unladen_weight vehicle_registration.unladen_weight%type;
    l_certificate_no certification.certificate_no%type;
    l_notes vehicle_registration.notes%type;
    l_surname ownership.surname%type;
    l_owner_name ownership.name%type;
    l_certificate_start_date certification.certificate_start_date%type;
    l_csdd_name csdd.name%type;
    l_certificate_end_date certification.certificate_end_date%type;
BEGIN
    SELECT 
        vnp.plate_no AS "Re�istr�cijas numurs",
        v.makes AS "Marka",
        v.model AS "Modelis",
        vr.release_year AS "Izlaiduma gads",
        vr.vin AS "�asijas Nr.",
        vr.gross_weight AS "Pilna masa /kg/",
        vr.unladen_weight AS "Pa�masa /kg/",
        c.certificate_no AS "Re�istr�cijas apliec�bas numurs",
        vr.notes AS "Piez�mes",
        o.surname AS "Uzv�rds",
        o.name AS "V�rds",
        c.certificate_start_date AS "Kad",
        cs.name AS "Kur",
        c.certificate_end_date AS "Der�ga l�dz"
    INTO
        l_plate_no,
        l_makes,
        l_model,
        l_release_year,
        l_vin,
        l_gross_weight,
        l_unladen_weight,
        l_certificate_no,
        l_notes,
        l_surname,
        l_owner_name,
        l_certificate_start_date,
        l_csdd_name,
        l_certificate_end_date
    FROM
        vehicle_number_plates vnp,
        vehicles v,
        vehicle_registration vr,
        certification c,
        ownership o,
        csdd cs
    WHERE
        vnp.plate_no = vr.plate_no AND
        v.model = vr.model AND
        c.certificate_no = vr.certificate_no AND
        cs.name = vr.csdd_location AND
        o.personal_no = vr.owner AND
        c.certificate_no = p_certification_no;
END;
/
BEGIN
    view_certification('KA7483645');
END;