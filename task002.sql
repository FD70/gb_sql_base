CREATE DATABASE IF NOT EXISTS example;
USE example;
drop table if exists users;
CREATE TABLE users (
	id INT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(255)
);
INSERT INTO users VALUES (1, 'user1');
SELECT * FROM users;