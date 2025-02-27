create table arrets
(
    id         serial
        constraint arrets_pk
            primary key,
    id_station integer not null,
    id_ligne   integer not null
);

create table horraires
(
    id       serial
        constraint horraires_pk
            primary key,
    id_arret integer not null
        constraint horraires_arrets_id_fk
            references arrets,
    horaire  time    not null
);

create table tarifications
(
    id            serial
        constraint tarifications_pk
            primary key,
    nom           text    not null,
    zone_min      integer not null,
    zone_max      integer not null,
    prix_centimes integer not null
);

create table stations
(
    id   serial
        constraint stations_pk
            primary key,
    nom  varchar(255) not null,
    zone integer      not null
);

CREATE TYPE moyen_transport AS ENUM ('metro', 'rer');
create table lignes
(
    id           serial
        constraint lignes_pk
            primary key,
    nom          varchar(32)  not null,
    type         moyen_transport not null,
    capacite_max integer      not null
);

create table supports
(
    id          serial
        constraint supports_pk
            primary key,
    identifiant varchar(12) not null,
    date_achat  timestamp   not null
);

create table validations
(
    id                   serial
        constraint validations_pk
            primary key,
    id_support           integer   not null
        constraint validations_supports_id_fk
            references supports,
    id_station           integer   not null
        constraint validations_stations_id_fk
            references stations,
    date_heur_validation timestamp not null
);

create table adresses_client
(
    id          serial
        constraint adresses_client_pk
            primary key,
    ligne_1     text not null,
    ligne_2     text,
    ville       varchar(255),
    departement varchar(255),
    code_postal varchar(5),
    pays        varchar(255)
);

CREATE TYPE statut_dossier_client AS ENUM ('incomplet', 'validation', 'validé', 'rejeté');
create table dossiers_client
(
    id                     serial
        constraint dossiers_client_pk
            primary key,
    statut                 statut_dossier_client not null,
    prenoms                text         not null,
    nom_famille            text         not null,
    date_naissance         date         not null,
    id_adresse_residence   integer
        constraint dossiers_client_adresses_client_id_fk
            references adresses_client,
    id_adresse_facturation integer
        constraint dossiers_client_adresses_client_id_fk_2
            references adresses_client,
    email                  varchar(128),
    tel                    varchar(15),
    iban                   varchar(34),
    bic                    varchar(11),
    date_creation          timestamp    not null
);

create table abonnements
(
    id              serial
        constraint abonnements_pk
            primary key,
    id_support      integer   not null
        constraint abonnements_supports_id_fk
            references supports,
    id_dossier      integer   not null
        constraint abonnements_dossiers_client_id_fk
            references dossiers_client,
    id_tarification integer   not null
        constraint abonnements_tarifications_id_fk
            references tarifications,
    date_debut      timestamp not null,
    date_fin        timestamp not null
);

create table tickets
(
    id                     serial
        constraint tickets_pk
            primary key,
    id_support             integer   not null
        constraint tickets_supports_id_fk
            references supports,
    date_achat             timestamp not null,
    date_expiration        timestamp not null,
    prix_unitaire_centimes integer   not null,
    id_station             integer   not null
        constraint tickets_stations_id_fk
            references stations,
    date_heure_validation  timestamp
);
