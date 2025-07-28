-- Car Rental Management System Database Schema

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS expenses CASCADE;
DROP TABLE IF EXISTS cars CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create Users table
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    user_type VARCHAR(20) NOT NULL CHECK (user_type IN ('ADMIN', 'TECHNICAL', 'CUSTOMER')),
    password VARCHAR(255) NOT NULL,
    created_date BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW()) * 1000,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- Create Cars table
CREATE TABLE cars (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    company VARCHAR(50) NOT NULL,
    color VARCHAR(30) NOT NULL,
    date_of_purchase BIGINT NOT NULL,
    fuel_type VARCHAR(20) NOT NULL CHECK (fuel_type IN ('PETROL', 'DIESEL', 'ELECTRIC', 'HYBRID')),
    gear_type VARCHAR(20) NOT NULL CHECK (gear_type IN ('MANUAL', 'AUTOMATIC')),
    listing_id VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    created_date BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW()) * 1000
);

-- Create Bookings table
CREATE TABLE bookings (
    booking_id BIGSERIAL PRIMARY KEY,
    car_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    start_date BIGINT NOT NULL,
    end_date BIGINT NOT NULL,
    earning_amount DECIMAL(10,2) NOT NULL CHECK (earning_amount > 0),
    total_earning DECIMAL(10,2),
    amount_credited_date BIGINT,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'PENDING' CHECK (booking_status IN ('PENDING', 'CONFIRMED', 'COMPLETED', 'CANCELLED')),
    created_date BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW()) * 1000,
    FOREIGN KEY (car_id) REFERENCES cars(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT check_dates CHECK (end_date >= start_date)
);

-- Create Expenses table
CREATE TABLE expenses (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    expense_date BIGINT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    category VARCHAR(50),
    created_date BIGINT NOT NULL DEFAULT EXTRACT(EPOCH FROM NOW()) * 1000
);

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_user_type ON users(user_type);
CREATE INDEX idx_users_is_active ON users(is_active);

CREATE INDEX idx_cars_listing_id ON cars(listing_id);
CREATE INDEX idx_cars_is_available ON cars(is_available);
CREATE INDEX idx_cars_fuel_type ON cars(fuel_type);
CREATE INDEX idx_cars_gear_type ON cars(gear_type);
CREATE INDEX idx_cars_company ON cars(company);

CREATE INDEX idx_bookings_car_id ON bookings(car_id);
CREATE INDEX idx_bookings_customer_id ON bookings(customer_id);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);
CREATE INDEX idx_bookings_end_date ON bookings(end_date);
CREATE INDEX idx_bookings_status ON bookings(booking_status);
CREATE INDEX idx_bookings_created_date ON bookings(created_date);

CREATE INDEX idx_expenses_expense_date ON expenses(expense_date);
CREATE INDEX idx_expenses_category ON expenses(category);
CREATE INDEX idx_expenses_created_date ON expenses(created_date);

-- Create a view for booking details with car and customer information
CREATE OR REPLACE VIEW booking_details AS
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.earning_amount,
    b.total_earning,
    b.amount_credited_date,
    b.booking_status,
    b.created_date,
    c.name AS car_name,
    c.company AS car_company,
    c.listing_id AS car_listing_id,
    u.name AS customer_name,
    u.email AS customer_email,
    u.contact AS customer_contact
FROM bookings b
JOIN cars c ON b.car_id = c.id
JOIN users u ON b.customer_id = u.id;

-- Create a view for monthly earnings summary
CREATE OR REPLACE VIEW monthly_earnings_summary AS
SELECT
    EXTRACT(YEAR FROM to_timestamp(start_date / 1000)) AS year,
    EXTRACT(MONTH FROM to_timestamp(start_date / 1000)) AS month,
    COUNT(*) AS total_bookings,
    SUM(earning_amount) AS total_earnings,
    AVG(earning_amount) AS average_earning
FROM bookings
WHERE booking_status != 'CANCELLED'
GROUP BY EXTRACT(YEAR FROM to_timestamp(start_date / 1000)), EXTRACT(MONTH FROM to_timestamp(start_date / 1000))
ORDER BY year DESC, month DESC;

-- Create a view for car performance
CREATE OR REPLACE VIEW car_performance AS
SELECT
    c.id,
    c.name,
    c.company,
    c.listing_id,
    COUNT(b.booking_id) AS total_bookings,
    COALESCE(SUM(b.earning_amount), 0) AS total_earnings,
    COALESCE(AVG(b.earning_amount), 0) AS average_earning_per_booking
FROM cars c
LEFT JOIN bookings b ON c.id = b.car_id AND b.booking_status != 'CANCELLED'
GROUP BY c.id, c.name, c.company, c.listing_id
ORDER BY total_earnings DESC;
