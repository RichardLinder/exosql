-- 1)Nom des lieuxqui finissent par'um'.
SELECT nom_lieu , id_lieu  FROM `lieu` WHERE `nom_lieu` LIKE '%um';
-- 2) Nombre de personnagespar lieu (trié par nombre de personnagesdécroissant).
SELECT l.nom_lieu, COUNT(p.id_personnage) AS nbr_habitant FROM `personnage` p
INNER JOIN lieu l
WHERE p.id_lieu =l.id_lieu
GROUP BY l.nom_lieu
ORDER BY nbr_habitant DESC;
-- 3) Nom des personnages+ spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage.
SELECT   p.nom_personnage,  p.adresse_personnage, l.nom_lieu , s.nom_specialite FROM `personnage` p
INNER JOIN lieu l 
ON l.id_lieu = p.id_lieu
INNER JOIN specialite s
ON s.id_specialite = p.id_specialite  
ORDER BY l.nom_lieu ,
`p`.`nom_personnage`;
-- 4) Nom  des  spécialités  avec  nombre  de personnagespar  spécialité  (trié  par  nombre  de personnagesdécroissant).
SELECT s.nom_specialite , COUNT(p.id_personnage) AS nbr_de FROM `personnage` p
INNER JOIN specialite s
WHERE p.id_specialite =s.id_specialite
GROUP BY s.nom_specialite
ORDER BY nbr_de DESC;
-- 5)Nom,date etlieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa).
SELECT b.nom_bataille, DATE_FORMAT(b.date_bataille, "%d/%m/%Y"), l.nom_lieu  FROM `bataille` b
join lieu l
on b.id_lieu=l.id_lieu
ORDER BY date_bataille DESC;
-- 6) Nom des potions + coût de réalisation de la potion (trié par coût décroissant)
SELECT p.nom_potion, (c.qte* i.cout_ingredient) as prix FROM `composer` c
INNER JOIN potion p 
ON p.id_potion= c.id_potion
JOIN ingredient i
ON i.id_ingredient = c.id_ingredient
GROUP BY  p.nom_potion  
ORDER BY `prix` DESC;
-- 7)Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'.
SELECT i.cout_ingredient, i.nom_ingredient, p.nom_potion FROM `composer` c
INNER JOIN potion p 
ON p.id_potion= c.id_potion
JOIN ingredient i
ON i.id_ingredient = c.id_ingredient
WHERE `nom_potion` LIKE 'Santé'
-- 8) Nom du ou des personnagesqui ont pris le plus de casques dans la bataille 'Bataille du village gaulois'.
SELECT per.nom_personnage, b.nom_bataille,   MAX(p.qte) FROM `prendre_casque` p
JOIN bataille b
ON b.id_bataille = p.id_bataille
JOIN personnage per
ON p.id_personnage = per.id_personnage
where b.nom_bataille like "Bataille du village gaulois"
GROUP BY b.nom_bataille;

--  penser a grouper par l'element d'interais 

-- 9)Nom des personnageset leur quantité de potion bue (en les classant du plus grand buveur au plus petit).
SELECT p.nom_personnage, b.dose_boire FROM `boire` b
JOIN personnage p
ON b.id_personnage = p.id_personnage
ORDER BY dose_boire DESC;
-- 10 Nom de la bataille où le nombre de casques pris a été le plus important
-- en travaille
SELECT b.nom_bataille,(p.qte) FROM `prendre_casque` p
JOIN bataille b
ON p.id_bataille = b.id_bataille
GROUP BY b.nom_bataille