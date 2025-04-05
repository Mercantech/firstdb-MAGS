-- @block Opretter en CTE med danske byer og deres koordinater
WITH danish_cities AS (
    SELECT * FROM (VALUES
        ('Copenhagen', 55.6761, 12.5683),
        ('Aarhus', 56.1572, 10.2107),
        ('Odense', 55.3958, 10.3886),
        ('Aalborg', 57.0500, 9.9167),
        ('Esbjerg', 55.4833, 8.4500),
        ('Randers', 56.4570, 10.0390),
        ('Horsens', 55.8583, 9.8500),
        ('Kolding', 55.4917, 9.5000),
        ('Vejle', 55.7167, 9.5333),
        ('Roskilde', 55.6500, 12.0833),
        ('Herning', 56.1333, 8.9833),
        ('Silkeborg', 56.1833, 9.5517),
        ('Hørsholm', 55.8803, 12.5081),
        ('Helsingør', 56.0361, 12.6083),
        ('Næstved', 55.2250, 11.7583),
        ('Viborg', 56.4333, 9.4000),
        ('Fredericia', 55.5667, 9.7500),
        ('Køge', 55.4561, 12.1797),
        ('Holstebro', 56.3572, 8.6153),
        ('Taastrup', 55.6500, 12.3000),
        ('Hillerød', 55.9333, 12.3167),
        ('Slagelse', 55.4049, 11.3531),
        ('Holbæk', 55.7156, 11.7225),
        ('Sønderborg', 54.9138, 9.7922),
        ('Svendborg', 55.0594, 10.6083),
        ('Hjørring', 57.4636, 9.9814),
        ('Nørresundby', 57.0667, 9.9167),
        ('Ringsted', 55.4425, 11.7900),
        ('Frederikshavn', 57.4410, 10.5340),
        ('Haderslev', 55.2428, 9.5250),
        ('Birkerød', 55.8333, 12.4333),
        ('Farum', 55.8083, 12.3581),
        ('Skive', 56.5667, 9.0333),
        ('Nykøbing Falster', 54.7654, 11.8755),
        ('Skanderborg', 56.0381, 9.9253),
        ('Nyborg', 55.3122, 10.7897),
        ('Vordingborg', 55.0000, 11.9000),
        ('Frederikssund', 55.8333, 12.0666),
        ('Middelfart', 55.4986, 9.7444),
        ('Kalundborg', 55.6814, 11.0850),
        ('Ikast', 56.1333, 9.1500),
        ('Aabenraa', 55.0444, 9.4181),
        ('Grenaa', 56.4161, 10.8923),
        ('Varde', 55.6200, 8.4806),
        ('Rønne', 55.0986, 14.7014),
        ('Thisted', 56.9569, 8.6944),
        ('Værløse', 55.7819, 12.3731),
        ('Odder', 55.9725, 10.1497),
        ('Brønderslev', 57.2694, 9.9472),
        ('Frederiksværk', 55.9667, 12.0167)
    ) AS cities(city_name, latitude, longitude)
)
-- Opdaterer alle brugere med tilfældige byer og deres koordinater
UPDATE bilbasen_user
SET 
    city = cities.city_name,
    location = ST_MakePoint(cities.longitude, cities.latitude)::geography
FROM (
    SELECT city_name, latitude, longitude, row_number() OVER (ORDER BY random()) as rn
    FROM danish_cities
    CROSS JOIN (
        SELECT generate_series(1, (SELECT COUNT(*) FROM bilbasen_user)) as id
    ) AS numbers
) AS cities
WHERE bilbasen_user.id = cities.rn;

-- @block Verificerer opdateringen ved at vise nogle eksempler og distribution
SELECT 
    city,
    COUNT(*) as antal_brugere,
    ST_AsText(location::geometry) as example_coordinate
FROM bilbasen_user
GROUP BY city, location
LIMIT 10;


-- @block tag 100 ud der kan blive vist på et kort i pgadmin
SELECT * FROM bilbasen_user
LIMIT 100;