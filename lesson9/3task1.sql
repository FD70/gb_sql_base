-- Создайте хранимую функцию hello(), которая будет возвращать приветствие,
-- в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер",
-- с 00:00 до 6:00 — "Доброй ночи".

drop table if exists l93t1;
create temporary table l93t1 (id INT, name VARCHAR(30));
select * from l93t1;
INSERT INTO l93t1 values (0, "Доброе Утро");
INSERT INTO l93t1 values (1, "Добрый День");
INSERT INTO l93t1 values (2, "Добрый Вечер");
INSERT INTO l93t1 values (3, "Доброй Ночи");

DROP PROCEDURE IF EXISTS hello;
DELIMITER //
CREATE PROCEDURE hello ()
BEGIN
	SELECT name FROM l93t1 where l93t1.id = HOUR(CURTIME()) DIV 6;
END//

CALL hello();