create table arrets
(
    id         SERIAL
        constraint arrets_pk
            primary key,
    id_station integer not null,
    id_ligne   integer not null
);
create table horraires
(
    id       SERIAL
        constraint horraires_pk
            primary key,
    id_arret integer not null
        constraint horraires_arrets_id_fk
            references arrets (id),
    horaire  time    not null
);
create table tarifications
(
    id            SERIAL
        constraint tarifications_pk
            primary key,
    nom           text    not null,
    zone_min      integer not null,
    zone_max      integer not null,
    prix_centimes integer not null
);
create table validations
(
    id                   SERIAL
        constraint validations_pk
            primary key,
    id_support           integer   not null,
    id_station           integer   not null,
    date_heur_validation timestamp not null
);
CREATE TABLE stations (
                          id SERIAL,
                          nom VARCHAR(255) NOT NULL,
                          zone INT NOT NULL
);

CREATE TABLE lignes (
                        id SERIAL,
                        nom VARCHAR(32) NOT NULL,
                        type VARCHAR(255) NOT NULL,
                        capacite_max INT NOT NULL
);

CREATE TABLE supports (
                          id SERIAL,
                          identifiant VARCHAR(12) NOT NULL,
                          date_achat TIMESTAMP NOT NULL
);

CREATE TABLE adresses_client (
                                 id SERIAL,
                                 ligne_1 TEXT NOT NULL,
                                 ligne_2 TEXT,
                                 ville VARCHAR(255),
                                 departement VARCHAR(255),
                                 code_postal VARCHAR(5),
                                 pays VARCHAR(255)
);

CREATE TABLE abonnements (
                             id SERIAL,
                             id_support INT NOT NULL,
                             id_dossier INT NOT NULL,
                             id_tarification INT NOT NULL,
                             date_debut TIMESTAMP NOT NULL,
                             date_fin TIMESTAMP NOT NULL
);

CREATE TABLE tickets (
                         id SERIAL,
                         id_support INT NOT NULL,
                         date_achat TIMESTAMP NOT NULL,
                         date_expiration TIMESTAMP NOT NULL,
                         prix_unitaire_centimes INT NOT NULL,
                         id_station INT NOT NULL,
                         date_heure_validation TIMESTAMP
);

CREATE TABLE dossiers_client (
                                 id SERIAL,
                                 statut VARCHAR(255) NOT NULL,
                                 prenoms TEXT NOT NULL,
                                 nom_famille TEXT NOT NULL,
                                 date_naissance DATE NOT NULL,
                                 id_adresse_residence INT,
                                 id_adresse_facturation INT,
                                 email VARCHAR(128),
                                 tel VARCHAR(15),
                                 iban VARCHAR(34),
                                 bic VARCHAR(11),
                                 date_creation TIMESTAMP NOT NULL
);