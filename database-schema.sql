CREATE DATABASE IF NOT EXISTS hotel_db;
USE hotel_db;

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type ENUM('SINGLE', 'DOUBLE', 'SUITE') NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    guest_email VARCHAR(100) NOT NULL,
    room_id INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    CONSTRAINT chk_dates CHECK (check_out > check_in)
);

CREATE INDEX idx_bookings_dates ON bookings (check_in, check_out);