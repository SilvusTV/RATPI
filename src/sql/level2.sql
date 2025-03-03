-- Niveau 2

-- Stations doubles (desservies par au moins un métro et un RER)
SELECT DISTINCT stations.nom AS station
FROM stations
JOIN arrets ON stations.id = arrets.id_station
JOIN lignes ON arrets.id_ligne = lignes.id
WHERE lignes.type IN ('metro', 'rer')
GROUP BY stations.nom
HAVING COUNT(DISTINCT lignes.type) = 2
ORDER BY stations.nom;

-- Forfaits populaires (les 3 plus populaires)
SELECT tarifications.nom AS nom_forfait, COUNT(abonnements.id) AS nb_abonnements
FROM abonnements
JOIN tarifications ON abonnements.id_tarification = tarifications.id
GROUP BY tarifications.nom
ORDER BY nb_abonnements DESC
LIMIT 3;

-- Capacité moyenne de chaque station
SELECT stations.nom AS station, AVG(lignes.capacite_max) AS capacite_moy
FROM stations
JOIN arrets ON stations.id = arrets.id_station
JOIN lignes ON arrets.id_ligne = lignes.id
GROUP BY stations.nom
ORDER BY stations.nom;

-- Vue des abonnés par département
CREATE VIEW abonnes_par_departement AS
SELECT adresses_client.departement, adresses_client.code_postal, COUNT(dossiers_client.id) AS nb_abonnes
FROM dossiers_client
JOIN adresses_client ON dossiers_client.id_adresse_residence = adresses_client.id
GROUP BY adresses_client.departement, adresses_client.code_postal
ORDER BY adresses_client.code_postal;

-- Usagers par tranches d'âge
SELECT 
    SUM(CASE WHEN date_naissance > CURRENT_DATE - INTERVAL '18 years' THEN 1 ELSE 0 END) AS moins_18,
    SUM(CASE WHEN date_naissance BETWEEN CURRENT_DATE - INTERVAL '25 years' AND CURRENT_DATE - INTERVAL '18 years' THEN 1 ELSE 0 END) AS "18_24",
    SUM(CASE WHEN date_naissance BETWEEN CURRENT_DATE - INTERVAL '40 years' AND CURRENT_DATE - INTERVAL '25 years' THEN 1 ELSE 0 END) AS "25_40",
    SUM(CASE WHEN date_naissance BETWEEN CURRENT_DATE - INTERVAL '60 years' AND CURRENT_DATE - INTERVAL '40 years' THEN 1 ELSE 0 END) AS "40_60",
    SUM(CASE WHEN date_naissance < CURRENT_DATE - INTERVAL '60 years' THEN 1 ELSE 0 END) AS plus_60
FROM dossiers_client;
