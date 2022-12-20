--------------------------------------------------------------------------------
/*
    Vehicle Colors (2.1 Krâsu uzturçðana)
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
    dbms_output.put_line('Krâsa '||p_name||' ar kodu '||p_code||' veiksmîgi pievienota datubâzei!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Kïûda! Krâsu kodam jâsastâv no 5 simboliem un/vai krâsas nosaukums nevar bût lielâks par 100 simboliem!');
END;
/
--Pârbaude:
BEGIN
    insert_color('64768', 'Pelçks');
END;
---------------------------------[ Update ]-------------------------------------
CREATE OR REPLACE PROCEDURE update_color (
    p_code IN VARCHAR2,
    p_name IN VARCHAR2,
    p_new_code IN VARCHAR2)
AS
BEGIN
    UPDATE vehicle_colors SET code = p_new_code, name = p_name WHERE code = p_code;
    dbms_output.put_line('Krâsa '||p_name||' ar kodu '||p_code||' veiksmîgi atjaunota!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('Kïûda! Krâsa datubâzç nav atrodama!');
END;
/
--Pârbaude:
BEGIN
    update_color('60A91', 'Melns', '90A91');
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_color (
    p_code IN VARCHAR2)
AS
BEGIN
    DELETE FROM vehicle_colors WHERE code = p_code;
    dbms_output.put_line('Krâsa ar kodu '||p_code||' veiksmîgi izdzçsta!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('Kïûda! Krâsa datubâzç nav atrodama!');
END;
/
--Pârbaude:
BEGIN
    delete_color('90A91');
END;
---------------------------------[ Select ]-------------------------------------
--Vienkârðs select's par visiem datiem tabulâ
SELECT
    code AS "Kods",
    name AS "Krâsa"
FROM vehicle_colors;
--------------------------------------------------------------------------------
/*
    Vehicle Makes and Model (2.2 Marku un modeïu uzturçðana)
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
    dbms_output.put_line('Marka: '||p_makes||' (modelis: '||p_model||') veiksmîgi pievienots datubâzei!');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Kïûda! Markas un/vai modeïa nosaukums nevar bût lielâks par 20 simboliem!');
        dbms_output.put_line('Kïûda! Markas un/vai modeïa nosaukums var bût tikai ar lielajiem burtiem!');
END;
/
--Pârbaude:
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
    dbms_output.put_line('Markas '||p_makes||' modelis '||p_new_model||' veiksmîgi atjaunots!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('Kïûda! Modelis datubâzç nav atrodams!');
END;
/
--Pârbaude:
BEGIN
    update_vehicles('AUDI', 'A4', 'A8');
END;
---------------------------------[ Delete ]-------------------------------------
CREATE OR REPLACE PROCEDURE delete_vehicles (
    p_model IN VARCHAR2)
AS
BEGIN
    DELETE FROM vehicles WHERE model = p_model;
    dbms_output.put_line('Krâsa ar kodu '||p_model||' veiksmîgi izdzçsta!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('Kïûda! Modelis datubâzç nav atrodams!');
END;
/
--Pârbaude:
BEGIN
    delete_vehicles('A8');
END;
---------------------------------[ Select ]-------------------------------------
--Vienkârðs select's par visiem datiem tabulâ
SELECT
    makes AS "Markas nosaukums",
    model AS "Modeïa nosaukums"
FROM vehicles;
--------------------------------------------------------------------------------
/*
    CSDD (3.1 CSDD struktûrvienîbas)
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
    dbms_output.put_line('Dati veiksmîgi pievienoti datubâzei!');
END;
/
--Pârbaude:
BEGIN
    insert_csdd('Aizkraukle', 'MR0000', 'MR9999', 'Ìenerçts', '', '', '');
    insert_csdd('Alûksne', 'MU001', 'MU999', 'Ìenerçts', 'AK0000000', 'AK9999999', 'Ìenerçts');
    insert_csdd('Balvi', '', '', '', 'KA0000000', 'KA9999999', 'Ìenerçts');
    insert_csdd('Bauska', 'GJ0000', 'GJ9999', 'Ìenerçts', 'GA0000000', 'GA9999999', 'Ìenerçts');
    insert_csdd('Cçsis', 'GM0000', 'GM9999', 'Ìenerçts', 'ZF0000000', 'ZF9999999', 'Ìenerçts');
    insert_csdd('Daugavpils', 'HM0000', 'HM9999', '', 'AZ0000000', 'AZ9999999', 'Ìenerçts');
    insert_csdd('Dobele', 'GV0000', 'GV9999', 'Ìenerçts', '', '', 'Ìenerçts');
    insert_csdd('Gulbene', '', '', '', 'EK0000000', 'EK9999999', 'Ìenerçts');
    insert_csdd('Jçkabpils', '', '', '', 'UV0000000', 'UV9999999', 'Ìenerçts');
    insert_csdd('Jelgava', '', '', '', 'ZF0000000', 'ZF9999999', 'Ìenerçts');
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
    dbms_output.put_line('CSDD struktûrvienîba veiksmîgi atjaunota!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('Kïûda! Struktûrvienîba datubâzç nav atrodama!');
END;
/
--Pârbaude:
BEGIN
    update_csdd('Aizkraukle', 'MR0000', 'MR9999', 'Ìenerçts', '', '', '', 'Atjaunotais');
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
        dbms_output.put_line('CSDD struktûra '||p_name||' veiksmîgi izdzçsta!');
    END IF;
EXCEPTION
    WHEN exception_name THEN
        dbms_output.put_line('Kïûda! Struktûrvienîba datubâzç nav atrodams!');
END;
/
--Pârbaude:
BEGIN
    delete_csdd('');
END;
---------------------------------[ Select ]-------------------------------------
--Vienkârðs select's par visiem datiem tabulâ
SELECT
    name AS "Nosaukums",
    number_plate_no_start AS "Maðînu numuri no",
    number_plate_no_end AS "Maðînu numuri lîdz",
    number_plate_status AS "Noìenerçti numuri",
    registration_certificate_start AS "Reìistrâcijas apliecîba no",
    registration_certificate_end AS "Reìistrâcijas apliecîba lîdz",
    registration_certificate_status AS "Noìenerçtas apliecîbas"
FROM csdd;
--------------------------------------------------------------------------------
/*
    Vehicle Number Plates (4.1 Maðînu numuru uzturçðana)
*/
DROP TABLE vehicle_number_plates;
CREATE TABLE vehicle_number_plates (
    plate_no VARCHAR2(8),
    plate_status VARCHAR2(9),
    plate_special VARCHAR2(3),
    CONSTRAINT pk_plate_no PRIMARY KEY (plate_no),
    CONSTRAINT chk_plate_status CHECK (plate_status IN ('Brîvs', 'Aizòemts', 'Neaktîvs')),
    CONSTRAINT chk_plate_special CHECK (plate_special IN ('Jâ', NULL)));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_vehicle_number_plates (
    p_plate_no IN VARCHAR2,
    p_plate_status IN VARCHAR2,
    p_plate_special IN VARCHAR2)
