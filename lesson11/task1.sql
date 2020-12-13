-- Создайте таблицу logs типа Archive.
-- Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу
-- logs помещается время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(30) NOT NULL,
	row_id INT NOT NULL,
	name_value VARCHAR(60) NOT NULL
) ENGINE = ARCHIVE;


DROP TRIGGER IF EXISTS log_new_user;
delimiter //
CREATE TRIGGER log_new_user AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, row_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.email);
END //
delimiter ;

DROP TRIGGER IF EXISTS log_new_mediafile;
delimiter //
CREATE TRIGGER log_new_mediafile AFTER INSERT ON media
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, row_id, name_value)
	VALUES (NOW(), 'media', NEW.id, NEW.filename);
END //
delimiter ;