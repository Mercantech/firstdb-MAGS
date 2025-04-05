-- @block Indsæt 10000 biler med tilfældige navne og ejere (Alternativ metode)
WITH user_data AS (
    SELECT array_agg(id) as ids, count(id)::int as total_users
    FROM bilbasen_user
),
brand_data AS (
    SELECT ARRAY[
        'Toyota', 'Volkswagen', 'Ford', 'BMW', 'Mercedes', 'Audi',
        'Volvo', 'Peugeot', 'Citroën', 'Skoda', 'Kia', 'Hyundai'
    ] as list,
    12 as count 
),
suffix_data AS (
    SELECT ARRAY[
        'Sport', 'Comfort', 'Premium', 'Limited', 'GT', 'Edition',
        'Classic', 'Active', 'Style', 'Dynamic'
    ] as list,
    10 as count 
)
INSERT INTO bilbasen_car (name, owner_id)
SELECT
    -- Vælg tilfældigt mærke og suffiks baseret på array index
    bd.list[1 + floor(random() * bd.count)] || ' ' || sd.list[1 + floor(random() * sd.count)] AS car_name,
    -- Vælg tilfældigt owner_id baseret på array index
    ud.ids[1 + floor(random() * ud.total_users)] AS owner_id
FROM
    generate_series(1, 10000) g, -- Generer 10000 rækker
    user_data ud,                -- Hent bruger data (kun én række)
    brand_data bd,               -- Hent mærke data (kun én række)
    suffix_data sd;              -- Hent suffiks data (kun én række)


-- @block viser antal biler
SELECT COUNT(*) FROM bilbasen_car;


-- @block slet alle biler i databasen
DELETE FROM bilbasen_car;

-- @block viser antal biler per bruger
SELECT
    owner_id,
    COUNT(*) as number_of_cars
FROM bilbasen_car
GROUP BY owner_id
ORDER BY number_of_cars DESC
LIMIT 10;



