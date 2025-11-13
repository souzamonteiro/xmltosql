-- SQL Schema automatically generated from XML
-- Generic XML to SQL converter

CREATE SEQUENCE hibernate_sequence START 1 INCREMENT 1;

CREATE TABLE infnfe (
    id_infnfe BIGINT PRIMARY KEY,
    id VARCHAR(50),
    versao SMALLINT,
    cnpj NUMERIC(20,0),
    infcpl VARCHAR(500)
);

CREATE TABLE ide (
    id_ide BIGINT PRIMARY KEY,
    cuf SMALLINT,
    cnf BIGINT,
    natop VARCHAR(50),
    mod SMALLINT,
    serie BOOLEAN,
    nnf BIGINT,
    dhemi TIMESTAMP,
    dhsaient TIMESTAMP,
    tpnf BOOLEAN,
    iddest BOOLEAN,
    cmunfg BIGINT,
    tpimp BOOLEAN,
    tpemis BOOLEAN,
    cdv SMALLINT,
    tpamb BOOLEAN,
    finnfe BOOLEAN,
    indfinal BOOLEAN,
    indpres BOOLEAN,
    procemi BOOLEAN,
    verproc VARCHAR(10)
);

CREATE TABLE emit (
    id_emit BIGINT PRIMARY KEY,
    cnpj NUMERIC(20,0),
    xnome VARCHAR(50),
    xfant VARCHAR(10),
    ie BIGINT,
    crt SMALLINT
);

CREATE TABLE enderemit (
    id_enderemit BIGINT PRIMARY KEY,
    xlgr VARCHAR(50),
    nro BOOLEAN,
    xbairro VARCHAR(20),
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
    xnome VARCHAR(50),
    indiedest BOOLEAN,
    ie BIGINT
);

CREATE TABLE enderdest (
    id_enderdest BIGINT PRIMARY KEY,
    xlgr VARCHAR(50),
    nro SMALLINT,
    xbairro VARCHAR(10),
    cmun BIGINT,
    xmun VARCHAR(10),
    uf VARCHAR(10),
    cep BIGINT,
    cpais INTEGER,
    xpais VARCHAR(10),
    fone NUMERIC(20,0)
);

CREATE TABLE entrega (
    id_entrega BIGINT PRIMARY KEY,
    cnpj NUMERIC(20,0),
    xlgr VARCHAR(50),
    nro SMALLINT,
    xbairro VARCHAR(10),
    cmun BIGINT,
    xmun VARCHAR(10),
    uf VARCHAR(10)
);

CREATE TABLE prod (
    id_prod BIGINT PRIMARY KEY,
    cprod BIGINT,
    cean VARCHAR(50),
    xprod VARCHAR(50),
    ncm BIGINT,
    cfop INTEGER,
    ucom VARCHAR(10),
    qcom SMALLINT,
    vuncom DECIMAL(15,4),
    vprod DECIMAL(15,2),
    ceantrib VARCHAR(50),
    utrib VARCHAR(10),
    qtrib SMALLINT,
    vuntrib DECIMAL(15,4),
    indtot BOOLEAN,
    xped BIGINT,
    nitemped SMALLINT,
    cest BIGINT,
    indescala VARCHAR(10),
    extipi SMALLINT
);

CREATE TABLE icms20 (
    id_icms20 BIGINT PRIMARY KEY,
    orig SMALLINT,
    cst SMALLINT,
    modbc SMALLINT,
    predbc DECIMAL(15,4),
    vbc DECIMAL(15,2),
    picms SMALLINT,
    vicms DECIMAL(15,2)
);

CREATE TABLE ipitrib (
    id_ipitrib BIGINT PRIMARY KEY,
    cst SMALLINT,
    vbc SMALLINT,
    pipi SMALLINT,
    vipi SMALLINT
);

CREATE TABLE pisaliq (
    id_pisaliq BIGINT PRIMARY KEY,
    cst SMALLINT,
    vbc DECIMAL(15,2),
    ppis DECIMAL(15,4),
    vpis DECIMAL(15,2)
);

CREATE TABLE cofinsaliq (
    id_cofinsaliq BIGINT PRIMARY KEY,
    cst SMALLINT,
    vbc DECIMAL(15,2),
    pcofins DECIMAL(15,4),
    vcofins DECIMAL(15,2)
);

