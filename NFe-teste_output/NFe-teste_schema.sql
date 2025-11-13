-- SQL Schema automatically generated from XML
-- Generic XML to SQL converter

CREATE SEQUENCE hibernate_sequence START 1 INCREMENT 1;

CREATE TABLE envinfe (
    id_envinfe BIGINT PRIMARY KEY,
    versao SMALLINT,
    idlote BOOLEAN,
    indsinc BOOLEAN
);

CREATE TABLE infnfe (
    id_infnfe BIGINT PRIMARY KEY,
    versao SMALLINT,
    id VARCHAR(50),
    cnpj NUMERIC(20,0),
    modfrete SMALLINT
);

CREATE TABLE ide (
    id_ide BIGINT PRIMARY KEY,
    cuf SMALLINT,
    cnf SMALLINT,
    natop VARCHAR(50),
    mod SMALLINT,
    serie BOOLEAN,
    nnf BOOLEAN,
    dhemi TIMESTAMP,
    tpnf BOOLEAN,
    iddest BOOLEAN,
    cmunfg BIGINT,
    tpimp BOOLEAN,
    tpemis BOOLEAN,
    cdv BOOLEAN,
    tpamb SMALLINT,
    finnfe BOOLEAN,
    indfinal BOOLEAN,
    indpres BOOLEAN,
    procemi BOOLEAN,
    verproc SMALLINT
);

CREATE TABLE emit (
    id_emit BIGINT PRIMARY KEY,
    cnpj NUMERIC(20,0),
    xnome VARCHAR(50),
    ie BIGINT,
    crt SMALLINT
);

CREATE TABLE enderemit (
    id_enderemit BIGINT PRIMARY KEY,
    xlgr VARCHAR(50),
    nro BOOLEAN,
    xcpl VARCHAR(50),
    xbairro VARCHAR(10),
    cmun BIGINT,
    xmun VARCHAR(50),
    uf VARCHAR(10),
    cep BIGINT,
    cpais INTEGER,
    xpais VARCHAR(10),
    fone NUMERIC(20,0)
);

CREATE TABLE dest (
    id_dest BIGINT PRIMARY KEY,
    cnpj NUMERIC(20,0),
    xnome VARCHAR(100),
    indiedest SMALLINT,
    email VARCHAR(20)
);

CREATE TABLE enderdest (
    id_enderdest BIGINT PRIMARY KEY,
    xlgr VARCHAR(50),
    nro BOOLEAN,
    xbairro VARCHAR(10),
    cmun BIGINT,
    xmun VARCHAR(10),
    uf VARCHAR(10),
    cep BIGINT,
    cpais INTEGER,
    xpais VARCHAR(10),
    fone NUMERIC(20,0)
);

CREATE TABLE prod (
    id_prod BIGINT PRIMARY KEY,
    cprod NUMERIC(20,0),
    cean NUMERIC(20,0),
    xprod VARCHAR(100),
    ncm BIGINT,
    cest BIGINT,
    indescala VARCHAR(10),
    cfop INTEGER,
    ucom VARCHAR(10),
    qcom SMALLINT,
    vuncom SMALLINT,
    vprod SMALLINT,
    ceantrib NUMERIC(20,0),
    utrib VARCHAR(10),
    qtrib SMALLINT,
    vuntrib SMALLINT,
    indtot BOOLEAN
);

CREATE TABLE icms00 (
    id_icms00 BIGINT PRIMARY KEY,
    orig BOOLEAN,
    cst SMALLINT,
    modbc BOOLEAN,
    vbc SMALLINT,
    picms SMALLINT,
    vicms DECIMAL(15,2)
);

CREATE TABLE pisaliq (
    id_pisaliq BIGINT PRIMARY KEY,
    cst SMALLINT,
    vbc SMALLINT,
    ppis DECIMAL(15,2),
    vpis DECIMAL(15,2)
);

CREATE TABLE cofinsaliq (
    id_cofinsaliq BIGINT PRIMARY KEY,
    cst SMALLINT,
    vbc SMALLINT,
    pcofins DECIMAL(15,2),
    vcofins DECIMAL(15,2)
);

