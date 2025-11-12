-- SQL Schema gerado automaticamente a partir do XML da NFe
-- Otimizado para uso com Hibernate/JPA

CREATE SEQUENCE hibernate_sequence START 1 INCREMENT 1;

CREATE TABLE nfe (
    id_nfe BIGINT PRIMARY KEY,
    versao DECIMAL(15,4),
    id VARCHAR(50)
);

CREATE TABLE ide (
    id_ide BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    cuf INTEGER,
    cnf INTEGER,
    natop VARCHAR(50),
    mod INTEGER,
    serie INTEGER,
    nnf INTEGER,
    dhemi TIMESTAMP,
    tpnf INTEGER,
    iddest INTEGER,
    cmunfg INTEGER,
    tpimp INTEGER,
    tpemis INTEGER,
    cdv INTEGER,
    tpamb INTEGER,
    finnfe INTEGER,
    indfinal INTEGER,
    indpres INTEGER,
    procemi INTEGER,
    verproc DECIMAL(15,4)
);

CREATE TABLE emit (
    id_emit BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    cnpj INTEGER,
    xnome VARCHAR(50),
    ie INTEGER,
    crt INTEGER
);

CREATE TABLE enderemit (
    id_enderemit BIGINT PRIMARY KEY,
    id_emit BIGINT,
    xlgr VARCHAR(50),
    nro INTEGER,
    xcpl VARCHAR(50),
    xbairro VARCHAR(50),
    cmun INTEGER,
    xmun VARCHAR(50),
    uf VARCHAR(50),
    cep INTEGER,
    cpais INTEGER,
    xpais VARCHAR(50),
    fone INTEGER
);

CREATE TABLE dest (
    id_dest BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    cnpj INTEGER,
    xnome VARCHAR(100),
    indiedest INTEGER,
    email VARCHAR(50)
);

CREATE TABLE enderdest (
    id_enderdest BIGINT PRIMARY KEY,
    id_dest BIGINT,
    xlgr VARCHAR(50),
    nro INTEGER,
    xbairro VARCHAR(50),
    cmun INTEGER,
    xmun VARCHAR(50),
    uf VARCHAR(50),
    cep INTEGER,
    cpais INTEGER,
    xpais VARCHAR(50),
    fone INTEGER
);

CREATE TABLE autxml (
    id_autxml BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    cnpj INTEGER
);

CREATE TABLE infnfe (
    id_infnfe BIGINT PRIMARY KEY,
    nitem INTEGER
);

CREATE TABLE prod (
    id_prod BIGINT PRIMARY KEY,
    id_det BIGINT,
    cprod INTEGER,
    cean INTEGER,
    xprod VARCHAR(100),
    ncm INTEGER,
    cest INTEGER,
    indescala VARCHAR(50),
    cfop INTEGER,
    ucom VARCHAR(50),
    qcom DECIMAL(15,4),
    vuncom DECIMAL(15,4),
    vprod DECIMAL(15,4),
    ceantrib INTEGER,
    utrib VARCHAR(50),
    qtrib DECIMAL(15,4),
    vuntrib DECIMAL(15,4),
    indtot INTEGER
);

CREATE TABLE icms00 (
    id_icms00 BIGINT PRIMARY KEY,
    id_icms BIGINT,
    orig INTEGER,
    cst INTEGER,
    modbc INTEGER,
    vbc DECIMAL(15,4),
    picms DECIMAL(15,4),
    vicms DECIMAL(15,4)
);

CREATE TABLE pisaliq (
    id_pisaliq BIGINT PRIMARY KEY,
    id_pis BIGINT,
    cst INTEGER,
    vbc DECIMAL(15,4),
    ppis DECIMAL(15,4),
    vpis DECIMAL(15,4)
);

CREATE TABLE cofinsaliq (
    id_cofinsaliq BIGINT PRIMARY KEY,
    id_cofins BIGINT,
    cst INTEGER,
    vbc DECIMAL(15,4),
    pcofins DECIMAL(15,4),
    vcofins DECIMAL(15,4)
);

CREATE TABLE icmstot (
    id_icmstot BIGINT PRIMARY KEY,
    id_total BIGINT,
    vbc DECIMAL(15,4),
    vicms DECIMAL(15,4),
    vicmsdeson DECIMAL(15,4),
    vfcp DECIMAL(15,4),
    vbcst DECIMAL(15,4),
    vst DECIMAL(15,4),
    vfcpst DECIMAL(15,4),
    vfcpstret DECIMAL(15,4),
    vprod DECIMAL(15,4),
    vfrete DECIMAL(15,4),
    vseg DECIMAL(15,4),
    vdesc DECIMAL(15,4),
    vii DECIMAL(15,4),
    vipi DECIMAL(15,4),
    vipidevol DECIMAL(15,4),
    vpis DECIMAL(15,4),
    vcofins DECIMAL(15,4),
    voutro DECIMAL(15,4),
    vnf DECIMAL(15,4)
);

CREATE TABLE transp (
    id_transp BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    modfrete INTEGER
);

CREATE TABLE detpag (
    id_detpag BIGINT PRIMARY KEY,
    id_pag BIGINT,
    tpag INTEGER,
    vpag DECIMAL(15,4)
);

CREATE TABLE signature (
    id_signature BIGINT PRIMARY KEY,
    id_nfe BIGINT,
    signaturevalue TEXT
);

CREATE TABLE signedinfo (
    id_signedinfo BIGINT PRIMARY KEY,
    algorithm VARCHAR(50),
    uri VARCHAR(50)
);

