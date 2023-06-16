USE lesson_4;

SELECT * FROM users, friend_requests, messages,media, likes, communities, users_communities, profiles;

-- Домашняя работа 
-- Создание представления "друзья"
CREATE VIEW friends AS 
SELECT initiator_user_id AS user_id, target_user_id AS friend_id, status 
FROM friend_requests 
WHERE status = 'approved'
UNION ALL 
SELECT target_user_id AS user_id, initiator_user_id AS friend_id, status 
FROM friend_requests 
WHERE status = 'approved';  
-- Получение друзей пользователя с id=1
SELECT CONCAT(u.firstname, " ",u.lastname) AS fullname, u.id
FROM friends f 
JOIN users u ON u.id = f.friend_id 
WHERE f.user_id = 1; 

-- Создание представления "участие в сообщениях"
CREATE VIEW message_participation AS 
SELECT
	m.id, 
	m.from_user_id
FROM messages m 
WHERE m.to_user_id = 1 
UNION ALL 
SELECT 
	m.id, 
    m.from_user_id  
FROM messages m 
JOIN users u ON u.id = m.id 
WHERE m.from_user_id = 1; 

-- Вывод сообщений, в которых участвует пользователь с id=1
SELECT m.body, u.id
FROM messages m, users u
WHERE u.id = 1; 

-- Получение списка медиафайлов пользователя с количеством лайков
SELECT 
m.filename, 
COUNT(l.user_id) AS num_likes 
FROM media m 
LEFT JOIN likes l ON l.media_id = m.id 
WHERE m.user_id = 1 
GROUP BY m.id; 

-- Получение количества групп у пользователей
SELECT 
	CONCAT(u.firstname, " ", u.lastname) AS fullname, 
	COUNT(uc.user_id) AS num_groups 
FROM users_communities uc, users u
WHERE uc.user_id = u.id 
GROUP BY u.id;

-- Часть вторая 
CREATE VIEW users_info AS
SELECT
	CONCAT(u.firstname, " ", u.lastname) AS fullname, 
    p.hometown,
    p.birthday
FROM users u,  profiles p
WHERE DATEDIFF(CURDATE(), p.birthday) >= 20*365;

SELECT  m.from_user_id, DENSE_RANK() OVER (ORDER BY m.from_user_id DESC) as ranking
FROM (
    SELECT CONCAT(u.firstname, " ", u.lastname), COUNT(m.from_user_id) as message_count
    FROM users u 
    JOIN messages m ON u.id = m.id
    GROUP BY u.id
) t
ORDER BY message_count DESC; 

SELECT content, created_at, 
LEAD(created_at, 1, NULL) OVER (ORDER BY created_at) - created_at as time_difference
FROM messages
ORDER BY created_at ASC;