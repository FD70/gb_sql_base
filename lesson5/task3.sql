CREATE TEMPORARY TABLE ddd SELECT * FROM media WHERE media_type_id > 1 ORDER BY media_type_id;
SELECT * FROM ddd 
UNION SELECT * FROM media WHERE media_type_id = 1;
-- Вместо третьего задания