-- @block Opretter midlertidige arrays med danske for- og efternavne
WITH RECURSIVE 
first_names AS (
    SELECT unnest(ARRAY[
        'Anders', 'Peter', 'Lars', 'Michael', 'Henrik', 'Martin', 'Thomas', 'Mette',
        'Anne', 'Maria', 'Louise', 'Emma', 'Sofia', 'Julie', 'Camilla', 'Christina'
    ]) as first_name
),
last_names AS (
    SELECT unnest(ARRAY[
        'Nielsen', 'Jensen', 'Hansen', 'Pedersen', 'Andersen', 'Christensen',
        'Larsen', 'Sørensen', 'Rasmussen', 'Jørgensen', 'Madsen', 'Kristensen'
    ]) as last_name
),
-- Genererer 10000 rækker med tilfældige kombinationer
random_users AS (
    SELECT DISTINCT ON (email)  -- This ensures unique emails
        first_name || ' ' || last_name as full_name,
        LOWER(
            REPLACE(first_name, ' ', '') || '.' || 
            REPLACE(last_name, ' ', '') || 
            floor(random() * 999999 + 1)::text ||  -- Increased range for more uniqueness
            '@email.com'
        ) as email,
        '+45' || floor(random() * (99999999 - 10000000 + 1) + 10000000)::text as phone,
        CURRENT_TIMESTAMP - (random() * interval '365 days') as created_at
    FROM 
        first_names 
        CROSS JOIN last_names,
        generate_series(1, 20000)  -- Increased to ensure we get enough unique combinations
    ORDER BY email, random()  -- Order by email first to make DISTINCT ON work properly
    LIMIT 10000
)
-- Indsætter de genererede data i bilbasen_user tabellen
INSERT INTO bilbasen_user (name, email, phone, created_at)
SELECT 
    full_name,
    email,
    phone,
    created_at
FROM random_users;

-- @block viser antal brugere
SELECT COUNT(*) FROM bilbasen_user;
