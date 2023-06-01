-- a)
SELECT 
f.title,
f.france_release_date,
f.length_in_minute,
concat(h.first_name," ", h.last_name) as realisateur
FROM film f
INNER JOIN realisateur r
ON r.id_director = f.id_director
INNER JOIN human h
ON h.id_human =r.id_human;
-- b)
SELECT f.title
FROM film f
WHERE f.length_in_minute > 135
ORDER BY f.length_in_minute DESC
-- c)
SELECT 
f.title,
f.france_release_date,
f.length_in_minute,
concat(h.first_name," ", h.last_name) as realisateur
FROM film f
INNER JOIN realisateur r
ON r.id_director = f.id_director
INNER JOIN human h
ON h.id_human =r.id_human
WHERE r.id_director =2
-- d)
SELECT 
COUNT(f.id_film) AS nombre_de_film_par_genre,g.wording
FROM clasification c
INNER JOIN film f ON f.id_film = c.id_film
INNER JOIN genre g ON g.id_genre = c.id_genre
GROUP BY g.wording
ORDER BY nombre_de_film_par_genre DESC
-- e)
SELECT COUNT(f.id_film) AS nombre_de_film_par_realisateur, r.id_director
FROM film f
INNER JOIN realisateur r ON r.id_director = f.id_director
GROUP BY r.id_director 
ORDER BY nombre_de_film_par_realisateur DESC
-- f)
SELECT f.title, concat( h.first_name, " ",h.last_name) as noms_de_acteur
FROM casting c
INNER JOIN film f ON f.id_film = c.id_film
INNER JOIN actor a ON c.id_actor = a.id_actor
INNER JOIN human h ON a.id_human = h.id_human
WHERE f.id_film = 1;