UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW();
SELECT * FROM users LIMIT 3;