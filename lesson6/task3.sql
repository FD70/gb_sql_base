-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT user_id,
(SELECT gender FROM profiles WHERE likes.user_id = profiles.user_id) AS gen
FROM likes
GROUP BY gen;