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
SELECT p.nom_potion, sum(c.qte* i.cout_ingredient) as prix FROM `composer` c
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
-- v2============================================================================================================================================
SELECT per.nom_personnage,
SUM(p.qte) AS total_casque
FROM prendre_casque p
INNER JOIN personnage per
ON  p.id_personnage =per.id_personnage
INNER JOIN bataille b 
ON b.id_bataille = p.id_bataille
WHERE b.nom_bataille = "Bataille du village gaulois"
GROUP BY per.id_personnage
HAVING total_casque >= ALL
(SELECT MAX(p.qte) AS total_casque_maximum 
FROM prendre_casque p
JOIN bataille b ON b.id_bataille = p.id_bataille
WHERE b.nom_bataille = "Bataille du village gaulois"
GROUP BY id_personnage)
ORDER BY total_casque DESC;
--  penser a grouper par l'element d'interais 

-- 9)Nom des personnageset leur quantité de potion bue (en les classant du plus grand buveur au plus petit).
SELECT p.nom_personnage, b.dose_boire FROM `boire` b
JOIN personnage p
ON b.id_personnage = p.id_personnage
ORDER BY dose_boire DESC;
-- 10 Nom de la bataille où le nombre de casques pris a été le plus important
-- en travaille
CREATE OR REPLACE VIEW  sommebattaille AS
SELECT b.nom_bataille,SUM(p.qte) as somme FROM `prendre_casque` p
JOIN bataille b
ON p.id_bataille = b.id_bataille
GROUP BY b.nom_bataille

-- etape 2
SELECT nom_bataille , MAX(somme) FROM `sommebattaille`;
-- 10) Combien  existe-t-il  de  casques  de  chaque  type  et  quel  est  leur  coût  total  ?  (classés  par nombre décroissant)
SELECT c.nom_casque, sum(c.cout_casque) as somme FROM `type_casque` ct
JOIN casque c
ON c.id_type_casque= ct.id_type_casque
GROUP BY ct.nom_type_casque
ORDER BY somme DESC;
-- 12) Nom des potions dont un des ingrédients est le poisson frais.
SELECT p.nom_potion, i.nom_ingredient FROM `composer` c
INNER JOIN potion p 
ON p.id_potion= c.id_potion
JOIN ingredient i
ON i.id_ingredient = c.id_ingredient
WHERE i.nom_ingredient LIKE "Poisson frais"
-- 13) Nom du / des lieu(x) possédant le plus d'habitants, en dehors du village gaulois.
SELECT nbr_habitant,  nom_lieu
from nbr_habitant_par_lieu
where nbr_habitant =(SELECT MAX(nbr_habitant) as nombre_max  FROM `nbr_habitant_par_lieu` where `nom_lieu` !='Village gaulois');
-- 14)Nom despersonnagesqui n'ont jamais bu aucunepotion.
SELECT P.nom_personnage, B.dose_boire FROM `personnage` P
LEFT JOIN boire b
ON P.id_personnage = b.id_personnage
WHERE b.dose_boire IS NULL
-- 15)Nom du / des personnagesqui n'ont pas le droit de boire de la potion 'Magique'.
SELECT personnage.nom_personnage, potion.nom_potion FROM `personnage`
LEFT JOIN autoriser_boire 
ON personnage.id_personnage = autoriser_boire.id_personnage
LEFT JOIN potion
on potion.id_potion = autoriser_boire.id_potion
WHERE potion.nom_potion NOT LIKE "Magique";
-- a)
INSERT INTO `personnage` (`id_personnage`, `nom_personnage`, `adresse_personnage`, `image_personnage`, `id_lieu`, `id_specialite`) 
VALUES (NULL, 'Champdeblix', '???', 'indisponible.jpg', '1', '17');
-- b)
INSERT INTO `autoriser_boire` (`id_potion`, `id_personnage`) VALUES ('1', '12')
--  déjas fait 
-- C)
DELETE FROM `casque` WHERE `casque`.`id_casque` = 20;
DELETE FROM `casque` WHERE `casque`.`id_casque` = 21;
DELETE FROM `casque` WHERE `casque`.`id_casque` = 22;
DELETE FROM `casque` WHERE `casque`.`id_casque` = 23;

-- D)
UPDATE `personnage` SET `adresse_personnage` = 'prison', `id_lieu` = '9' WHERE `personnage`.`id_personnage` = 23;
-- E)
DELETE FROM `composer` WHERE `composer`.`id_potion` = 19;
-- f)
UPDATE `prendre_casque` SET `id_casque` = '10', `qte` = '42' 
WHERE `prendre_casque`.`id_casque` = 14 
AND `prendre_casque`.`id_personnage` = 5 
AND `prendre_casque`.`id_bataille` = 9