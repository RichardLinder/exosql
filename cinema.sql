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
-- g)
SELECT r.role_name, concat( h.first_name ," ", h.last_name) as noms_de_acteur, DATE_FORMAT(f.france_release_date, "%Y") as sortie_en FROM `actor` a
INNER JOIN human h
on h.id_human = a.id_human
INNER JOIN casting c
ON c.id_actor =a.id_actor
INNER JOIN role r
ON c.id_role = r.id_role
INNER JOIN film f
ON c.id_film =f.id_film
WHERE a.id_actor =1;
-- h)
SELECT concat( h.first_name, " ", h.last_name) AS noms ,  r.id_director , a.id_actor FROM `human` h
LEFT JOIN actor a
ON h.id_human = a.id_human
LEFT JOIN realisateur r
ON h.id_human =r.id_director
WHERE r.id_director is NOT null
AND a.id_actor is NOT null

-- i)
SELECT  title
FROM `film`
WHERE date_format(france_release_date ,"%Y") <= 2018;

-- j)
SELECT sex, COUNT(* ) as nombre FROM human
INNER JOIN actor
on actor.id_human = human.id_human
GROUP by human.sex; 

-- k)
SELECT  concat( h.first_name, " " ,h.last_name) as noms
FROM human h
JOIN actor a
ON a.id_human =h.id_human
where date_format(h.birthdate ,"%Y") <= 1972;
-- l)
SELECT r.role_name, concat( h.first_name ," ", h.last_name) as noms_de_acteur FROM `actor` a
INNER JOIN human h
on h.id_human = a.id_human
INNER JOIN casting c
ON c.id_actor =a.id_actor
INNER JOIN role r
ON c.id_role = r.id_role
INNER JOIN film f
ON c.id_film =f.id_film
having  count( f.id_film) >=3