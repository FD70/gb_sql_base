
-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям
-- (сколько лайков получили 10 самых молодых пользователей).

-- SELECT COUNT(*) FROM likes HAVING target_id IN (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10);
-- Моя версия не поддерживает такой запрос, не могу проверить

--CREATE TEMPORARY TABLE l6t4temp SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;
--SELECT COUNT(*) FROM likes WHERE target_id IN (SELECT * FROM l6t4temp);

CREATE TEMPORARY TABLE l8t4temp
SELECT profiles.user_id, profiles.birthday FROM likes
    INNER JOIN profiles
    ON likes.target_id = profiles.user_id
    ORDER BY birthday DESC;

select sum(cc) from (select count(*) as cc FROM l8t4temp
	group by birthday
    limit 10) as a;