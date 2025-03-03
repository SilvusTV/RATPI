-- Niveau 1

-- Nombre de dossiers incomplets
SELECT COUNT(*) AS nb_dossiers_incomplets
FROM dossiers_client
WHERE statut = 'incomplet';

-- Stations desservies par chaque ligne
SELECT lignes.nom AS ligne, stations.nom AS station
FROM lignes
JOIN arrets ON lignes.id = arrets.id_ligne
JOIN stations ON arrets.id_station = stations.id
ORDER BY lignes.nom, stations.nom;

-- Nombre de stations par moyen de transport
SELECT lignes.type AS moyen_transport, COUNT(DISTINCT arrets.id_station) AS nb_stations
FROM lignes
JOIN arrets ON lignes.id = arrets.id_ligne
GROUP BY lignes.type
ORDER BY nb_stations DESC;

-- Abonnements expirant à la fin de janvier 2025
SELECT tarifications.nom AS nom_tarification, COUNT(abonnements.id) AS nb_abonnements
FROM abonnements
JOIN tarifications ON abonnements.id_tarification = tarifications.id
WHERE abonnements.date_fin BETWEEN '2025-01-01' AND '2025-01-31'
GROUP BY tarifications.nom
ORDER BY nb_abonnements ASC;

-- Vue des dossiers en validation
CREATE VIEW dossiers_en_validation AS
SELECT * FROM dossiers_client
WHERE statut = 'validation'
ORDER BY date_creation ASC;