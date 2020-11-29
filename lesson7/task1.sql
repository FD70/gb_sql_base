SELECT first_name, what.activ FROM users
	JOIN
		(SELECT user_id, count(*) AS activ FROM likes GROUP BY user_id) AS what
			ON users.id = what.user_id WHERE what.activ = 2;

-- Список пользователей, актив которых равен 2