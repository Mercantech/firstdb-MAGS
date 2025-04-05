-- Opdater farve
UPDATE bilbasen_car
SET color = (
    CASE floor(random() * 10)::int
        WHEN 0 THEN 'Sort'
        WHEN 1 THEN 'Hvid'
        WHEN 2 THEN 'Sølv'
        WHEN 3 THEN 'Rød'
        WHEN 4 THEN 'Blå'
        WHEN 5 THEN 'Grå'
        WHEN 6 THEN 'Grøn'
        WHEN 7 THEN 'Brun'
        WHEN 8 THEN 'Beige'
        WHEN 9 THEN 'Guld'
    END
);

-- Opdater brændstoftype
UPDATE bilbasen_car
SET fuel_type = (
    CASE floor(random() * 5)::int
        WHEN 0 THEN 'Benzin'
        WHEN 1 THEN 'Diesel'
        WHEN 2 THEN 'El'
        WHEN 3 THEN 'Hybrid'
        WHEN 4 THEN 'Plugin-hybrid'
    END
);

-- Opdater transmissionstype
UPDATE bilbasen_car
SET transmission = (
    CASE floor(random() * 4)::int
        WHEN 0 THEN 'Manuel'
        WHEN 1 THEN 'Automatisk'
        WHEN 2 THEN 'DSG'
        WHEN 3 THEN 'CVT'
    END
);

-- Opdater produktionsår
UPDATE bilbasen_car
SET manufacturing_year = 2000 + floor(random() * 25)::integer;

-- Opdater kilometertal
UPDATE bilbasen_car
SET mileage = floor(random() * 300000)::integer;

-- Opdater pris
UPDATE bilbasen_car
SET price = (50000 + floor(random() * 950000))::decimal(10,2);

-- Opdater hestekræfter
UPDATE bilbasen_car
SET horsepower = 65 + floor(random() * 436)::integer;

-- Opdater antal døre
UPDATE bilbasen_car
SET number_of_doors = 2 + floor(random() * 4)::integer;

-- Opdater mærke og model sammen
UPDATE bilbasen_car
SET 
    brand = CASE temp.brand_num
        WHEN 0 THEN 'Toyota'
        WHEN 1 THEN 'Volkswagen'
        WHEN 2 THEN 'Ford'
        WHEN 3 THEN 'BMW'
        WHEN 4 THEN 'Mercedes'
        WHEN 5 THEN 'Audi'
        WHEN 6 THEN 'Volvo'
        WHEN 7 THEN 'Peugeot'
        WHEN 8 THEN 'Citroën'
        WHEN 9 THEN 'Skoda'
        WHEN 10 THEN 'Kia'
        WHEN 11 THEN 'Hyundai'
    END,
    model = CASE temp.brand_num
        WHEN 0 THEN (ARRAY['Corolla', 'Camry', 'RAV4', 'Yaris'])[1 + floor(random() * 4)]
        WHEN 1 THEN (ARRAY['Golf', 'Passat', 'Polo', 'Tiguan'])[1 + floor(random() * 4)]
        WHEN 2 THEN (ARRAY['Focus', 'Fiesta', 'Kuga', 'Mustang'])[1 + floor(random() * 4)]
        WHEN 3 THEN (ARRAY['320i', '520i', 'X3', 'X5'])[1 + floor(random() * 4)]
        WHEN 4 THEN (ARRAY['C200', 'E300', 'GLC', 'A200'])[1 + floor(random() * 4)]
        WHEN 5 THEN (ARRAY['A3', 'A4', 'Q5', 'Q7'])[1 + floor(random() * 4)]
        WHEN 6 THEN (ARRAY['V60', 'XC60', 'XC90', 'S90'])[1 + floor(random() * 4)]
        WHEN 7 THEN (ARRAY['208', '308', '3008', '5008'])[1 + floor(random() * 4)]
        WHEN 8 THEN (ARRAY['C3', 'C4', 'C5', 'Berlingo'])[1 + floor(random() * 4)]
        WHEN 9 THEN (ARRAY['Octavia', 'Superb', 'Kodiaq', 'Karoq'])[1 + floor(random() * 4)]
        WHEN 10 THEN (ARRAY['Ceed', 'Sportage', 'Rio', 'Picanto'])[1 + floor(random() * 4)]
        WHEN 11 THEN (ARRAY['i30', 'Tucson', 'Kona', 'i20'])[1 + floor(random() * 4)]
    END
FROM (SELECT id, floor(random() * 12)::int as brand_num FROM bilbasen_car) as temp
WHERE bilbasen_car.id = temp.id;

-- Vis nogle eksempler på de opdaterede data
SELECT 
    brand, 
    model, 
    color, 
    fuel_type, 
    transmission,
    manufacturing_year, 
    price, 
    mileage, 
    horsepower,
    number_of_doors
FROM bilbasen_car 
ORDER BY RANDOM()
LIMIT 10;