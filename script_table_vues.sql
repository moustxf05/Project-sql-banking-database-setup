DROP TABLE IF EXISTS AGENT, CLIENT, COMPTE, COMPTE_CLIENT, MOUVEMENT, PARRAINAGE, TABLE_TEMPORAIRE CASCADE;
DROP VIEW IF EXISTS comptes_dormants, etat_parrainages CASCADE;

CREATE TABLE AGENT (
    matricule_agent INT PRIMARY KEY,
    nom_agent TEXT NOT NULL,
    ddn_agent DATE NOT NULL,
    civilite_agent CHAR(1) NOT NULL CHECK (civilite_agent IN ('M', 'F'))
);

CREATE TABLE CLIENT (
    id_client INT PRIMARY KEY,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    civilite CHAR(1) NOT NULL CHECK (civilite IN ('M', 'F')),
    ddn DATE NOT NULL,
    adresse TEXT NOT NULL,
    cp INT CHECK (cp BETWEEN 1000 AND 99999),
    ville TEXT NOT NULL,
    date_rattachement DATE,
    type_rattachement TEXT,
    matricule_agent INT REFERENCES AGENT(matricule_agent) ON DELETE SET NULL
);

CREATE TABLE COMPTE (
    numcpt BIGINT PRIMARY KEY,
    designation_compte TEXT NOT NULL
);

CREATE TABLE COMPTE_CLIENT (
    id_client INT REFERENCES CLIENT(id_client) ON DELETE CASCADE,
    numcpt BIGINT REFERENCES COMPTE(numcpt) ON DELETE CASCADE,
    PRIMARY KEY (id_client, numcpt)
);

CREATE TABLE MOUVEMENT (
    id_mouvement INT PRIMARY KEY,
    dt_mouvement DATE NOT NULL,
    montant FLOAT NOT NULL,
    designation_mouvement TEXT,
    numcpt BIGINT REFERENCES COMPTE(numcpt) ON DELETE CASCADE
);

CREATE TABLE PARRAINAGE (
    id_client_parrain INT REFERENCES CLIENT(id_client) ON DELETE CASCADE,
    id_client_filleul INT REFERENCES CLIENT(id_client) ON DELETE CASCADE,
    date_parrainage DATE NOT NULL,
    PRIMARY KEY (id_client_parrain, id_client_filleul),
    CHECK (id_client_parrain <> id_client_filleul)
);

CREATE TABLE TABLE_TEMPORAIRE (
    id_client INT,
    nom TEXT,
    prenom TEXT,
    civilite CHAR(1),
    ddn DATE,
    adresse TEXT,
    cp INT,
    ville TEXT,
    date_rattachement DATE,
    type_rattachement TEXT,
    numcpt BIGINT,
    designation_compte TEXT,
    id_mouvement INT,
    dt_mouvement DATE,
    montant FLOAT,
    designation_mouvement TEXT,
    parrain TEXT,
    date_parrainage DATE,
    matricule_agent INT,
    nom_agent TEXT,
    ddn_agent DATE,
    civilite_agent CHAR(1)
);
-- Vues pour le dirigeant

CREATE VIEW comptes_dormants AS
SELECT 
    c.nom AS nom_client,
    cp.numcpt,
    MAX(m.dt_mouvement) AS dernier_mouvement,
    SUM(m.montant) AS solde_estime
FROM 
    CLIENT c
JOIN 
    COMPTE_CLIENT p ON c.id_client = p.id_client
JOIN 
    COMPTE cp ON p.numcpt = cp.numcpt
LEFT JOIN 
    MOUVEMENT m ON cp.numcpt = m.numcpt
GROUP BY 
    c.nom, cp.numcpt
HAVING 
    MAX(m.dt_mouvement) < date_trunc('year', CURRENT_DATE);

CREATE VIEW etat_parrainages AS
SELECT 
    a.nom_agent AS nom_agent_filleul,
    parrain.nom AS nom_parrain,
    filleul.nom AS nom_filleul,
    p.date_parrainage,
    MIN(m.dt_mouvement) AS date_premier_mouvement_parrain
FROM 
    PARRAINAGE p
JOIN 
    CLIENT parrain ON p.id_client_parrain = parrain.id_client
JOIN 
    CLIENT filleul ON p.id_client_filleul = filleul.id_client
JOIN 
    AGENT a ON filleul.matricule_agent = a.matricule_agent
LEFT JOIN 
    MOUVEMENT m ON parrain.id_client = (
        SELECT pos.id_client
        FROM COMPTE_CLIENT pos
        WHERE pos.id_client = parrain.id_client
        LIMIT 1
    )
    AND m.dt_mouvement >= date_trunc('year', CURRENT_DATE)
WHERE 
    p.date_parrainage >= date_trunc('year', CURRENT_DATE)
GROUP BY 
    a.nom_agent, parrain.nom, filleul.nom, p.date_parrainage;
