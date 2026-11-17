
-- create database
CREATE DATABASE college_assignment;

USE college_assignment;


-- Create users table
CREATE TABLE users (
    id INT NOT NULL PRIMARY key,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    age INT DEFAULT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
);


-- Insert sample users
INSERT INTO users (id, name, email, age, created_at)
VALUES
(1, 'Ashish', 'ashish@example.com', 24, '2026-11-18 10:00:00'),
(2, 'Rahul', 'rahul@example.com', 24, '2026-11-17 10:00:00'),
(3, 'Priya', 'priya@example.com', 23, '2026-11-17 11:00:00'),
(4, 'Ankit', 'ankit@example.com', 25, '2026-11-17 12:00:00'),
(5, 'Sneha', 'sneha@example.com', 21, '2026-11-17 13:00:00'),
(6, 'Rohit', 'rohit@gmail.com', 24, '2026-11-17 14:00:00');
