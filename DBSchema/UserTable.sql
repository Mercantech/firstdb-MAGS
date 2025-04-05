-- Postgres SQL

-- @block Serial er en auto incrementing integer
CREATE TABLE bilbasen_user (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

