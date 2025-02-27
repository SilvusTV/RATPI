ALTER TABLE arrets
    ADD CONSTRAINT arrets_stations_id_fk
        FOREIGN KEY (id_station) REFERENCES stations;

ALTER TABLE arrets
    ADD CONSTRAINT arrets_lignes_id_fk
        FOREIGN KEY (id_ligne) REFERENCES lignes;

ALTER TABLE horraires
    ADD CONSTRAINT horraires_arrets_id_fk
        FOREIGN KEY (id_arret) REFERENCES arrets;

ALTER TABLE validations
    ADD CONSTRAINT validations_supports_id_fk
        FOREIGN KEY (id_support) REFERENCES supports;

ALTER TABLE validations
    ADD CONSTRAINT validations_stations_id_fk
        FOREIGN KEY (id_station) REFERENCES stations;

ALTER TABLE dossiers_client
    ADD CONSTRAINT dossiers_client_adresses_client_id_fk
        FOREIGN KEY (id_adresse_residence) REFERENCES adresses_client;

ALTER TABLE dossiers_client
    ADD CONSTRAINT dossiers_client_adresses_client_id_fk_2
        FOREIGN KEY (id_adresse_facturation) REFERENCES adresses_client;

ALTER TABLE abonnements
    ADD CONSTRAINT abonnements_supports_id_fk
        FOREIGN KEY (id_support) REFERENCES supports;

ALTER TABLE abonnements
    ADD CONSTRAINT abonnements_dossiers_client_id_fk
        FOREIGN KEY (id_dossier) REFERENCES dossiers_client;

ALTER TABLE abonnements
    ADD CONSTRAINT abonnements_tarifications_id_fk
        FOREIGN KEY (id_tarification) REFERENCES tarifications;

ALTER TABLE tickets
    ADD CONSTRAINT tickets_supports_id_fk
        FOREIGN KEY (id_support) REFERENCES supports;

ALTER TABLE tickets
    ADD CONSTRAINT tickets_stations_id_fk
        FOREIGN KEY (id_station) REFERENCES stations;
