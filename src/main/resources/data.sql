-- Sample data for Car Rental Management System
-- Note: Passwords are BCrypt encoded for 'password123'

-- Insert Users (1 admin, 1 technical, 3 customers)
-- Password for all users: password123
INSERT INTO users (name, contact, email, user_type, password, is_active, created_date) VALUES
('Admin User', '+1-555-0001', 'admin@rental.com', 'ADMIN', '$2a$10$nmvGnLnshn9cyzv8qu2KTeGwXfHRuVyMNE2.ZrfcXVYJqcbXIpBOu', true, 1704067200000),
('Technical Staff', '+1-555-0002', 'tech@rental.com', 'TECHNICAL', '$2a$10$nmvGnLnshn9cyzv8qu2KTeGwXfHRuVyMNE2.ZrfcXVYJqcbXIpBOu', true, 1704067200000),
('John Smith', '+1-555-0101', 'john.smith@email.com', 'CUSTOMER', '$2a$10$nmvGnLnshn9cyzv8qu2KTeGwXfHRuVyMNE2.ZrfcXVYJqcbXIpBOu', true, 1704153600000),
('Sarah Johnson', '+1-555-0102', 'sarah.johnson@email.com', 'CUSTOMER', '$2a$10$nmvGnLnshn9cyzv8qu2KTeGwXfHRuVyMNE2.ZrfcXVYJqcbXIpBOu', true, 1704240000000),
('Michael Brown', '+1-555-0103', 'michael.brown@email.com', 'CUSTOMER', '$2a$10$nmvGnLnshn9cyzv8qu2KTeGwXfHRuVyMNE2.ZrfcXVYJqcbXIpBOu', true, 1704326400000);

-- Insert Cars (10 cars with varied specifications)
INSERT INTO cars (name, company, color, date_of_purchase, fuel_type, gear_type, listing_id, description, is_available, created_date) VALUES
('Civic', 'Honda', 'White', 1642204800000, 'PETROL', 'MANUAL', 'HON-CIV-001', 'Reliable and fuel-efficient sedan perfect for city driving', true, 1642204800000),
('Corolla', 'Toyota', 'Silver', 1647734400000, 'PETROL', 'AUTOMATIC', 'TOY-COR-002', 'Popular compact car with excellent safety ratings', true, 1647734400000),
('Accord', 'Honda', 'Black', 1636502400000, 'HYBRID', 'AUTOMATIC', 'HON-ACC-003', 'Spacious hybrid sedan with premium features', true, 1636502400000),
('Camry', 'Toyota', 'Blue', 1651968000000, 'PETROL', 'AUTOMATIC', 'TOY-CAM-004', 'Mid-size sedan with comfortable interior', true, 1651968000000),
('Model 3', 'Tesla', 'Red', 1676332800000, 'ELECTRIC', 'AUTOMATIC', 'TES-M3-005', 'Electric vehicle with autopilot features', true, 1676332800000),
('Altima', 'Nissan', 'Gray', 1632528000000, 'PETROL', 'AUTOMATIC', 'NIS-ALT-006', 'Stylish sedan with advanced technology', true, 1632528000000),
('Jetta', 'Volkswagen', 'White', 1657584000000, 'DIESEL', 'MANUAL', 'VW-JET-007', 'German engineering with excellent fuel economy', true, 1657584000000),
('Prius', 'Toyota', 'Green', 1650240000000, 'HYBRID', 'AUTOMATIC', 'TOY-PRI-008', 'Eco-friendly hybrid with outstanding MPG', true, 1650240000000),
('Sentra', 'Nissan', 'Black', 1638662400000, 'PETROL', 'MANUAL', 'NIS-SEN-009', 'Compact car ideal for daily commuting', true, 1638662400000),
('Elantra', 'Hyundai', 'Silver', 1661817600000, 'PETROL', 'AUTOMATIC', 'HYU-ELA-010', 'Affordable sedan with modern features', true, 1661817600000);