CREATE TABLE icmstot (
    id_icmstot BIGINT PRIMARY KEY,
    vbc DECIMAL(15,2),
    vicms DECIMAL(15,2),
    vicmsdeson SMALLINT,
    vfcp SMALLINT,
    vbcst SMALLINT,
    vst SMALLINT,
    vfcpst SMALLINT,
    vfcpstret SMALLINT,
    vprod DECIMAL(15,2),
    vfrete SMALLINT,
    vseg SMALLINT,
    vdesc SMALLINT,
    vii SMALLINT,
    vipi SMALLINT,
    vipidevol SMALLINT,
    vpis DECIMAL(15,2),
    vcofins SMALLINT,
    voutro SMALLINT,
    vnf DECIMAL(15,2),
    vtottrib SMALLINT
);

CREATE TABLE vol (
    id_vol BIGINT PRIMARY KEY,
    nvol BOOLEAN,
    pesol DECIMAL(15,3),
    pesob DECIMAL(15,3)
);

CREATE TABLE fat (
    id_fat BIGINT PRIMARY KEY,
    nfat BIGINT,
    vorig DECIMAL(15,2),
    vdesc BOOLEAN,
    vliq DECIMAL(15,2)
);

CREATE TABLE dup (
    id_dup BIGINT PRIMARY KEY,
    ndup SMALLINT,
    dvenc DATE,
    vdup DECIMAL(15,2)
);

CREATE TABLE detpag (
    id_detpag BIGINT PRIMARY KEY,
    indpag BOOLEAN,
    tpag SMALLINT,
    vpag DECIMAL(15,2)
);

CREATE TABLE card (
    id_card BIGINT PRIMARY KEY,
    tpintegra BOOLEAN,
    cnpj NUMERIC(20,0),
    tband SMALLINT,
    caut SMALLINT
);

CREATE TABLE infresptec (
    id_infresptec BIGINT PRIMARY KEY,
    cnpj NUMERIC(20,0),
    xcontato VARCHAR(50),
    email VARCHAR(255),
    fone NUMERIC(20,0)
);

CREATE TABLE reference (
    id_reference BIGINT PRIMARY KEY,
    uri VARCHAR(50),
    digestvalue VARCHAR(50)
);

CREATE TABLE infprot (
    id_infprot BIGINT PRIMARY KEY,
    id VARCHAR(20),
    tpamb BOOLEAN,
    veraplic SMALLINT,
    chnfe NUMERIC(20,0),
    dhrecbto TIMESTAMP,
    nprot NUMERIC(20,0),
    digval VARCHAR(50),
    cstat SMALLINT,
    xmotivo VARCHAR(50)
);

