-- Niveau 4

-- parts des passagers ayant un abonnement, contre ceux voyageant avec des tickets (supports)
SELECT
    ROUND((COUNT(DISTINCT a.id_support) * 100.0 / NULLIF(COUNT(DISTINCT s.id), 0)), 2) AS part_abonnement,
    ROUND((COUNT(DISTINCT t.id_support) * 100.0 / NULLIF(COUNT(DISTINCT s.id), 0)), 2) AS part_ticket
FROM
    supports s
        LEFT JOIN
    abonnements a ON s.id = a.id_support
        LEFT JOIN
    tickets t ON s.id = t.id_support
;

-- nombre de nouveaux abonnements par mois en 2024
SELECT
    DATE_TRUNC('month', a.date_creation) AS mois,
    COUNT(a.id) AS nb_nvx_abo
FROM
    abonnements a
WHERE
    a.date_creation BETWEEN '2024-01-01' AND '2024-12-31'
    AND NOT EXISTS (
        SELECT 1
        FROM abonnements a2
        WHERE a2.id_support = a.id_support
        AND a2.date_creation < '2024-01-01'
    )
GROUP BY
    DATE_TRUNC('month', a.date_creation)
ORDER BY
    mois
;

-- montant total économisé par les usagers ayant un abonnement s'ils avaient dû acheter un ticket
SELECT
    SUM(GREATEST(0, (a.nb_voyages * t.prix) - a.prix)) AS montant_economise_euros
FROM
    abonnements a
JOIN
    tickets t ON a.id_support = t.id_support
WHERE
    a.date_creation BETWEEN '2024-01-01' AND '2024-12-31'
;

-- heure la plus affluante par station
CREATE VIEW heure_affluante_par_station AS
SELECT stations.nom AS nom_station,
       DATE_TRUNC('hour', validations.date_heure_validation) AS heure_affluante,
       COUNT(validations.id) AS nb_validations
FROM stations
JOIN validations ON stations.id = validations.id_station
GROUP BY stations.nom, heure_affluante
ORDER BY nb_validations DESC
;

-- nombre d'abonnements actifs par tranche de zone
CREATE VIEW abonnements_par_zone AS
SELECT
    a.zone_min,
    a.zone_max,
    COUNT(a.id) AS nb_abonnements
FROM abonnements a
WHERE a.date_expiration > CURRENT_DATE
GROUP BY a.zone_min, a.zone_max
ORDER BY nb_abonnements DESC, a.zone_min, a.zone_max
;