-- créer DATABASE "FitTrackDB"
CREATE DATABASE FitTrackDB;
-- show les bases de données existe dans le server
show DATABASES;
-- utiliser DATABASE "FitTrackDB"
USE FitTrackDB;

--  show TABLEs existe dans la base de données
show TABLEs;

-- update ligne TABLEau
UPDATE members SET gender = "Female" WHERE id_member = 1;

-- SELECTion FROM the TABLEs :
SELECT * FROM members;

SELECT * FROM rooms;

SELECT * FROM departments;

SELECT * FROM trainers;

SELECT * FROM memberships;

SELECT * FROM appointments;

SELECT * FROM workout_plans;
--  création des TABLEaux ================================================================================================================================================
-- TABLE members (pas de clé etrangère dans ce TABLE)
CREATE TABLE members (
    id_member INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    gender VARCHAR(15),
    date_of_birth DATE,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    PRIMARY KEY (id_member)
);

-- TABLE rooms (pas de clé etrangère dans ce TABLE)
CREATE TABLE rooms (
    id_room INT NOT NULL AUTO_INCREMENT,
    room_number VARCHAR(20) NOT NULL,
    room_type VARCHAR(20),
    capacity INT,
    PRIMARY KEY (id_room)
);

-- TABLE departments (pas de clé etrangère dans ce TABLE)
CREATE TABLE departments (
    id_department INT NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(50),
    location VARCHAR(100),
    PRIMARY KEY (id_department)
);

-- TABLE trainers (un clé étrangère id_department )
CREATE TABLE trainers (
    id_trainer INT NOT NULL AUTO_INCREMENT,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    specialization VARCHAR(50),
    id_department INT,
    PRIMARY KEY (id_trainer),
    FOREIGN KEY (id_department) REFERENCES departments (id_department)
);

-- TABLE memberships (deux clés étrangères id_member, id_room )
CREATE TABLE memberships (
    id_membership INT NOT NULL AUTO_INCREMENT,
    id_member INT,
    id_room INT,
    start_date DATE,
    PRIMARY KEY (id_membership),
    FOREIGN KEY (id_member) REFERENCES members (id_member),
    FOREIGN KEY (id_room) REFERENCES rooms (id_room)
);

-- TABLE appointments (deux clés étrangères id_trainer, id_member)
CREATE TABLE appointments (
    id_appointment INT NOT NULL AUTO_INCREMENT,
    appointment_date DATE,
    appointment_time TIME,
    id_trainer INT,
    id_member INT,
    PRIMARY KEY (id_appointment),
    FOREIGN KEY (id_member) REFERENCES members (id_member),
    FOREIGN KEY (id_trainer) REFERENCES trainers (id_trainer)
);

-- TABLE workout_plans (deux clés étrangères id_trainer, id_member)
CREATE TABLE workout_plans (
    id_plan INT NOT NULL AUTO_INCREMENT,
    id_member INT,
    id_trainer INT,
    instructions VARCHAR(255),
    PRIMARY KEY (id_plan),
    FOREIGN KEY (id_trainer) REFERENCES trainers (id_trainer),
    FOREIGN KEY (id_member) REFERENCES members (id_member)
);

-- Les exercices ====================================================================================================================================================
-- exercice 1 :
INSERT INTO
    members (
        first_name,
        last_name,
        gender,
        date_of_birth,
        phone_number
    )
VALUES (
        'Alex',
        'Johnson',
        'Male',
        '1990-07-15',
        '1234567890'
    );

-- exercice 2 :
SELECT * FROM departments;
-- ou bien
SELECT department_name, location FROM departments;

-- exercice 3 :
SELECT * FROM members order by date_of_birth;

-- exercie 4 :
SELECT DISTINCT gender FROM members;

-- exercice 5 :
SELECT * FROM trainers LIMIT 3;

-- exercice 6 :
SELECT * FROM members WHERE YEAR(date_of_birth) > 2000;

-- exercice 7 : refaire
SELECT *
FROM trainers
WHERE (
        specialization = 'Musculation Coach'
        or specialization = 'Cardio Specialist'
    );
-- ou bien
SELECT *
FROM trainers
WHERE
    specialization IN (
        'Musculation Coach',
        'Cardio Specialist'
    );
-- ou bien
SELECT *
FROM trainers
WHERE
    id_department IN (
        SELECT *
        FROM departments
        WHERE
            department_name = 'Musculation'
            or department_name = 'Cardio'
    );