CREATE TABLE reference (
    id_reference BIGINT PRIMARY KEY,
    id_signedinfo BIGINT,
    algorithm VARCHAR(50),
    digestvalue VARCHAR(50)
);

CREATE TABLE transforms (
    id_transforms BIGINT PRIMARY KEY,
    algorithm VARCHAR(50)
);

CREATE TABLE x509data (
    id_x509data BIGINT PRIMARY KEY,
    id_keyinfo BIGINT,
    x509certificate TEXT
);

ALTER TABLE ide ADD CONSTRAINT fk_ide_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE emit ADD CONSTRAINT fk_emit_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE enderemit ADD CONSTRAINT fk_enderemit_emit FOREIGN KEY (id_emit) REFERENCES emit(id_emit);
ALTER TABLE dest ADD CONSTRAINT fk_dest_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE enderdest ADD CONSTRAINT fk_enderdest_dest FOREIGN KEY (id_dest) REFERENCES dest(id_dest);
ALTER TABLE autxml ADD CONSTRAINT fk_autxml_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE prod ADD CONSTRAINT fk_prod_det FOREIGN KEY (id_det) REFERENCES det(id_det);
ALTER TABLE icms00 ADD CONSTRAINT fk_icms00_icms FOREIGN KEY (id_icms) REFERENCES icms(id_icms);
ALTER TABLE pisaliq ADD CONSTRAINT fk_pisaliq_pis FOREIGN KEY (id_pis) REFERENCES pis(id_pis);
ALTER TABLE cofinsaliq ADD CONSTRAINT fk_cofinsaliq_cofins FOREIGN KEY (id_cofins) REFERENCES cofins(id_cofins);
ALTER TABLE icmstot ADD CONSTRAINT fk_icmstot_total FOREIGN KEY (id_total) REFERENCES total(id_total);
ALTER TABLE transp ADD CONSTRAINT fk_transp_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE detpag ADD CONSTRAINT fk_detpag_pag FOREIGN KEY (id_pag) REFERENCES pag(id_pag);
ALTER TABLE signature ADD CONSTRAINT fk_signature_nfe FOREIGN KEY (id_nfe) REFERENCES nfe(id_nfe);
ALTER TABLE reference ADD CONSTRAINT fk_reference_signedinfo FOREIGN KEY (id_signedinfo) REFERENCES signedinfo(id_signedinfo);
ALTER TABLE x509data ADD CONSTRAINT fk_x509data_keyinfo FOREIGN KEY (id_keyinfo) REFERENCES keyinfo(id_keyinfo);
CREATE INDEX idx_nfe_id ON nfe(id_nfe);
CREATE INDEX idx_ide_id ON ide(id_ide);
CREATE INDEX idx_emit_id ON emit(id_emit);
CREATE INDEX idx_enderemit_id ON enderemit(id_enderemit);
CREATE INDEX idx_dest_id ON dest(id_dest);
CREATE INDEX idx_enderdest_id ON enderdest(id_enderdest);
CREATE INDEX idx_autxml_id ON autxml(id_autxml);
CREATE INDEX idx_infnfe_id ON infnfe(id_infnfe);
CREATE INDEX idx_prod_id ON prod(id_prod);
CREATE INDEX idx_icms00_id ON icms00(id_icms00);
CREATE INDEX idx_pisaliq_id ON pisaliq(id_pisaliq);
CREATE INDEX idx_cofinsaliq_id ON cofinsaliq(id_cofinsaliq);
CREATE INDEX idx_icmstot_id ON icmstot(id_icmstot);
CREATE INDEX idx_transp_id ON transp(id_transp);
CREATE INDEX idx_detpag_id ON detpag(id_detpag);
CREATE INDEX idx_signature_id ON signature(id_signature);
CREATE INDEX idx_signedinfo_id ON signedinfo(id_signedinfo);
CREATE INDEX idx_reference_id ON reference(id_reference);
CREATE INDEX idx_transforms_id ON transforms(id_transforms);
CREATE INDEX idx_x509data_id ON x509data(id_x509data);
CREATE INDEX idx_ide_id_infnfe ON ide(id_infnfe);
CREATE INDEX idx_emit_id_infnfe ON emit(id_infnfe);
CREATE INDEX idx_enderemit_id_emit ON enderemit(id_emit);
CREATE INDEX idx_dest_id_infnfe ON dest(id_infnfe);
CREATE INDEX idx_enderdest_id_dest ON enderdest(id_dest);
CREATE INDEX idx_autxml_id_infnfe ON autxml(id_infnfe);
CREATE INDEX idx_prod_id_det ON prod(id_det);
CREATE INDEX idx_icms00_id_icms ON icms00(id_icms);
CREATE INDEX idx_pisaliq_id_pis ON pisaliq(id_pis);
CREATE INDEX idx_cofinsaliq_id_cofins ON cofinsaliq(id_cofins);
CREATE INDEX idx_icmstot_id_total ON icmstot(id_total);
CREATE INDEX idx_transp_id_infnfe ON transp(id_infnfe);
CREATE INDEX idx_detpag_id_pag ON detpag(id_pag);
CREATE INDEX idx_signature_id_nfe ON signature(id_nfe);
CREATE INDEX idx_reference_id_signedinfo ON reference(id_signedinfo);
CREATE INDEX idx_x509data_id_keyinfo ON x509data(id_keyinfo);

-- Fim do script SQL