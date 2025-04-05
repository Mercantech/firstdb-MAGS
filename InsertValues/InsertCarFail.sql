-- Forsøg på at indsætte en bil med en ikke-eksisterende bruger (owner_id)
INSERT INTO bilbasen_car (name, owner_id)
VALUES ('Toyota Corolla', 1);

-- @block indsætter en nu random_users
INSERT INTO bilbasen_user (name, email, phone, created_at)
VALUES ('Mathias', 'mathias@example.com', '+4512341234', '2025-11-11');

-- @block indsætter en bil med Mathias som ejer (owner_id)
INSERT INTO bilbasen_car (name, owner_id)
VALUES ('Ford Mustang', 1);


-- @block viser alle bilene
SELECT * FROM bilbasen_car;

-- @block viser alle brugerne
SELECT * FROM bilbasen_user;


-- @block viser alle bilene med ejeren
SELECT bilbasen_car.name as car_name, bilbasen_user.name as user_name FROM bilbasen_car
JOIN bilbasen_user ON bilbasen_car.owner_id = bilbasen_user.id;






