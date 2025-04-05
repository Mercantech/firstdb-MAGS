-- @block aktiverer PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- @block tilføjer en kolonne til at gemme geografiske koordinater
ALTER TABLE bilbasen_user
ADD COLUMN location GEOGRAPHY(POINT);

-- @block tilføjer en kolonne til at gemme bynavnet
ALTER TABLE bilbasen_user
ADD COLUMN city TEXT;

-- @block opretter en index til hurtigere forespørgsel
CREATE INDEX user_location_idx ON bilbasen_user USING GIST (location);