CREATE TABLE icmstot (
    id_icmstot BIGINT PRIMARY KEY,
    vbc SMALLINT,
    vicms DECIMAL(15,2),
    vicmsdeson SMALLINT,
    vfcp SMALLINT,
    vbcst SMALLINT,
    vst SMALLINT,
    vfcpst SMALLINT,
    vfcpstret SMALLINT,
    vprod SMALLINT,
    vfrete SMALLINT,
    vseg SMALLINT,
    vdesc SMALLINT,
    vii SMALLINT,
    vipi SMALLINT,
    vipidevol SMALLINT,
    vpis DECIMAL(15,2),
    vcofins DECIMAL(15,2),
    voutro SMALLINT,
    vnf SMALLINT
);

CREATE TABLE pag (
    id_pag BIGINT PRIMARY KEY,
    tpag SMALLINT,
    vpag SMALLINT
);

CREATE TABLE reference (
    id_reference BIGINT PRIMARY KEY,
    uri VARCHAR(50),
    digestvalue VARCHAR(50)
);

-- Foreign key constraints
ALTER TABLE nfe ADD CONSTRAINT fk_nfe_envinfe FOREIGN KEY (id_envinfe) REFERENCES envinfe(id_envinfe);
ALTER TABLE infnfe ADD CONSTRAINT fk_infnfe_nfe FOREIGN KEY (id_nfe) REFERENCES nfe(id_nfe);
ALTER TABLE ide ADD CONSTRAINT fk_ide_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE emit ADD CONSTRAINT fk_emit_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE enderemit ADD CONSTRAINT fk_enderemit_emit FOREIGN KEY (id_emit) REFERENCES emit(id_emit);
ALTER TABLE dest ADD CONSTRAINT fk_dest_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE enderdest ADD CONSTRAINT fk_enderdest_dest FOREIGN KEY (id_dest) REFERENCES dest(id_dest);
ALTER TABLE det ADD CONSTRAINT fk_det_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE prod ADD CONSTRAINT fk_prod_det FOREIGN KEY (id_det) REFERENCES det(id_det);
ALTER TABLE imposto ADD CONSTRAINT fk_imposto_det FOREIGN KEY (id_det) REFERENCES det(id_det);
ALTER TABLE icms ADD CONSTRAINT fk_icms_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE icms00 ADD CONSTRAINT fk_icms00_icms FOREIGN KEY (id_icms) REFERENCES icms(id_icms);
ALTER TABLE pis ADD CONSTRAINT fk_pis_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE pisaliq ADD CONSTRAINT fk_pisaliq_pis FOREIGN KEY (id_pis) REFERENCES pis(id_pis);
ALTER TABLE cofins ADD CONSTRAINT fk_cofins_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE cofinsaliq ADD CONSTRAINT fk_cofinsaliq_cofins FOREIGN KEY (id_cofins) REFERENCES cofins(id_cofins);
ALTER TABLE total ADD CONSTRAINT fk_total_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE icmstot ADD CONSTRAINT fk_icmstot_total FOREIGN KEY (id_total) REFERENCES total(id_total);
ALTER TABLE pag ADD CONSTRAINT fk_pag_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE signature ADD CONSTRAINT fk_signature_nfe FOREIGN KEY (id_nfe) REFERENCES nfe(id_nfe);
ALTER TABLE signedinfo ADD CONSTRAINT fk_signedinfo_signature FOREIGN KEY (id_signature) REFERENCES signature(id_signature);
ALTER TABLE canonicalizationmethod ADD CONSTRAINT fk_canonicalizationmethod_signedinfo FOREIGN KEY (id_signedinfo) REFERENCES signedinfo(id_signedinfo);
ALTER TABLE signaturemethod ADD CONSTRAINT fk_signaturemethod_signedinfo FOREIGN KEY (id_signedinfo) REFERENCES signedinfo(id_signedinfo);
ALTER TABLE reference ADD CONSTRAINT fk_reference_signedinfo FOREIGN KEY (id_signedinfo) REFERENCES signedinfo(id_signedinfo);
ALTER TABLE transform ADD CONSTRAINT fk_transform_reference FOREIGN KEY (id_reference) REFERENCES reference(id_reference);
ALTER TABLE digestmethod ADD CONSTRAINT fk_digestmethod_reference FOREIGN KEY (id_reference) REFERENCES reference(id_reference);
ALTER TABLE keyinfo ADD CONSTRAINT fk_keyinfo_signature FOREIGN KEY (id_signature) REFERENCES signature(id_signature);

