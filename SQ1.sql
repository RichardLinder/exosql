-- Affichez les résultats suivants avec une solution SQL
--  :a)Quel est le nombre total d'étudiants ?
--  b)Quelles sont, parmi l'ensemble des notes, la note la plus haute et la note la plus basse ?
--  c)Quelles  sont  les  moyennes  de  chaque  étudiant  dans  chacune  des  matières  ?(utilisez CREATE VIEW)
--  d) Quelles sont les moyennes par matière ?(cf. question c)
--  e)Quelle est la moyenne générale de chaque étudiant ?(utilisez CREATE VIEW + cf. question 3)
--  f)Quelle est la moyenne générale de la promotion ?(cf. question e)
--  g)Quels sont les étudiants quiont une moyenne générale supérieure ou égale à la moyenne générale de la promotion ?
--  (cf. question e)


-- a)
SELECT COUNT(*) FROM `etudiant`; 

-- b)
SELECT MIN( `note`) as minsal FROM `evaluer`; 
SELECT max( `note`) as maxeval FROM `evaluer`; 

-- C)
CREATE OR REPLACE VIEW moyennesEtudiant AS
SELECT etudiant.nom,
etudiant.prenoms,
matiere.libellemat,
matiere.coeffmat,
AVG(evaluer.note ) AS moyennesMatier
FROM etudiant, evaluer, matiere
WHERE etudiant.n_etudiant = evaluer.n_etudiant AND matiere.codemat = evaluer.codemat
GROUP BY etudiant.n_etudiant, etudiant.nom, etudiant.prenoms, matiere.libellemat, matiere.coeffmat;
-- d)
CREATE OR REPLACE VIEW  moyenparmatier as
SELECT libellemat,coeffmat ,AVG (moyennesMatier) as moyengeneralbymatier 
FROM `moyennesetudiant`GROUP BY libellemat;
-- e)
CREATE OR REPLACE VIEW  moyenParEtudiant as
SELECT nom, prenoms, coeffmat , AVG(moyennesMatier) AS moyengeneralbymatieretudiant
FROM `moyennesetudiant`GROUP BY nom;

-- f
CREATE OR REPLACE VIEW moyengeneral AS
SELECT  (coeffmat* moyengeneralbymatier)/
(SUM(coeffmat) )  as ME FROM `moyenparmatier`

-- g)en cour

CREATE OR REPLACE VIEW moyengeneraletudiant AS
SELECT (coeffmat* moyengeneralbymatieretudiant)/
(SUM(coeffmat) ) as mge   FROM `moyenparetudiant`
SELECT e.nom , e.prenoms, (g.ME - e.moyengeneralbymatieretudiant) AS differenceAvecLaMoyen FROM `moyengeneral` g , moyenParEtudiant e;



-- exercice 3

