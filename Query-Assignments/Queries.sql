-- TODO: 

-- @block 1. Tæl hvor mange biler der er i databasen
SELECT COUNT(*) FROM bilbasen_car;

-- @block 2. Skriv en query som viser strukturen af bilbasen_car tabellen
SELECT * FROM bilbasen_car;

-- @block 3. Finde alle biler af mærket "Audi"
SELECT * FROM bilbasen_car WHERE brand = 'Audi';

-- @block 4. Finde alle biler med en given farve
SELECT * FROM bilbasen_car WHERE color = 'Red';

-- @block 4. Finde alle biler med en given brændstoftype
-- 5. Finde alle biler med en given transmissionstype
