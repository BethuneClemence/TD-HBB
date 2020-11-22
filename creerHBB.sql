-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                           PostgreSQL
--                        (21/11/2020 18:05:22)
-- -----------------------------------------------------------------------------
--      Nom de la base : MLR3
--      Projet : 
--      Auteur : LLA
--      Date de dernière modification : 21/11/2020 18:05:12
-- -----------------------------------------------------------------------------

drop database MLR3;
-- -----------------------------------------------------------------------------
--       CREATION DE LA BASE 
-- -----------------------------------------------------------------------------

CREATE DATABASE MLR3;

-- -----------------------------------------------------------------------------
--       TABLE : PROGRAMMER
-- -----------------------------------------------------------------------------

CREATE TABLE PROGRAMMER
   (
    IDOPERATION int4 NOT NULL  ,
    ETAT varchar(2) NULL  ,
    IDOPERATIONPROG char(32) NOT NULL  
,   CONSTRAINT PK_PROGRAMMER PRIMARY KEY (IDOPERATIONPROG)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PROGRAMMER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PROGRAMMER_OPERATION
     ON PROGRAMMER (IDOPERATION)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : OPERATION
-- -----------------------------------------------------------------------------

CREATE TABLE OPERATION
   (
    IDOPERATION int4 NOT NULL  ,
    NUMCOMPTE int4 NOT NULL  ,
    DATE date NOT NULL  ,
    NUMCOMPTE_VERS int4 NULL  ,
    DESIGNATION varchar(128) NULL  ,
    TYPEOPERATION char(100) NULL  ,
    MONTANT float4 NULL  
,   CONSTRAINT PK_OPERATION PRIMARY KEY (IDOPERATION)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE OPERATION
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_OPERATION_COMPTE
     ON OPERATION (NUMCOMPTE)
    ;

CREATE  INDEX I_FK_OPERATION_DATE
     ON OPERATION (DATE)
    ;

CREATE  INDEX I_FK_OPERATION_COMPTE1
     ON OPERATION (NUMCOMPTE_VERS)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : DATE
-- -----------------------------------------------------------------------------

CREATE TABLE DATE
   (
    DATE date NOT NULL  
,   CONSTRAINT PK_DATE PRIMARY KEY (DATE)
   );

-- -----------------------------------------------------------------------------
--       TABLE : CONSEILLER
-- -----------------------------------------------------------------------------

CREATE TABLE CONSEILLER
   (
    IDCONSEILLER int4 NOT NULL  ,
    NOM varchar(128) NULL  ,
    PRENOM varchar(128) NULL  ,
    DATEEMBAUCHE date NULL  
,   CONSTRAINT PK_CONSEILLER PRIMARY KEY (IDCONSEILLER)
   );

-- -----------------------------------------------------------------------------
--       TABLE : TYPECOMPTE
-- -----------------------------------------------------------------------------

CREATE TABLE TYPECOMPTE
   (
    IDTYPE int4 NOT NULL  ,
    DESIGNATION varchar(128) NULL  
,   CONSTRAINT PK_TYPECOMPTE PRIMARY KEY (IDTYPE)
   );

-- -----------------------------------------------------------------------------
--       TABLE : CLIENT
-- -----------------------------------------------------------------------------

CREATE TABLE CLIENT
   (
    NUMCLIENT int4 NOT NULL  ,
    NOMCLIENT varchar(128) NULL  ,
    PRENOMCLIENT char(32) NULL  ,
    ADRESSECLIENT char(132) NULL  ,
    IDENTIFIANTINTERNET char(32) NULL  ,
    MDPINTERNET char(32) NULL  
,   CONSTRAINT PK_CLIENT PRIMARY KEY (NUMCLIENT)
   );

-- -----------------------------------------------------------------------------
--       TABLE : COMPTE
-- -----------------------------------------------------------------------------

CREATE TABLE COMPTE
   (
    NUMCOMPTE int4 NOT NULL  ,
    DATE date NULL  ,
    IDTYPE int4 NOT NULL  ,
    DATE_OUVRIR date NOT NULL  ,
    SOLDE float4 NULL  
,   CONSTRAINT PK_COMPTE PRIMARY KEY (NUMCOMPTE)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COMPTE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COMPTE_DATE
     ON COMPTE (DATE)
    ;

CREATE  INDEX I_FK_COMPTE_TYPECOMPTE
     ON COMPTE (IDTYPE)
    ;

CREATE  INDEX I_FK_COMPTE_DATE1
     ON COMPTE (DATE_OUVRIR)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : AGENCE
-- -----------------------------------------------------------------------------

CREATE TABLE AGENCE
   (
    NUMAGENCE int4 NOT NULL  ,
    NOMAGENCE varchar(32) NULL  ,
    ADRESSEAGENCE char(132) NULL  ,
    TELAGENCE char(12) NULL  
,   CONSTRAINT PK_AGENCE PRIMARY KEY (NUMAGENCE)
   );

-- -----------------------------------------------------------------------------
--       TABLE : DEPENDRE
-- -----------------------------------------------------------------------------

CREATE TABLE DEPENDRE
   (
    NUMAGENCE int4 NOT NULL  ,
    NUMCLIENT int4 NOT NULL  ,
    DATE date NULL  
,   CONSTRAINT PK_DEPENDRE PRIMARY KEY (NUMAGENCE, NUMCLIENT)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE DEPENDRE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_DEPENDRE_AGENCE
     ON DEPENDRE (NUMAGENCE)
    ;

CREATE  INDEX I_FK_DEPENDRE_CLIENT
     ON DEPENDRE (NUMCLIENT)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : EFFECTUER
-- -----------------------------------------------------------------------------

CREATE TABLE EFFECTUER
   (
    IDCONSEILLER int4 NOT NULL  ,
    NUMCLIENT int4 NOT NULL  ,
    DATE date NOT NULL  ,
    HEUREAPPEL time NULL  ,
    TEMPSCOMMUNICATION char(32) NULL  
,   CONSTRAINT PK_EFFECTUER PRIMARY KEY (IDCONSEILLER, NUMCLIENT, DATE)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE EFFECTUER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_EFFECTUER_CONSEILLER
     ON EFFECTUER (IDCONSEILLER)
    ;

CREATE  INDEX I_FK_EFFECTUER_CLIENT
     ON EFFECTUER (NUMCLIENT)
    ;

CREATE  INDEX I_FK_EFFECTUER_DATE
     ON EFFECTUER (DATE)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : POSSEDER
-- -----------------------------------------------------------------------------

CREATE TABLE POSSEDER
   (
    NUMCLIENT int4 NOT NULL  ,
    NUMCOMPTE int4 NOT NULL  
,   CONSTRAINT PK_POSSEDER PRIMARY KEY (NUMCLIENT, NUMCOMPTE)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE POSSEDER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_POSSEDER_CLIENT
     ON POSSEDER (NUMCLIENT)
    ;

CREATE  INDEX I_FK_POSSEDER_COMPTE
     ON POSSEDER (NUMCOMPTE)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : REMUNIRER
-- -----------------------------------------------------------------------------

CREATE TABLE REMUNIRER
   (
    IDTYPE int4 NOT NULL  ,
    DATE date NOT NULL  ,
    DATE_1 date NOT NULL  ,
    DATE_DE date NOT NULL  ,
    DATE_A date NOT NULL  ,
    TAUXINTERET float4 NULL  
,   CONSTRAINT PK_REMUNIRER PRIMARY KEY (IDTYPE, DATE, DATE_1, DATE_DE, DATE_A)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE REMUNIRER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_REMUNIRER_TYPECOMPTE
     ON REMUNIRER (IDTYPE)
    ;

CREATE  INDEX I_FK_REMUNIRER_DATE
     ON REMUNIRER (DATE)
    ;

CREATE  INDEX I_FK_REMUNIRER_DATE1
     ON REMUNIRER (DATE_1)
    ;

CREATE  INDEX I_FK_REMUNIRER_DATE2
     ON REMUNIRER (DATE_DE)
    ;

CREATE  INDEX I_FK_REMUNIRER_DATE3
     ON REMUNIRER (DATE_A)
    ;


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE PROGRAMMER ADD 
     CONSTRAINT FK_PROGRAMMER_OPERATION
          FOREIGN KEY (IDOPERATION)
               REFERENCES OPERATION (IDOPERATION);

ALTER TABLE OPERATION ADD 
     CONSTRAINT FK_OPERATION_COMPTE
          FOREIGN KEY (NUMCOMPTE)
               REFERENCES COMPTE (NUMCOMPTE);

ALTER TABLE OPERATION ADD 
     CONSTRAINT FK_OPERATION_DATE
          FOREIGN KEY (DATE)
               REFERENCES DATE (DATE);

ALTER TABLE OPERATION ADD 
     CONSTRAINT FK_OPERATION_COMPTE1
          FOREIGN KEY (NUMCOMPTE_VERS)
               REFERENCES COMPTE (NUMCOMPTE);

ALTER TABLE COMPTE ADD 
     CONSTRAINT FK_COMPTE_DATE
          FOREIGN KEY (DATE)
               REFERENCES DATE (DATE);

ALTER TABLE COMPTE ADD 
     CONSTRAINT FK_COMPTE_TYPECOMPTE
          FOREIGN KEY (IDTYPE)
               REFERENCES TYPECOMPTE (IDTYPE);

ALTER TABLE COMPTE ADD 
     CONSTRAINT FK_COMPTE_DATE1
          FOREIGN KEY (DATE_OUVRIR)
               REFERENCES DATE (DATE);

ALTER TABLE DEPENDRE ADD 
     CONSTRAINT FK_DEPENDRE_AGENCE
          FOREIGN KEY (NUMAGENCE)
               REFERENCES AGENCE (NUMAGENCE);

ALTER TABLE DEPENDRE ADD 
     CONSTRAINT FK_DEPENDRE_CLIENT
          FOREIGN KEY (NUMCLIENT)
               REFERENCES CLIENT (NUMCLIENT);

ALTER TABLE EFFECTUER ADD 
     CONSTRAINT FK_EFFECTUER_CONSEILLER
          FOREIGN KEY (IDCONSEILLER)
               REFERENCES CONSEILLER (IDCONSEILLER);

ALTER TABLE EFFECTUER ADD 
     CONSTRAINT FK_EFFECTUER_CLIENT
          FOREIGN KEY (NUMCLIENT)
               REFERENCES CLIENT (NUMCLIENT);

ALTER TABLE EFFECTUER ADD 
     CONSTRAINT FK_EFFECTUER_DATE
          FOREIGN KEY (DATE)
               REFERENCES DATE (DATE);

ALTER TABLE POSSEDER ADD 
     CONSTRAINT FK_POSSEDER_CLIENT
          FOREIGN KEY (NUMCLIENT)
               REFERENCES CLIENT (NUMCLIENT);

ALTER TABLE POSSEDER ADD 
     CONSTRAINT FK_POSSEDER_COMPTE
          FOREIGN KEY (NUMCOMPTE)
               REFERENCES COMPTE (NUMCOMPTE);

ALTER TABLE REMUNIRER ADD 
     CONSTRAINT FK_REMUNIRER_TYPECOMPTE
          FOREIGN KEY (IDTYPE)
               REFERENCES TYPECOMPTE (IDTYPE);

ALTER TABLE REMUNIRER ADD 
     CONSTRAINT FK_REMUNIRER_DATE
          FOREIGN KEY (DATE)
               REFERENCES DATE (DATE);

ALTER TABLE REMUNIRER ADD 
     CONSTRAINT FK_REMUNIRER_DATE1
          FOREIGN KEY (DATE_1)
               REFERENCES DATE (DATE);

ALTER TABLE REMUNIRER ADD 
     CONSTRAINT FK_REMUNIRER_DATE2
          FOREIGN KEY (DATE_DE)
               REFERENCES DATE (DATE);

ALTER TABLE REMUNIRER ADD 
     CONSTRAINT FK_REMUNIRER_DATE3
          FOREIGN KEY (DATE_A)
               REFERENCES DATE (DATE);


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------