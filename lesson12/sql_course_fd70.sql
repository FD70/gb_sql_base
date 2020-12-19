-- http://klavogonki.ru
-- Сайт, на котором проводятся гонки, посредством печати текста на клавиатуре


-- В одной "Гонке" может участвовать несколько пользователей
-- (не реализовано в данном примере) Каждая "Гонка" дает пользователю очки (profiles.scores), есть валюта (profiles.money)
-- (не реализовано в данном примере) Особые типы заездов (run_history.type=??) дают пользователю опыт (profiles.experience)
-- (не реализовано в данном примере) При достижении определенных успехов, пользователю присваивается ранг (ranks)

-- Гонка проводится по конкретному словарю (dictionary), который имеет свой тип
-- Словари могут создавать пользователи сами (dictionary.creator_user_id)
-- (dictionary_users) Содержит список пользователей, использующих конкретный словарь
-- Также есть система сообщений (messages)
-- Также есть система дружбы (friendship)

-- Пользователь имеет машину (cars)
-- Пользователь может иметь несколько машин (cars_property)
-- Есть определенные требования к приобретению машины (cars)

-- 	--  	== 			     			== 		--	--
-- 			== 			Начало 			== 			--
-- 	--		== 			     			== 		--	--

-- drop database if exists klavogonki;
-- create database klavogonki;
use klavogonki;

-- ==== Создание таблиц ==== --

-- #1 Пользователи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- #2 Профили пользователей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    scores INT UNSIGNED NOT NULL,
    money INT UNSIGNED NOT NULL,
    experience INT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- #3 Ранги
DROP TABLE IF EXISTS ranks;
CREATE TABLE ranks (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    speed_required INT NOT NULL UNIQUE
);

-- #4 сообщения
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    from_user_id INT UNSIGNED NOT NULL,
    to_user_id INT UNSIGNED NOT NULL,
	body text NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- #5 Друзья
DROP TABLE IF EXISTS friendship;
CREATE TABLE friendship (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
    friend_id INT UNSIGNED NOT NULL,
    status_id INT UNSIGNED NOT NULL,
    confirmed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);
-- #5.1 (Не создано) таблица с возможными статусами дружбы

-- #6 История заездов
DROP TABLE IF EXISTS runs_history;
CREATE TABLE runs_history (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	run_type VARCHAR(30) NOT NULL,
    dictionary_id VARCHAR(30),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    closed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- #6.1 (не создано)  Детальная история заезда, содержать какие пользователи участвовали
-- и результаты пользователей в этом заезде

-- #8 Список машин
DROP TABLE IF EXISTS cars;
CREATE TABLE cars (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
    level_reqire INT,
    buy_score_value INT NOT NULL,
    buy_money_value INT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- #7 Наличие машина в гараже
DROP TABLE IF EXISTS car_property;
CREATE TABLE car_property (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
    car_id INT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (car_id) REFERENCES cars (id)
);



-- #9 Словарь, его описание
DROP TABLE IF EXISTS dictionary;
CREATE TABLE dictionary (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	creator_user_id INT UNSIGNED NOT NULL,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- #10 Пользователи конкретного словаря
DROP TABLE IF EXISTS dictionary_users;
CREATE TABLE dictionary_users (
	dictionary_id INT UNSIGNED NOT NULL PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dictionary_id) REFERENCES dictionary (id)
);

-- ==														   == --
-- == Заполнить таблицу из скриптов, файл sql_course_fd70.sql  == --
-- ==														   == --

-- == Создание индексов                                        == --

CREATE INDEX users_email ON users (email);
CREATE INDEX users_created_at ON users (created_at);
CREATE INDEX msg_from_to_user_id ON messages (from_user_id, to_user_id);
CREATE INDEX msg_from_user_id ON messages (from_user_id);
CREATE INDEX msg_to_user_id ON messages (to_user_id);


-- выбрать все словари, созданные одним пользователем
select users.name, dictionary.id from users join dictionary
	on users.id = dictionary.creator_user_id
    where dictionary.creator_user_id = 7;

-- выбрать пользователей, имеющих experience больше 5
select users.name, profiles.experience from users, profiles
	where profiles.experience > 5 and users.id = profiles.user_id;

-- выбрать пользователей, имеющих машину типа 1
select users.name from users join car_property
	on users.id = car_property.user_id
    where car_property.car_id = 1;

-- ==														   == --
-- ==        Создаю представления из характерных выборок       == --
-- ==														   == --

DROP VIEW if EXISTS type_1_car_owners;
CREATE VIEW type_1_car_owners  AS
	SELECT users.name from users join car_property
		on users.id = car_property.user_id
		where car_property.car_id = 1;

DROP VIEW if EXISTS experience_over_5;
CREATE VIEW experience_over_5 AS
	select users.name, profiles.experience from users, profiles
		where profiles.experience > 5 and users.id = profiles.user_id;

-- select * from type_1_car_owners;
-- select * from experience_over_5;