AS
BEGIN
    IF ((p_plate_special IS NULL) OR (p_plate_special = 'Jâ')) THEN
        INSERT INTO vehicle_number_plates VALUES (p_plate_no, p_plate_status, p_plate_special);
        dbms_output.put_line('Transportlîdzekïa numurs veiksmîgi pievienots datubâzei!');
    ELSE
        dbms_output.put_line('Kïûda! Pazîme var bût "Jâ" vai tukða');
    END IF;
END;
/
--Pârbaude:
BEGIN
    insert_vehicle_number_plates('MR8386', 'Aizòemts', NULL);
    insert_vehicle_number_plates('MU778', 'Aizòemts', 'Jâ');
    insert_vehicle_number_plates('GJ5739', 'Aizòemts', NULL);
    insert_vehicle_number_plates('GM4524', 'Aizòemts', NULL);
    insert_vehicle_number_plates('GV2766', 'Aizòemts', NULL);
    insert_vehicle_number_plates('HM6659', 'Aizòemts', NULL);
    insert_vehicle_number_plates('AB1234', 'Brîvs', '');
    insert_vehicle_number_plates('GOOD', 'Neaktîvs', 'Jâ');
    insert_vehicle_number_plates('DE3507', 'Neaktîvs', '');
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
    dbms_output.put_line('Numurzîme veiksmîgi atjaunota!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('Kïûda! Numurzîmç datubâzç nav atrodama!');
END;
/
--Pârbaude:
BEGIN
    update_vehicle_number_plates('MR8386', 'Aizòemts', NULL, 'ES678');
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
        dbms_output.put_line('Numurzîme '||p_plate_no||' veiksmîgi izdzçsta!');
    END IF;
EXCEPTION
    WHEN exception_plate THEN
        dbms_output.put_line('Kïûda! Tukða Numurzîme datubâzç nav atrodama!');
    WHEN exception_plate_v2 THEN
        dbms_output.put_line('Kïûda! Numurzîme datubâzç nav atrodama!');
END;
/
--Pârbaude:
BEGIN
    delete_vehicle_number_plates('MR8386');
END;
---------------------------------[ Select ]-------------------------------------
--Vienkârðs select's par visiem datiem tabulâ

SELECT
    plate_no AS "Numurs",
    plate_status AS "Statuss",
    plate_special AS "Ir speciâls"
FROM vehicle_number_plates;
--------------------------------------------------------------------------------
/*
    - (4.2 Reìistrâcijas apliecîbu uzturçðana)
*/
--------------------------------------------------------------------------------
--Kad ir sesija, nomaina sistçmas datuma formâtu no YYYY.MM.DD -> DD.MM.YYYY,
--attiecîgi, kad tiks restartçta sistçma, atgriezîsies atpakaï pie "vecâ" formâta
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
    CONSTRAINT chk_certificate_status CHECK (certificate_status IN ('Brîvs', 'Aizòemts', 'Neaktîvs')));
