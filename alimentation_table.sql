INSERT INTO AGENT (matricule_agent, nom_agent, ddn_agent, civilite_agent)
SELECT DISTINCT matricule_agent, nom_agent, ddn_agent, civilite_agent
FROM TABLE_TEMPORAIRE;

INSERT INTO CLIENT (id_client, nom, prenom, civilite, ddn, adresse, cp, ville, date_rattachement, type_rattachement, matricule_agent)
SELECT DISTINCT ON (id_client) id_client, nom, prenom, civilite, ddn, adresse, cp, ville, date_rattachement, type_rattachement, matricule_agent
FROM TABLE_TEMPORAIRE;

INSERT INTO COMPTE (numcpt, designation_compte)
SELECT DISTINCT numcpt, designation_compte
FROM TABLE_TEMPORAIRE;

INSERT INTO COMPTE_CLIENT (id_client, numcpt)
SELECT DISTINCT id_client, numcpt
FROM TABLE_TEMPORAIRE;

INSERT INTO MOUVEMENT (id_mouvement, dt_mouvement, montant, designation_mouvement, numcpt)
SELECT DISTINCT ON (id_mouvement) id_mouvement, dt_mouvement, montant, designation_mouvement, numcpt
FROM TABLE_TEMPORAIRE
WHERE id_mouvement IS NOT NULL;

INSERT INTO PARRAINAGE (id_client_parrain, id_client_filleul, date_parrainage)
SELECT 
    c_parrain.id_client AS id_client_parrain,
    tmp.id_client AS id_client_filleul,
    tmp.date_parrainage
FROM TABLE_TEMPORAIRE tmp
JOIN CLIENT c_parrain ON LOWER(c_parrain.nom) = LOWER(tmp.parrain)
WHERE tmp.parrain IS NOT NULL;
