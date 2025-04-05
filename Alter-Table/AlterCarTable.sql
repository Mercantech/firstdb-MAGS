ALTER TABLE bilbasen_car
ADD COLUMN color VARCHAR(50),
ADD COLUMN fuel_type VARCHAR(50),
ADD COLUMN transmission VARCHAR(20),
ADD COLUMN manufacturing_year INTEGER,
ADD COLUMN mileage INTEGER,
ADD COLUMN price DECIMAL(10,2),
ADD COLUMN horsepower INTEGER,
ADD COLUMN number_of_doors INTEGER,
ADD COLUMN brand VARCHAR(50),
ADD COLUMN model VARCHAR(50);

-- Tilføj nogle constraints for at sikre data kvalitet
ALTER TABLE bilbasen_car
    ADD CONSTRAINT year_check CHECK (manufacturing_year >= 1900 AND manufacturing_year <= EXTRACT(YEAR FROM CURRENT_DATE)),
    ADD CONSTRAINT mileage_check CHECK (mileage >= 0),
    ADD CONSTRAINT price_check CHECK (price >= 0),
    ADD CONSTRAINT horsepower_check CHECK (horsepower > 0),
    ADD CONSTRAINT doors_check CHECK (number_of_doors BETWEEN 2 AND 5);

-- Tilføj kommentarer til kolonnerne for bedre dokumentation
COMMENT ON COLUMN bilbasen_car.color IS 'Bilens farve';
COMMENT ON COLUMN bilbasen_car.fuel_type IS 'Brændstoftype (benzin, diesel, el, hybrid)';
COMMENT ON COLUMN bilbasen_car.transmission IS 'Transmissionstype (manuel, automatisk)';
COMMENT ON COLUMN bilbasen_car.manufacturing_year IS 'Produktionsår';
COMMENT ON COLUMN bilbasen_car.mileage IS 'Kilometertal';
COMMENT ON COLUMN bilbasen_car.price IS 'Pris i DKK';
COMMENT ON COLUMN bilbasen_car.horsepower IS 'Antal hestekræfter';
COMMENT ON COLUMN bilbasen_car.number_of_doors IS 'Antal døre';
COMMENT ON COLUMN bilbasen_car.brand IS 'Bilmærke';
COMMENT ON COLUMN bilbasen_car.model IS 'Bilmodel';
