
-- @block Car table
CREATE TABLE bilbasen_car (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    owner_id INTEGER NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES bilbasen_user(id)
);