-- Indexes for performance
CREATE INDEX idx_envinfe_pk ON envinfe(id_envinfe);
CREATE INDEX idx_infnfe_pk ON infnfe(id_infnfe);
CREATE INDEX idx_ide_pk ON ide(id_ide);
CREATE INDEX idx_emit_pk ON emit(id_emit);
CREATE INDEX idx_enderemit_pk ON enderemit(id_enderemit);
CREATE INDEX idx_dest_pk ON dest(id_dest);
CREATE INDEX idx_enderdest_pk ON enderdest(id_enderdest);
CREATE INDEX idx_det_pk ON det(id_det);
CREATE INDEX idx_prod_pk ON prod(id_prod);
CREATE INDEX idx_icms00_pk ON icms00(id_icms00);
CREATE INDEX idx_pisaliq_pk ON pisaliq(id_pisaliq);
CREATE INDEX idx_cofinsaliq_pk ON cofinsaliq(id_cofinsaliq);
CREATE INDEX idx_icmstot_pk ON icmstot(id_icmstot);
CREATE INDEX idx_pag_pk ON pag(id_pag);
CREATE INDEX idx_signature_pk ON signature(id_signature);
CREATE INDEX idx_canonicalizationmethod_pk ON canonicalizationmethod(id_canonicalizationmethod);
CREATE INDEX idx_signaturemethod_pk ON signaturemethod(id_signaturemethod);
CREATE INDEX idx_reference_pk ON reference(id_reference);
CREATE INDEX idx_transform_pk ON transform(id_transform);
CREATE INDEX idx_digestmethod_pk ON digestmethod(id_digestmethod);
CREATE INDEX idx_keyinfo_pk ON keyinfo(id_keyinfo);
CREATE INDEX idx_nfe_id_envinfe ON nfe(id_envinfe);
CREATE INDEX idx_infnfe_id_nfe ON infnfe(id_nfe);
CREATE INDEX idx_ide_id_infnfe ON ide(id_infnfe);
CREATE INDEX idx_emit_id_infnfe ON emit(id_infnfe);
CREATE INDEX idx_enderemit_id_emit ON enderemit(id_emit);
CREATE INDEX idx_dest_id_infnfe ON dest(id_infnfe);
CREATE INDEX idx_enderdest_id_dest ON enderdest(id_dest);
CREATE INDEX idx_det_id_infnfe ON det(id_infnfe);
CREATE INDEX idx_prod_id_det ON prod(id_det);
CREATE INDEX idx_imposto_id_det ON imposto(id_det);
CREATE INDEX idx_icms_id_imposto ON icms(id_imposto);
CREATE INDEX idx_icms00_id_icms ON icms00(id_icms);
CREATE INDEX idx_pis_id_imposto ON pis(id_imposto);
CREATE INDEX idx_pisaliq_id_pis ON pisaliq(id_pis);
CREATE INDEX idx_cofins_id_imposto ON cofins(id_imposto);
CREATE INDEX idx_cofinsaliq_id_cofins ON cofinsaliq(id_cofins);
CREATE INDEX idx_total_id_infnfe ON total(id_infnfe);
CREATE INDEX idx_icmstot_id_total ON icmstot(id_total);
CREATE INDEX idx_pag_id_infnfe ON pag(id_infnfe);
CREATE INDEX idx_signature_id_nfe ON signature(id_nfe);
CREATE INDEX idx_signedinfo_id_signature ON signedinfo(id_signature);
CREATE INDEX idx_canonicalizationmethod_id_signedinfo ON canonicalizationmethod(id_signedinfo);
CREATE INDEX idx_signaturemethod_id_signedinfo ON signaturemethod(id_signedinfo);
CREATE INDEX idx_reference_id_signedinfo ON reference(id_signedinfo);
CREATE INDEX idx_transform_id_reference ON transform(id_reference);
CREATE INDEX idx_digestmethod_id_reference ON digestmethod(id_reference);
CREATE INDEX idx_keyinfo_id_signature ON keyinfo(id_signature);

-- End of SQL script