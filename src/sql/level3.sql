-- Niveau 3

-- Chiffre d'affaires des ventes de tickets par mois sur l'année 2024
SELECT TO_CHAR(date_achat, 'Month') AS mois, SUM(prix_unitaire_centimes) / 100 AS chiffre_affaires
FROM tickets
WHERE EXTRACT(YEAR FROM date_achat) = 2024
GROUP BY mois
ORDER BY MIN(date_achat);

-- Lignes de transport à Nation à 17:28:16 ± 4 minutes
SELECT lignes.nom AS ligne, horaires.horaire
FROM lignes
JOIN arrets ON lignes.id = arrets.id_ligne
JOIN stations ON arrets.id_station = stations.id
JOIN horaires ON arrets.id = horaires.id_arret
WHERE stations.nom = 'Nation'
AND horaires.horaire BETWEEN '17:24:16' AND '17:32:16'
ORDER BY horaires.horaire;

-- Nombre moyen de validation par mois par type d'abonnement
SELECT tarifications.nom AS abonnement, AVG(validations_par_mois.nb_validations) AS moy_validation
FROM (
    SELECT id_support, COUNT(id) AS nb_validations, DATE_TRUNC('month', date_heure_validation) AS mois
    FROM validations
    GROUP BY id_support, mois
) validations_par_mois
JOIN supports ON validations_par_mois.id_support = supports.id
JOIN abonnements ON supports.id = abonnements.id_support
JOIN tarifications ON abonnements.id_tarification = tarifications.id
GROUP BY tarifications.nom
ORDER BY moy_validation DESC, abonnement;

-- Vue : Moyenne des passages par jour de la semaine sur les 12 derniers mois
CREATE VIEW moy_passages_par_jour AS
SELECT TO_CHAR(date_heure_validation, 'Day') AS jour_semaine, 
       AVG(COUNT(*)) OVER(PARTITION BY TO_CHAR(date_heure_validation, 'Day')) AS moy_passagers
FROM validations
WHERE date_heure_validation >= CURRENT_DATE - INTERVAL '12 months'
GROUP BY jour_semaine
ORDER BY jour_semaine;

-- Vue : Taux de remplissage moyen des lignes
CREATE VIEW taux_remplissage AS
SELECT lignes.nom AS nom_ligne,
       (AVG(nb_passagers) / (capacite_max * nombre_trains)) * 100 AS taux_remplissage
FROM (
    SELECT lignes.id AS id_ligne, COUNT(validations.id) AS nb_passagers, capacite_max, 
           CASE WHEN lignes.type = 'metro' THEN 19*10 ELSE 19*4 END AS nombre_trains
    FROM lignes
    JOIN arrets ON lignes.id = arrets.id_ligne
    JOIN validations ON arrets.id_station = validations.id_station
    GROUP BY lignes.id, capacite_max, lignes.type
) remplissage
JOIN lignes ON remplissage.id_ligne = lignes.id
GROUP BY lignes.nom, capacite_max, nombre_trains
ORDER BY taux_remplissage DESC;