-- Insert Bookings (15 bookings across different date ranges)
INSERT INTO bookings (car_id, customer_id, start_date, end_date, earning_amount, total_earning, booking_status, amount_credited_date, created_date) VALUES
(1, 3, 1705276800000, 1705708800000, 250.00, 250.00, 'COMPLETED', 1705795200000, 1705276800000),
(2, 4, 1705881600000, 1706140800000, 180.00, 180.00, 'COMPLETED', 1706227200000, 1705881600000),
(3, 5, 1706745600000, 1707091200000, 320.00, 320.00, 'COMPLETED', 1707177600000, 1706745600000),
(4, 3, 1707523200000, 1707868800000, 280.00, 280.00, 'COMPLETED', 1707955200000, 1707523200000),
(5, 4, 1708387200000, 1708646400000, 450.00, 450.00, 'COMPLETED', 1708732800000, 1708387200000),
(6, 5, 1709251200000, 1709510400000, 200.00, 200.00, 'COMPLETED', 1709596800000, 1709251200000),
(7, 3, 1710028800000, 1710288000000, 190.00, 190.00, 'COMPLETED', 1710374400000, 1710028800000),
(8, 4, 1710892800000, 1711238400000, 240.00, 240.00, 'COMPLETED', 1711324800000, 1710892800000),
(9, 5, 1711929600000, 1712275200000, 220.00, 220.00, 'COMPLETED', 1712361600000, 1711929600000),
(10, 3, 1713225600000, 1713484800000, 210.00, 210.00, 'COMPLETED', 1713571200000, 1713225600000),
(1, 4, 1714521600000, 1714953600000, 300.00, 300.00, 'COMPLETED', 1715040000000, 1714521600000),
(2, 5, 1715731200000, 1716076800000, 260.00, 260.00, 'COMPLETED', 1716163200000, 1715731200000),
(3, 3, 1717200000000, 1717459200000, 280.00, 280.00, 'CONFIRMED', 0, 1717200000000),
(4, 4, 1718064000000, 1718496000000, 350.00, 350.00, 'CONFIRMED', 0, 1718064000000),
(5, 5, 1718928000000, 1719360000000, 400.00, 400.00, 'PENDING', 0, 1718928000000);

-- Insert Expenses (16 expense records for current and previous months)
INSERT INTO expenses (name, description, expense_date, amount, category, created_date) VALUES
('Fuel Cost', 'Monthly fuel expenses for all vehicles', 1706659200000, 450.00, 'Fuel', 1706659200000),
('Vehicle Maintenance', 'Regular maintenance and oil change', 1707955200000, 320.00, 'Maintenance', 1707955200000),
('Insurance Premium', 'Monthly insurance payment', 1709078400000, 280.00, 'Insurance', 1709078400000),
('Fuel Cost', 'Monthly fuel expenses for all vehicles', 1709078400000, 420.00, 'Fuel', 1709078400000),
('Tire Replacement', 'New tires for Honda Civic', 1710028800000, 180.00, 'Maintenance', 1710028800000),
('Insurance Premium', 'Monthly insurance payment', 1711843200000, 280.00, 'Insurance', 1711843200000),
('Fuel Cost', 'Monthly fuel expenses for all vehicles', 1711843200000, 380.00, 'Fuel', 1711843200000),
('Office Supplies', 'Stationery and printing materials', 1712275200000, 75.00, 'Office', 1712275200000),
('Vehicle Maintenance', 'Brake service for Toyota Corolla', 1713571200000, 250.00, 'Maintenance', 1713571200000),
('Insurance Premium', 'Monthly insurance payment', 1714435200000, 280.00, 'Insurance', 1714435200000),
('Fuel Cost', 'Monthly fuel expenses for all vehicles', 1714435200000, 410.00, 'Fuel', 1714435200000),
('Marketing', 'Online advertising campaign', 1715731200000, 150.00, 'Marketing', 1715731200000),
('Insurance Premium', 'Monthly insurance payment', 1717113600000, 280.00, 'Insurance', 1717113600000),
('Fuel Cost', 'Monthly fuel expenses for all vehicles', 1717113600000, 390.00, 'Fuel', 1717113600000),
('Vehicle Maintenance', 'AC repair for Nissan Altima', 1717804800000, 200.00, 'Maintenance', 1717804800000),
('Insurance Premium', 'Monthly insurance payment', 1719705600000, 280.00, 'Insurance', 1719705600000);

-- Update sequences to ensure proper auto-increment
SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));
SELECT setval('cars_id_seq', (SELECT MAX(id) FROM cars));
SELECT setval('bookings_booking_id_seq', (SELECT MAX(booking_id) FROM bookings));
SELECT setval('expenses_id_seq', (SELECT MAX(id) FROM expenses));
