
--  insertion of data 

-- Insertion dans members :
INSERT INTO members (first_name, last_name, gender, date_of_birth, phone_number, email) VALUES
('Asmae', 'milo', 'Female', '1990-05-15', '1234567890', 'asmae.milo@gmail.com'),
('Sondoss', 'Samir', 'Female', '1999-10-15', '9876543210', 'Sondoss.Samir@gmail.com'),
('Mehdi', 'Jamil', 'Male', '1992-07-10', '5678901234', 'mehdi.j@gmail.com'),
('Malak', 'saada', 'Female', '1998-12-01', '5432198765', 'malak.saada@gmail.com'),
('Zakaryae', 'Ramas', 'Male', '1994-11-20', '1122334455', 'Zakaryae.Ramas@gmail.com');
--
INSERT INTO members (first_name, last_name, gender, date_of_birth, phone_number) VALUES
('Taha', 'Said', 'Male', '2001-12-09', '1122334412');


-- Insertion dans rooms :
INSERT INTO rooms (room_number, room_type, capacity) VALUES
('4', 'Cardio', 20),
('5', 'Cardio', 15),
('6', 'Studio', 25),
('7', 'Weights', 30),
('8', 'Weights', 10);


-- Insertion dans departments :

INSERT INTO departments (department_name, location) VALUES
('Musculation', 'Building A'),
('Cardio', 'Building B'),
('Strength Training', 'Building C'),
('Musculation', 'Building D'),
('Yoga', 'Building E');

-- Insertion dans trainers
INSERT INTO trainers (first_name, last_name, specialization, id_department) VALUES 
('Assim', 'Hani', 'Yoga Instructor', 1),
('Samah', 'Charif', 'Strength Training', 2),
('Khadija', 'Melouki', 'Cardio Specialist', 3),
('Younes', 'Kabouri', 'Aerobics Coach', 4),
('Sofyane', 'Hafidi', 'Musculation Coach', 5);

-- Insertion dans memberships
INSERT INTO memberships (id_member, id_room, start_date) VALUES
(1, 5, '2023-01-15'),
(2, 2, '2023-02-10'),
(3, 4, '2023-03-05'),
(4, 3, '2023-04-20'),
(5, 1, '2023-05-10');

-- Insertion dans appointments
INSERT INTO appointments (appointment_date, appointment_time, id_trainer, id_member) VALUES
('2024-01-20', '10:00:00', 1, 4),
('2023-02-15', '11:30:00', 2, 5),
('2024-03-10', '14:00:00', 3, 1),
('2022-04-25', '15:00:00', 4, 2),
('2024-05-15', '16:00:00', 5, 3);


-- Insertion dans workout_plans
INSERT INTO workout_plans (id_member, id_trainer, instructions) VALUES
(1, 3, 'Séances de musculation 3 fois par semaine, focus sur le haut du corps.'),
(2, 4, 'Crossfit avec des séances intensives de 45 minutes.'),
(3, 5, 'Séances de Yoga matinales 3 fois par semaine.'),
(4, 1, 'Pilates pour la rééducation et la flexibilité, 2 fois par semaine.'),
(5, 2, 'Musculation avec des entraînements ciblés sur la masse musculaire.');



-- update des nom de departments
UPDATE departments SET department_name = "Musculation" WHERE id_department=1;
UPDATE departments SET department_name = "Cardio" WHERE id_department=2;
UPDATE departments SET department_name = "Strength Training" WHERE id_department=3;
UPDATE departments SET department_name = "Musculation" WHERE id_department=4;
UPDATE departments SET department_name = "Yoga" WHERE id_department=5;


-- pour supprimer les tableaux : 
-- 1-
SET FOREIGN_KEY_CHECKS = 0;

-- 2-
DROP TABLE workout_plans;
DROP TABLE appointments;
DROP TABLE memberships;
DROP TABLE trainers;
DROP TABLE rooms;
DROP TABLE departments;
DROP TABLE members;
