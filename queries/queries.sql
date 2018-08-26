
-- Простые выборки
-- 1. SELECT - выбрать 10 записей из таблицы movies_metadata
SELECT * FROM movies_metadata LIMIT 10;

-- 2 WHERE - выбрать из таблицы links всё записи, у которых imdbid оканчивается на "111", 
-- а поле movieid между 100 и 10000
SELECT movieid, imdbId FROM links WHERE movieid BETWEEN 100 and 10000 GROUP BY 1,2 HAVING imdbId like '%111' ORDER BY movieid LIMIT 10;

-- Сложные выборки: JOIN
-- 3 INNER JOIN выбрать из таблицы links все imdb_id, которым ставили рейтинг 5
SELECT imdbid FROM links JOIN ratings on ratings.movieid = links.movieid WHERE rating = 5 GROUP BY imdbid LIMIT 10;

-- Аггрегация данных: базовые статистики
-- 4 COUNT() Посчитать число фильмов без оценок
SELECT COUNT(movieid) FROM ratings WHERE rating IS NULL;

-- 5 Посчитать сколько раз ставился каждый тип оценки
SELECT rating, COUNT(*) FROM ratings GROUP BY rating HAVING COUNT(*) > 10 LIMIT 10;

-- 6 Проверить наличие нулей в столбце raiting
SELECT * FROM ratings ORDER BY rating ASC LIMIT 10;

-- 7 GROUP BY, HAVING вывести top-10 пользователей, у который средний рейтинг выше 3.5
SELECT DISTINCT userId, MAX(rating) as MAX_rating FROM ratings GROUP BY userId HAVING AVG(rating) > 3.5 ORDER BY MAX_rating DESC LIMIT 10;

-- Иерархические запросы
-- 8 Подзапросы: достать 10 imbdId из links у которых средний рейтинг больше 3.5. 
-- Нужно подсчитать средний рейтинг по всем пользователям, которые попали под условие
SELECT AVG(rating) FROM (SELECT imdbid, rating FROM links JOIN ratings on ratings.movieid = links.movieid WHERE rating > 3.5 GROUP BY 2,1 LIMIT 10) as rating_ten_imdb;

-- 9 Common Table Expressions: посчитать средний рейтинг по пользователям, 
-- у которых более 10 оценок
WITH ten_marks AS (SELECT userid, COUNT(rating) as count_marks FROM ratings GROUP BY userid HAVING COUNT(rating) > 10 LIMIT 10) SELECT AVG(rating) as avg_rating FROM ten_marks JOIN ratings on ratings.userid = ten_marks.userid GROUP BY ratings.userId LIMIT 10;