---------------------------------[ Insert ]-------------------------------------
CREATE OR REPLACE PROCEDURE insert_certification (
    p_certificate_no IN VARCHAR2,
    p_certificate_status IN VARCHAR2,
    p_certificate_start_date IN VARCHAR2,
    p_certificate_end_date IN VARCHAR2)
AS
BEGIN
    IF p_certificate_end_date < p_certificate_start_date THEN
        dbms_output.put_line('Kïûda! Derîguma termiòam jâbût lielâkam par izdoðanas datumu!');
    ELSE
        INSERT INTO certification VALUES (p_certificate_no, p_certificate_status, p_certificate_start_date, p_certificate_end_date);
        dbms_output.put_line('Reìistrâcijas apliecîba veiksmîgi pievienota datubâzei!');
    END IF;
END;
/
--Pârbaude:
BEGIN
    insert_certification('AK1720640', 'Aizòemts', TO_DATE('01.02.2017', 'DD.MM.YYYY'), TO_DATE('01.02.2027', 'DD.MM.YYYY'));
    insert_certification('KA7483645', 'Aizòemts', TO_DATE('09.11.2020', 'DD.MM.YYYY'), TO_DATE('09.11.2030', 'DD.MM.YYYY'));
    insert_certification('GA2543432', 'Aizòemts', TO_DATE('25.05.2014', 'DD.MM.YYYY'), TO_DATE('25.05.2024', 'DD.MM.YYYY'));
    insert_certification('ZF0912224', 'Aizòemts', TO_DATE('17.06.2012', 'DD.MM.YYYY'), TO_DATE('17.06.2022', 'DD.MM.YYYY'));
    insert_certification('AZ7365322', 'Aizòemts', TO_DATE('30.12.2016', 'DD.MM.YYYY'), TO_DATE('30.12.2026', 'DD.MM.YYYY'));
    insert_certification('EK1242156', 'Brîvs', NULL, NULL);
    insert_certification('UV6786214', 'Neaktîvs', TO_DATE('22.07.2002', 'DD.MM.YYYY'), TO_DATE('22.07.2012', 'DD.MM.YYYY'));
    insert_certification('ZF5782416', 'Neaktîvs', TO_DATE('05.01.2001', 'DD.MM.YYYY'), TO_DATE('05.01.2011', 'DD.MM.YYYY'));
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
    dbms_output.put_line('Reìistrâcijas apliecîba veiksmîgi atjaunota!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('Kïûda! Reìistrâcijas apliecîba ar Nr.'||p_certificate_no||' datubâzç nav atrodama!');
END;
/
--Pârbaude:
BEGIN
    update_certification('AK1720640', 'Brîvs', TO_DATE('01.02.2017', 'DD.MM.YYYY'), TO_DATE('01.02.2027', 'DD.MM.YYYY'));
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
        dbms_output.put_line('Reìistrâcijas apliecîba ar Nr. '||p_certificate_no||' veiksmîgi izdzçsta!');
    END IF;
EXCEPTION
    WHEN exception_certification THEN
        dbms_output.put_line('Kïûda! Tukða reìistrâcijas apliecîba datubâzç nav atrodama!');
    WHEN exception_certification_v2 THEN
        dbms_output.put_line('Kïûda! Reìistrâcijas apliecîba datubâzç nav atrodama!');
END;
/
--Pârbaude:
BEGIN
    delete_certification('AK1720640');
END;
---------------------------------[ Select ]-------------------------------------
--Vienkârðs select's par visiem datiem tabulâ
SELECT
    certificate_no AS "Apliecîba",
    certificate_status AS "Statuss",
    certificate_start_date AS "Izdoðanas datums",
    certificate_end_date AS "Derîguma termiòð"
FROM certification;
--------------------------------------------------------------------------------
/*
    - (5.1 Maðînu reìistrâcija)
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
--Pârbaude:
BEGIN
insert_vehicle_registration(
    'WAUZZZ8E54A008867', 2003, 2000, 1525, 'A4', 'Pelçks', 'Alûksne', 'AK1720640', 'MU778' , '120156-12345', 'Piezîme #1');
insert_vehicle_registration(
    'WAUZZZ8T7AA055568', 2010, 2250, 1795, 'A5', 'Oranþs', 'Aizkraukle', 'KA7483645', 'MR8386' , '231267-08076', 'Piezîme #2');
insert_vehicle_registration(
    'WBAAL71020KE22911',  1999, 1875, 1350, '330', 'Sarkans', 'Jçkabpils', 'UV6786214', 'GJ5739' , '270315-12120', 'Piezîme #3');
insert_vehicle_registration(
    'WBADL81030GJ68189',  1999, 2125, 1585, '530', 'Sarkans', 'Cçsis', 'ZF0912224', 'GM4524' , '111111-33420', 'Piezîme #4');
insert_vehicle_registration(
    'W0L000036T5123362',  1996, 1805, 1275, 'VECTRA', 'Pelçks', 'Dobele', 'GA2543432', 'GV2766' , '180492-00091', 'Piezîme #5');
insert_vehicle_registration(
    'WUG1GFUGU78674474',  2000, 2065, 1505, 'ZAFIRA', 'Zaïð', 'Daugavpils', 'AZ7365322', 'HM6659' , '090697-23352', 'Piezîme #6');
insert_vehicle_registration(
    'W7687SFA812451250',  2007, 1625, 1105, 'ESCORT', 'Violets', 'Gulbene', 'EK1242156', 'GOOD' , '270315-12120', 'Piezîme #7');
insert_vehicle_registration(
    'HSFA78730252S0001',  1999, 1160, 730, 'FIESTA', 'Zaïð', 'Jelgava', 'ZF5782416', 'DE3507' , '090478-10092', 'Piezîme #8');
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
    dbms_output.put_line('Transportlîdzekïa reìistrâcijas dati veiksmîgi atjaunoti!');
EXCEPTION
    WHEN NO_DATA_FOUND  THEN
        dbms_output.put_line('Kïûda! Transportlîdzekïa ðasijas nr.'||p_vin||' datubâzç nav atrodams!');
END;
/
--Pârbaude:
BEGIN
    update_vehicle_registration('WAUZZZ8E54A008867', 2003, 2000, 1525, 'A4', 'Pelçks', 'Alûksne', 'AK1720640', 'MU778' , '120156-12345', 'Piezîme #10', 'WAUZZZ8E54A008867');
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
        dbms_output.put_line('Transportlîdzeklis ar ðasijas nr. '||p_vin||' veiksmîgi izdzçsts!');
    END IF;
EXCEPTION
    WHEN exception_vin THEN
        dbms_output.put_line('Kïûda! Tukðs ðasijas nr. datubâzç nav atrodams!');
    WHEN exception_vin_v2 THEN
        dbms_output.put_line('Kïûda! Ðasijas nr. datubâzç nav atrodams!');
END;
/
--Pârbaude:
BEGIN
    delete_vehicle_registration('');
END;
---------------------------------[ Select ]-------------------------------------
--Vienkârðs select's par visiem datiem tabulâ
SELECT
    vin AS "Ðasijas numurs",
    release_year AS "Izlaiduma gads",
    gross_weight AS "Pilna masa",
    unladen_weight AS "Paðmasa",
    model AS "Modelis",
    color_name AS "Krâsa",
    csdd_location AS "CSDD struktûrvienîba",
    certificate_no AS "Apliecîba",
    plate_no AS "Numurs",
    owner AS "îpaðnieks",
    notes AS "Piezîmes"
FROM vehicle_registration;

INSERT INTO vehicle_registration VALUES (
    'WAUZZZ8E54A008867', 2003, 2000, 1525, 'A4', 'Pelçks', 'Alûksne', 'AK1720640', 'MU778' , '120156-12345', 'Piezîme #1');
    
INSERT INTO vehicle_registration VALUES (
    'WAUZZZ8T7AA055568', 2010, 2250, 1795, 'A5', 'Oranþs', 'Aizkraukle', 'KA7483645', 'MR8386' , '231267-08076', 'Piezîme #2');
    
INSERT INTO vehicle_registration VALUES (
    'WBAAL71020KE22911',  1999, 1875, 1350, '330', 'Sarkans', 'Jçkabpils', 'UV6786214', 'GJ5739' , '270315-12120', 'Piezîme #3');
    
INSERT INTO vehicle_registration VALUES (
    'WBADL81030GJ68189',  1999, 2125, 1585, '530', 'Sarkans', 'Cçsis', 'ZF0912224', 'GM4524' , '111111-33420', 'Piezîme #4');
    
INSERT INTO vehicle_registration VALUES (
    'W0L000036T5123362',  1996, 1805, 1275, 'VECTRA', 'Pelçks', 'Dobele', 'GA2543432', 'GV2766' , '180492-00091', 'Piezîme #5');
    
INSERT INTO vehicle_registration VALUES (
    'WUG1GFUGU78674474',  2000, 2065, 1505, 'ZAFIRA', 'Zaïð', 'Daugavpils', 'AZ7365322', 'HM6659' , '090697-23352', 'Piezîme #6');
    
INSERT INTO vehicle_registration VALUES (
    'W7687SFA812451250',  2007, 1625, 1105, 'ESCORT', 'Violets', 'Gulbene', 'EK1242156', 'GOOD' , '270315-12120', 'Piezîme #7');
    
INSERT INTO vehicle_registration VALUES (
    'HSFA78730252S0001',  1999, 1160, 730, 'FIESTA', 'Zaïð', 'Jelgava', 'ZF5782416', 'DE3507' , '090478-10092', 'Piezîme #8');
--------------------------------------------------------------------------------
/*
    Ownership (5.2 Îpaðnieku reìistrâcija)
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
    dbms_output.put_line('Îpaðnieks veiksmîgi pievienots datubâzei!');
END;
/
--Pârbaude:
BEGIN
    insert_ownership('Lauris', 'Reiniks', '12015612345');
    insert_ownership('Kûmiòð', 'Lapsa', '23126708076');
    insert_ownership('Oto', 'Traktors', '11111133420');
    insert_ownership('Jânis', 'Bçrziòð', '18049200091');
    insert_ownership('Einârs', 'Reðetins', '09069723352');
    insert_ownership('Daiga', 'Upîte', '27031512120');
    insert_ownership('Diâna', 'Lapèenovska', '09047810092');
    insert_ownership('Gunârs', 'Ugunsgrçks', '10089023219');
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
    dbms_output.put_line('Îpaðnieka dati veiksmîgi atjaunoti!');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Kïûda! Îpaðnieks datubâzç nav atrodams!');
END;
/
--Pârbaude:
BEGIN
    update_ownership('Lauris', 'Apsîtis', '12015612345');
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
        dbms_output.put_line('Persona ar personas kodu '||p_personal_no||' veiksmîgi izdzçsts!');
    END IF;
EXCEPTION
    WHEN exception_plate THEN
        dbms_output.put_line('Kïûda! Tukðs personas kods datubâzç nav atrodams!');
    WHEN exception_plate_v2 THEN
        dbms_output.put_line('Kïûda! Personas kods datubâzç nav atrodama!');
END;
/
--Pârbaude:
BEGIN
    delete_ownership('09069723352');
END;
---------------------------------[ Select ]-------------------------------------
--Vienkârðs select's par visiem datiem tabulâ
SELECT
    name AS "Vârds",
    surname AS "Uzvârds",
    personal_no AS "Personas kods"
FROM ownership;
--------------------------------------------------------------------------------
/*
    - (6.1 Reìistrâcijas apliecîba)
*/
--Variants #1 (izdrukâ visu iespçjamo informâciju par visâm apliecîbas nr.)
DROP VIEW certification_view;
CREATE VIEW certification_view AS
    SELECT 
        vnp.plate_no AS "Reìistrâcijas numurs",
        v.makes AS "Marka",
        v.model AS "Modelis",
        vr.release_year AS "Izlaiduma gads",
        vr.vin AS "Ðasijas Nr.",
        vr.gross_weight AS "Pilna masa /kg/",
        vr.unladen_weight AS "Paðmasa /kg/",
        c.certificate_no AS "Reìistrâcijas apliecîbas numurs",
        vr.notes AS "Piezîmes",
        o.surname AS "Uzvârds",
        o.name AS "Vârds",
        c.certificate_start_date AS "Kad",
        cs.name AS "Kur",
        c.certificate_end_date AS "Derîga lîdz"
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

--Variants #2 (izdrukâ konkrçtu informâciju par konkrçtu apliecîbas nr.)
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
        vnp.plate_no AS "Reìistrâcijas numurs",
        v.makes AS "Marka",
        v.model AS "Modelis",
        vr.release_year AS "Izlaiduma gads",
        vr.vin AS "Ðasijas Nr.",
        vr.gross_weight AS "Pilna masa /kg/",
        vr.unladen_weight AS "Paðmasa /kg/",
        c.certificate_no AS "Reìistrâcijas apliecîbas numurs",
        vr.notes AS "Piezîmes",
        o.surname AS "Uzvârds",
        o.name AS "Vârds",
        c.certificate_start_date AS "Kad",
        cs.name AS "Kur",
        c.certificate_end_date AS "Derîga lîdz"
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