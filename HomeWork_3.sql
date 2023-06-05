CREATE DATABASE IF NOT EXISTS home_3;

USE home_3;

DROP TABLE IF EXISTS staff_home;
CREATE TABLE staff_home
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(45) NOT NULL,
    lastname VARCHAR(45) NOT NULL,
    post VARCHAR(45) NOT NULL,
    seniority INT, 
    salary DECIMAL(8,2), 
    age INT
);
-- 4. Заполнение таблицы данными
INSERT staff_home(firstname, lastname, post, seniority,salary,age)
VALUES ("Петр", "Петров", "Начальник", 8, 70000, 30); -- id = 1
INSERT staff_home (firstname, lastname, post, seniority, salary, age)
VALUES
  ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
  ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
  ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
  ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
  ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
  ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
  ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
  ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
  ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
  ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
  ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
  ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

SELECT * FROM staff_home;

-- Отсортируйте данные по полю заработная плата (salary) в порядке убывания
SELECT * FROM staff_home ORDER BY salary DESC;

-- Отсортируйте данные по полю заработная плата (salary) в порядке возрастания
SELECT * FROM staff_home ORDER BY salary ASC;

-- Выведите 5 максимальных заработных плат (saraly)
SELECT * FROM staff_home ORDER BY salary DESC LIMIT 5;

-- Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post, SUM(salary) as total_salary FROM staff_home GROUP BY post;

-- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT COUNT(*) as count FROM staff_home WHERE post='Рабочий' AND age>=24 AND age<=49;

-- Найдите количество специальностей
SELECT COUNT(DISTINCT post) as count FROM staff_home;

-- Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
SELECT post FROM staff_home GROUP BY post HAVING AVG(age)<30;

-- Внутри каждой должности вывести ТОП-2 по ЗП (2 самых высокооплачиваемых сотрудника по ЗП внутри каждой должности)
SELECT post, firstname, lastname, salary FROM (
  SELECT post, firstname, lastname, salary, 
  RANK() OVER (PARTITION BY post ORDER BY salary DESC) AS salary_rank
  FROM staff_home
) as ranking
WHERE salary_rank <= 2; 

-- Посчитать количество документов у каждого пользователя (дополнительный пример)
SELECT user_id, COUNT(*) as num_documents FROM documents GROUP BY user_id;

-- Посчитать лайки для моих документов (моих медиа) (дополнительный пример)
SELECT SUM(likes) as total_likes FROM media WHERE user_id = 'my_user_id';