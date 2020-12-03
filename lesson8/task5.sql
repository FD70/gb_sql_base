
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети

-- Которые наименьшую
SELECT user_id, COUNT(*) AS activ FROM LIKES GROUP BY user_id ORDER BY activ LIMIT 10;

-- Которые наибольшую
SELECT user_id, COUNT(*) AS activ FROM LIKES GROUP BY user_id ORDER BY activ DESC LIMIT 10;