-- basse de donné export de phpmyadmin
{
-- phpMyAdmin SQL Dump
   -- version 5.2.0
   -- https://www.phpmyadmin.net/
   --
   -- Hôte : 127.0.0.1
   -- Généré le : ven. 26 mai 2023 à 09:09
   -- Version du serveur : 10.4.27-MariaDB
   -- Version de PHP : 8.2.0

   SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
   START TRANSACTION;
   SET time_zone = "+00:00";


   /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
   /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
   /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
   /*!40101 SET NAMES utf8mb4 */;

   --
   -- Base de données : `marcher`
   --

   -- --------------------------------------------------------

   --
   -- Structure de la table `achetez`
   --

   CREATE TABLE `achetez` (
   `noArt` int(11) NOT NULL,
   `noFourn` int(11) NOT NULL,
   `delai` int(11) DEFAULT NULL,
   `prixAchat` decimal(15,2) DEFAULT NULL
   ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

   -- --------------------------------------------------------

   --
   -- Structure de la table `article`
   --

   CREATE TABLE `article` (
   `noArt` int(11) NOT NULL,
   `libelle` varchar(50) DEFAULT NULL,
   `stock` int(11) DEFAULT NULL,
   `prixPrinvent` decimal(15,2) DEFAULT NULL
   ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

   -- --------------------------------------------------------

   --
   -- Structure de la table `fourniseurs`
   --

   CREATE TABLE `fourniseurs` (
   `noFourn` int(11) NOT NULL,
   `nomFourn` varchar(50) DEFAULT NULL,
   `villeFourn` varchar(50) DEFAULT NULL,
   `adressFourn` varchar(50) DEFAULT NULL
   ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

   --
   -- Index pour les tables déchargées
   --

   --
   -- Index pour la table `achetez`
   --
   ALTER TABLE `achetez`
   ADD PRIMARY KEY (`noArt`,`noFourn`),
   ADD KEY `noFourn` (`noFourn`);

   --
   -- Index pour la table `article`
   --
   ALTER TABLE `article`
   ADD PRIMARY KEY (`noArt`);

   --
   -- Index pour la table `fourniseurs`
   --
   ALTER TABLE `fourniseurs`
   ADD PRIMARY KEY (`noFourn`);

   --
   -- AUTO_INCREMENT pour les tables déchargées
   --

   --
   -- AUTO_INCREMENT pour la table `article`
   --
   ALTER TABLE `article`
   MODIFY `noArt` int(11) NOT NULL AUTO_INCREMENT;

   --
   -- AUTO_INCREMENT pour la table `fourniseurs`
   --
   ALTER TABLE `fourniseurs`
   MODIFY `noFourn` int(11) NOT NULL AUTO_INCREMENT;

   --
   -- Contraintes pour les tables déchargées
   --

   --
   -- Contraintes pour la table `achetez`
   --
   ALTER TABLE `achetez`
   ADD CONSTRAINT `achetez_ibfk_1` FOREIGN KEY (`noArt`) REFERENCES `article` (`noArt`),
   ADD CONSTRAINT `achetez_ibfk_2` FOREIGN KEY (`noFourn`) REFERENCES `fourniseurs` (`noFourn`);
   COMMIT;

   /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
   /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
   /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
}

-- a)Numéros et libellés des articles dont le stock est inférieur à 10 ?
-- b)Liste des articles dont le prix d'inventaire est compris entre 100 et 300 ?
-- c)Liste des fournisseurs dont on ne connaît pas l'adresse ?
-- d)Liste des fournisseurs dont le nom commence par "STE" ?
-- e)Noms  et  adresses  des  fournisseurs  qui  proposent  des  articles  pour  lesquels  le  délai d'approvisionnement est supérieur à 20 jours ?
-- f)Nombre d'articles référencés ?
-- g)Valeur du stock ?
-- h)Numéros et libellés des articles triés dans l'ordre décroissant des stocks ?
-- i)Liste pour chaque article (numéro et libellé) du prix d'achat maximum, minimum et moyen ?
-- j)Délai moyen pour chaque fournisseur proposant au moins 2 articles ?

-- a)
SELECT noArt, libelle FROM `article` WHERE `stock` < 10
-- b)
SELECT noArt , libelle ,stock , prixPrinvent  FROM `article` WHERE `stock` BETWEEN 100 AND 300
-- c)
SELECT noFourn, nomFourn FROM `fourniseurs` WHERE adressFourn="";
-- d)
SELECT noFourn, nomFourn FROM `fourniseurs` WHERE `nomFourn` LIKE '%ste%'
-- e)
SELECT `achetez`.`delai`, `fourniseurs`.`adressFourn` , fourniseurs.nomFourn
FROM `achetez` 
	LEFT JOIN `fourniseurs` ON `achetez`.`noFourn` = `fourniseurs`.`noFourn`
WHERE `achetez`.`delai` > 'delay <20';
-- f)
SELECT COUNT(noArt) FROM `article`;
-- g)
SELECT stock *  prixPrinvent as valeurtotal FROM `article` 
-- h)
SELECT noArt, libelle, stock FROM `article` ORDER BY stock DESC;
-- i)
SELECT 
    article.noart,
   article.libelle,
    MIN(achetez.prixAchat) AS prixMin, 
    MAX(achetez.prixAchat) AS prixMax,
    AVG(achetez.prixAchat) AS prixMoyen
FROM
    article
INNER JOIN achetez  ON article.noArt = achetez.noArt
GROUP BY  article.libelle ,article.noArt

-- j)
CREATE OR REPLACE VIEW nbrArt AS 

SELECT COUNT(noArt) AS nbrart, noFourn 
FROM achetez
GROUP BY noFourn

SELECT a.noFourn, AVG(a.delai) AS delai_moy
FROM achetez a, nbrart n
WHERE n.nbrart >= 2
AND n.noFourn = a.noFourn
GROUP BY a.noFourn