-- Foreign key constraints
ALTER TABLE nfe ADD CONSTRAINT fk_nfe_nfeproc FOREIGN KEY (id_nfeproc) REFERENCES nfeproc(id_nfeproc);
ALTER TABLE infnfe ADD CONSTRAINT fk_infnfe_nfe FOREIGN KEY (id_nfe) REFERENCES nfe(id_nfe);
ALTER TABLE ide ADD CONSTRAINT fk_ide_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE emit ADD CONSTRAINT fk_emit_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE enderemit ADD CONSTRAINT fk_enderemit_emit FOREIGN KEY (id_emit) REFERENCES emit(id_emit);
ALTER TABLE dest ADD CONSTRAINT fk_dest_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE enderdest ADD CONSTRAINT fk_enderdest_dest FOREIGN KEY (id_dest) REFERENCES dest(id_dest);
ALTER TABLE entrega ADD CONSTRAINT fk_entrega_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE det ADD CONSTRAINT fk_det_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE prod ADD CONSTRAINT fk_prod_det FOREIGN KEY (id_det) REFERENCES det(id_det);
ALTER TABLE imposto ADD CONSTRAINT fk_imposto_det FOREIGN KEY (id_det) REFERENCES det(id_det);
ALTER TABLE icms ADD CONSTRAINT fk_icms_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE icms20 ADD CONSTRAINT fk_icms20_icms FOREIGN KEY (id_icms) REFERENCES icms(id_icms);
ALTER TABLE ipi ADD CONSTRAINT fk_ipi_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE ipitrib ADD CONSTRAINT fk_ipitrib_ipi FOREIGN KEY (id_ipi) REFERENCES ipi(id_ipi);
ALTER TABLE pis ADD CONSTRAINT fk_pis_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE pisaliq ADD CONSTRAINT fk_pisaliq_pis FOREIGN KEY (id_pis) REFERENCES pis(id_pis);
ALTER TABLE cofins ADD CONSTRAINT fk_cofins_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE cofinsaliq ADD CONSTRAINT fk_cofinsaliq_cofins FOREIGN KEY (id_cofins) REFERENCES cofins(id_cofins);
ALTER TABLE total ADD CONSTRAINT fk_total_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE icmstot ADD CONSTRAINT fk_icmstot_total FOREIGN KEY (id_total) REFERENCES total(id_total);
ALTER TABLE transp ADD CONSTRAINT fk_transp_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE vol ADD CONSTRAINT fk_vol_transp FOREIGN KEY (id_transp) REFERENCES transp(id_transp);
ALTER TABLE cobr ADD CONSTRAINT fk_cobr_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE fat ADD CONSTRAINT fk_fat_cobr FOREIGN KEY (id_cobr) REFERENCES cobr(id_cobr);
ALTER TABLE dup ADD CONSTRAINT fk_dup_cobr FOREIGN KEY (id_cobr) REFERENCES cobr(id_cobr);
ALTER TABLE pag ADD CONSTRAINT fk_pag_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE detpag ADD CONSTRAINT fk_detpag_pag FOREIGN KEY (id_pag) REFERENCES pag(id_pag);
ALTER TABLE card ADD CONSTRAINT fk_card_detpag FOREIGN KEY (id_detpag) REFERENCES detpag(id_detpag);
ALTER TABLE infresptec ADD CONSTRAINT fk_infresptec_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE signature ADD CONSTRAINT fk_signature_nfe FOREIGN KEY (id_nfe) REFERENCES nfe(id_nfe);
ALTER TABLE signedinfo ADD CONSTRAINT fk_signedinfo_signature FOREIGN KEY (id_signature) REFERENCES signature(id_signature);
ALTER TABLE canonicalizationmethod ADD CONSTRAINT fk_canonicalizationmethod_signedinfo FOREIGN KEY (id_signedinfo) REFERENCES signedinfo(id_signedinfo);
ALTER TABLE signaturemethod ADD CONSTRAINT fk_signaturemethod_signedinfo FOREIGN KEY (id_signedinfo) REFERENCES signedinfo(id_signedinfo);
ALTER TABLE reference ADD CONSTRAINT fk_reference_signedinfo FOREIGN KEY (id_signedinfo) REFERENCES signedinfo(id_signedinfo);
ALTER TABLE transform ADD CONSTRAINT fk_transform_reference FOREIGN KEY (id_reference) REFERENCES reference(id_reference);
ALTER TABLE digestmethod ADD CONSTRAINT fk_digestmethod_reference FOREIGN KEY (id_reference) REFERENCES reference(id_reference);
ALTER TABLE keyinfo ADD CONSTRAINT fk_keyinfo_signature FOREIGN KEY (id_signature) REFERENCES signature(id_signature);
ALTER TABLE protnfe ADD CONSTRAINT fk_protnfe_nfeproc FOREIGN KEY (id_nfeproc) REFERENCES nfeproc(id_nfeproc);
ALTER TABLE infprot ADD CONSTRAINT fk_infprot_protnfe FOREIGN KEY (id_protnfe) REFERENCES protnfe(id_protnfe);