-- exercice 8 :
SELECT *
FROM memberships
WHERE
    start_date BETWEEN '2024-12-01' AND '2024-12-07';

-- exercice 9 :
ALTER TABLE members ADD age_categorie varchar(50);

-- exercice 10 :
SELECT count(*) FROM appointments;

-- exercice 11 :
SELECT id_department AS 'Departement_ID', count(*) As 'Nombre d entraineur'
FROM trainers
GROUP BY
    id_department;

-- exercice 12 :
SELECT AVG(
        YEAR(CURDATE()) - YEAR(date_of_birth)
    ) AS avg_age
FROM members
WHERE
    date_of_birth IS NOT NULL;

-- exercice 13 :
SELECT MAX(
        CONCAT(
            appointment_date, ' ', appointment_time
        )
    ) AS last_appointment
FROM appointments;

-- exercice 14 :
-- SELECT SUM() FROM memberships GROUP BY id_room ;

--
SELECT id_room, COUNT(*) AS total_abonnements
FROM memberships
GROUP BY
    id_room;

-- exercice 15 :
SELECT * FROM members WHERE email IS NULL;

-- exercice 16 :
SELECT
    a.id_appointment,
    a.appointment_date,
    a.appointment_time,
    t.first_name AS trainer_first_name,
    t.last_name AS trainer_last_name,
    m.first_name AS member_first_name,
    m.last_name AS member_last_name
FROM
    appointments a
    JOIN trainers t ON a.id_trainer = t.id_trainer
    JOIN members m ON a.id_member = m.id_member;

-- exercice 17 :
DELETE FROM appointments WHERE appointment_date < '2024-01-01';

-- exercice 18 :
UPDATE departments
SET
    department_name = "Force et Conditionnement"
WHERE
    department_name = "Musculation";

-- exercice 19 :
SELECT gender, COUNT(*) AS total_members
FROM members
GROUP BY
    gender
HAVING
    COUNT(*) >= 2;
-- ou bien
SELECT gender, COUNT(*) AS total_members
FROM members
GROUP BY
    gender
HAVING
    total_members >= 2;

-- exercice 20 :
CREATE VIEW active_memberships AS
SELECT
    id_membership,
    id_member,
    id_room,
    start_date
FROM memberships
WHERE
    start_date <= CURDATE();

-- selectionner from un vue :
select * from active_memberships;

-- show les views existe dans la base de données
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Les bonus ====================================================================================================================================================
-- benus 1 :
SELECT
    -- m.first_name AS member_first_name,
    -- m.last_name AS member_last_name,
    -- t.first_name AS trainer_first_name,
    -- t.last_name AS trainer_last_name
    CONCAT(m.first_name, ' ', m.last_name) AS member_full_name,
    CONCAT(t.first_name, ' ', t.last_name) AS trainer_full_name
FROM
    members m
    JOIN appointments a ON m.id_member = a.id_member
    JOIN trainers t ON a.id_trainer = t.id_trainer;

-- benus 2 :
SELECT
a.id_appointment,
    a.appointment_date,
    a.appointment_time,
    -- t.first_name AS trainer_first_name,
    -- t.last_name AS trainer_last_name,
    d.department_name
FROM
    appointments a
    JOIN trainers t ON a.id_trainer = t.id_trainer
    JOIN departments d ON t.id_department = d.id_department;

-- benus 3 :
-- Si "supplements" est une colonne dans la table trainers :
SELECT
    t.first_name AS trainer_first_name,
    t.last_name AS trainer_last_name,
    t.specialization,
    t.supplements
FROM trainers t;

-- Si "supplements" est une table liéer aux entraîneurs :
SELECT
    t.first_name AS trainer_first_name,
    t.last_name AS trainer_last_name,
    s.supplement_name
FROM trainers t
    JOIN supplements s ON t.id_trainer = s.id_trainer;

-- benus 4 :
SELECT
    -- m.first_name AS member_first_name,
    -- m.last_name AS member_last_name,
    CONCAT(m.first_name, ' ', m.last_name) AS member_full_name,
    r.room_number,
    r.room_type,
    ms.start_date
FROM
    memberships ms
    JOIN members m ON ms.id_member = m.id_member
    JOIN rooms r ON ms.id_room = r.id_room;

-- benus 5 :
SELECT d.department_name, COUNT(m.id_member) AS member_count
FROM
    departments d
    JOIN trainers t ON d.id_department = t.id_department
    JOIN appointments a ON t.id_trainer = a.id_trainer
    JOIN members m ON a.id_member = m.id_member
GROUP BY
    d.department_name;