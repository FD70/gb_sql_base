
-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям
-- (сколько лайков получили 10 самых молодых пользователей).

-- SELECT COUNT(*) FROM likes HAVING target_id IN (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10);
-- Моя версия не поддерживает такой запрос, не могу проверить

CREATE TEMPORARY TABLE l6t4temp SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;
SELECT COUNT(*) FROM likes WHERE target_id IN (SELECT * FROM l6t4temp);