-- Indexes for performance
CREATE INDEX idx_infnfe_pk ON infnfe(id_infnfe);
CREATE INDEX idx_ide_pk ON ide(id_ide);
CREATE INDEX idx_emit_pk ON emit(id_emit);
CREATE INDEX idx_enderemit_pk ON enderemit(id_enderemit);
CREATE INDEX idx_dest_pk ON dest(id_dest);
CREATE INDEX idx_enderdest_pk ON enderdest(id_enderdest);
CREATE INDEX idx_entrega_pk ON entrega(id_entrega);
CREATE INDEX idx_det_pk ON det(id_det);
CREATE INDEX idx_prod_pk ON prod(id_prod);
CREATE INDEX idx_icms20_pk ON icms20(id_icms20);
CREATE INDEX idx_ipi_pk ON ipi(id_ipi);
CREATE INDEX idx_ipitrib_pk ON ipitrib(id_ipitrib);
CREATE INDEX idx_pisaliq_pk ON pisaliq(id_pisaliq);
CREATE INDEX idx_cofinsaliq_pk ON cofinsaliq(id_cofinsaliq);
CREATE INDEX idx_icmstot_pk ON icmstot(id_icmstot);
CREATE INDEX idx_transp_pk ON transp(id_transp);
CREATE INDEX idx_vol_pk ON vol(id_vol);
CREATE INDEX idx_fat_pk ON fat(id_fat);
CREATE INDEX idx_dup_pk ON dup(id_dup);
CREATE INDEX idx_detpag_pk ON detpag(id_detpag);
CREATE INDEX idx_card_pk ON card(id_card);
CREATE INDEX idx_infresptec_pk ON infresptec(id_infresptec);
CREATE INDEX idx_signature_pk ON signature(id_signature);
CREATE INDEX idx_canonicalizationmethod_pk ON canonicalizationmethod(id_canonicalizationmethod);
CREATE INDEX idx_signaturemethod_pk ON signaturemethod(id_signaturemethod);
CREATE INDEX idx_reference_pk ON reference(id_reference);
CREATE INDEX idx_transform_pk ON transform(id_transform);
CREATE INDEX idx_digestmethod_pk ON digestmethod(id_digestmethod);
CREATE INDEX idx_keyinfo_pk ON keyinfo(id_keyinfo);
CREATE INDEX idx_protnfe_pk ON protnfe(id_protnfe);
CREATE INDEX idx_infprot_pk ON infprot(id_infprot);
CREATE INDEX idx_nfe_id_nfeproc ON nfe(id_nfeproc);
CREATE INDEX idx_infnfe_id_nfe ON infnfe(id_nfe);
CREATE INDEX idx_ide_id_infnfe ON ide(id_infnfe);
CREATE INDEX idx_emit_id_infnfe ON emit(id_infnfe);
CREATE INDEX idx_enderemit_id_emit ON enderemit(id_emit);
CREATE INDEX idx_dest_id_infnfe ON dest(id_infnfe);
CREATE INDEX idx_enderdest_id_dest ON enderdest(id_dest);
CREATE INDEX idx_entrega_id_infnfe ON entrega(id_infnfe);
CREATE INDEX idx_det_id_infnfe ON det(id_infnfe);
CREATE INDEX idx_prod_id_det ON prod(id_det);
CREATE INDEX idx_imposto_id_det ON imposto(id_det);
CREATE INDEX idx_icms_id_imposto ON icms(id_imposto);
CREATE INDEX idx_icms20_id_icms ON icms20(id_icms);
CREATE INDEX idx_ipi_id_imposto ON ipi(id_imposto);
CREATE INDEX idx_ipitrib_id_ipi ON ipitrib(id_ipi);
CREATE INDEX idx_pis_id_imposto ON pis(id_imposto);
CREATE INDEX idx_pisaliq_id_pis ON pisaliq(id_pis);
CREATE INDEX idx_cofins_id_imposto ON cofins(id_imposto);
CREATE INDEX idx_cofinsaliq_id_cofins ON cofinsaliq(id_cofins);
CREATE INDEX idx_total_id_infnfe ON total(id_infnfe);
CREATE INDEX idx_icmstot_id_total ON icmstot(id_total);
CREATE INDEX idx_transp_id_infnfe ON transp(id_infnfe);
CREATE INDEX idx_vol_id_transp ON vol(id_transp);
CREATE INDEX idx_cobr_id_infnfe ON cobr(id_infnfe);
CREATE INDEX idx_fat_id_cobr ON fat(id_cobr);
CREATE INDEX idx_dup_id_cobr ON dup(id_cobr);
CREATE INDEX idx_pag_id_infnfe ON pag(id_infnfe);
CREATE INDEX idx_detpag_id_pag ON detpag(id_pag);
CREATE INDEX idx_card_id_detpag ON card(id_detpag);
CREATE INDEX idx_infresptec_id_infnfe ON infresptec(id_infnfe);
CREATE INDEX idx_signature_id_nfe ON signature(id_nfe);
CREATE INDEX idx_signedinfo_id_signature ON signedinfo(id_signature);
CREATE INDEX idx_canonicalizationmethod_id_signedinfo ON canonicalizationmethod(id_signedinfo);
CREATE INDEX idx_signaturemethod_id_signedinfo ON signaturemethod(id_signedinfo);
CREATE INDEX idx_reference_id_signedinfo ON reference(id_signedinfo);
CREATE INDEX idx_transform_id_reference ON transform(id_reference);
CREATE INDEX idx_digestmethod_id_reference ON digestmethod(id_reference);
CREATE INDEX idx_keyinfo_id_signature ON keyinfo(id_signature);
CREATE INDEX idx_protnfe_id_nfeproc ON protnfe(id_nfeproc);
CREATE INDEX idx_infprot_id_protnfe ON infprot(id_protnfe);

-- End of SQL script