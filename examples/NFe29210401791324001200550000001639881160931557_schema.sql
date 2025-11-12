-- SQL Schema gerado automaticamente a partir do XML da NFe
-- Otimizado para uso com Hibernate/JPA

CREATE SEQUENCE hibernate_sequence START 1 INCREMENT 1;

CREATE TABLE nfe (
    id_nfe BIGINT PRIMARY KEY,
    id VARCHAR(50),
    versao DECIMAL(15,4)
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
    dhsaient TIMESTAMP,
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
    verproc VARCHAR(50)
);

CREATE TABLE emit (
    id_emit BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    cnpj INTEGER,
    xnome VARCHAR(50),
    xfant VARCHAR(50),
    ie INTEGER,
    crt INTEGER
);

CREATE TABLE enderemit (
    id_enderemit BIGINT PRIMARY KEY,
    id_emit BIGINT,
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

CREATE TABLE dest (
    id_dest BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    cnpj INTEGER,
    xnome VARCHAR(50),
    indiedest INTEGER,
    ie INTEGER
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

CREATE TABLE entrega (
    id_entrega BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    cnpj INTEGER,
    xlgr VARCHAR(50),
    nro INTEGER,
    xbairro VARCHAR(50),
    cmun INTEGER,
    xmun VARCHAR(50),
    uf VARCHAR(50)
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
    cean VARCHAR(50),
    xprod VARCHAR(50),
    ncm INTEGER,
    cfop INTEGER,
    ucom VARCHAR(50),
    qcom DECIMAL(15,4),
    vuncom DECIMAL(15,4),
    vprod DECIMAL(15,4),
    ceantrib VARCHAR(50),
    utrib VARCHAR(50),
    qtrib DECIMAL(15,4),
    vuntrib DECIMAL(15,4),
    indtot INTEGER,
    xped INTEGER,
    nitemped INTEGER,
    cest INTEGER,
    indescala VARCHAR(50),
    extipi INTEGER
);

CREATE TABLE icms20 (
    id_icms20 BIGINT PRIMARY KEY,
    id_icms BIGINT,
    orig INTEGER,
    cst INTEGER,
    modbc INTEGER,
    predbc DECIMAL(15,4),
    vbc DECIMAL(15,4),
    picms DECIMAL(15,4),
    vicms DECIMAL(15,4)
);

CREATE TABLE ipi (
    id_ipi BIGINT PRIMARY KEY,
    id_imposto BIGINT,
    cenq INTEGER
);

CREATE TABLE ipitrib (
    id_ipitrib BIGINT PRIMARY KEY,
    id_ipi BIGINT,
    cst INTEGER,
    vbc DECIMAL(15,4),
    pipi DECIMAL(15,4),
    vipi DECIMAL(15,4)
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
    vnf DECIMAL(15,4),
    vtottrib DECIMAL(15,4)
);

CREATE TABLE transp (
    id_transp BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    modfrete INTEGER
);

CREATE TABLE vol (
    id_vol BIGINT PRIMARY KEY,
    id_transp BIGINT,
    nvol INTEGER,
    pesol DECIMAL(15,4),
    pesob DECIMAL(15,4)
);

CREATE TABLE fat (
    id_fat BIGINT PRIMARY KEY,
    id_cobr BIGINT,
    nfat INTEGER,
    vorig DECIMAL(15,4),
    vdesc INTEGER,
    vliq DECIMAL(15,4)
);

CREATE TABLE dup (
    id_dup BIGINT PRIMARY KEY,
    id_cobr BIGINT,
    ndup INTEGER,
    dvenc TIMESTAMP,
    vdup DECIMAL(15,4)
);

CREATE TABLE detpag (
    id_detpag BIGINT PRIMARY KEY,
    id_pag BIGINT,
    indpag INTEGER,
    tpag INTEGER,
    vpag DECIMAL(15,4)
);

CREATE TABLE card (
    id_card BIGINT PRIMARY KEY,
    id_detpag BIGINT,
    tpintegra INTEGER,
    cnpj INTEGER,
    tband INTEGER,
    caut INTEGER
);

CREATE TABLE infadic (
    id_infadic BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    infcpl TEXT
);

CREATE TABLE infresptec (
    id_infresptec BIGINT PRIMARY KEY,
    id_infnfe BIGINT,
    cnpj INTEGER,
    xcontato VARCHAR(50),
    email VARCHAR(50),
    fone INTEGER
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
ALTER TABLE entrega ADD CONSTRAINT fk_entrega_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE autxml ADD CONSTRAINT fk_autxml_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE prod ADD CONSTRAINT fk_prod_det FOREIGN KEY (id_det) REFERENCES det(id_det);
ALTER TABLE icms20 ADD CONSTRAINT fk_icms20_icms FOREIGN KEY (id_icms) REFERENCES icms(id_icms);
ALTER TABLE ipi ADD CONSTRAINT fk_ipi_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE ipitrib ADD CONSTRAINT fk_ipitrib_ipi FOREIGN KEY (id_ipi) REFERENCES ipi(id_ipi);
ALTER TABLE pisaliq ADD CONSTRAINT fk_pisaliq_pis FOREIGN KEY (id_pis) REFERENCES pis(id_pis);
ALTER TABLE cofinsaliq ADD CONSTRAINT fk_cofinsaliq_cofins FOREIGN KEY (id_cofins) REFERENCES cofins(id_cofins);
ALTER TABLE prod ADD CONSTRAINT fk_prod_det FOREIGN KEY (id_det) REFERENCES det(id_det);
ALTER TABLE icms20 ADD CONSTRAINT fk_icms20_icms FOREIGN KEY (id_icms) REFERENCES icms(id_icms);
ALTER TABLE ipi ADD CONSTRAINT fk_ipi_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE ipitrib ADD CONSTRAINT fk_ipitrib_ipi FOREIGN KEY (id_ipi) REFERENCES ipi(id_ipi);
ALTER TABLE pisaliq ADD CONSTRAINT fk_pisaliq_pis FOREIGN KEY (id_pis) REFERENCES pis(id_pis);
ALTER TABLE cofinsaliq ADD CONSTRAINT fk_cofinsaliq_cofins FOREIGN KEY (id_cofins) REFERENCES cofins(id_cofins);
ALTER TABLE prod ADD CONSTRAINT fk_prod_det FOREIGN KEY (id_det) REFERENCES det(id_det);
ALTER TABLE icms20 ADD CONSTRAINT fk_icms20_icms FOREIGN KEY (id_icms) REFERENCES icms(id_icms);
ALTER TABLE ipi ADD CONSTRAINT fk_ipi_imposto FOREIGN KEY (id_imposto) REFERENCES imposto(id_imposto);
ALTER TABLE ipitrib ADD CONSTRAINT fk_ipitrib_ipi FOREIGN KEY (id_ipi) REFERENCES ipi(id_ipi);
ALTER TABLE pisaliq ADD CONSTRAINT fk_pisaliq_pis FOREIGN KEY (id_pis) REFERENCES pis(id_pis);
ALTER TABLE cofinsaliq ADD CONSTRAINT fk_cofinsaliq_cofins FOREIGN KEY (id_cofins) REFERENCES cofins(id_cofins);
ALTER TABLE icmstot ADD CONSTRAINT fk_icmstot_total FOREIGN KEY (id_total) REFERENCES total(id_total);
ALTER TABLE transp ADD CONSTRAINT fk_transp_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE vol ADD CONSTRAINT fk_vol_transp FOREIGN KEY (id_transp) REFERENCES transp(id_transp);
ALTER TABLE fat ADD CONSTRAINT fk_fat_cobr FOREIGN KEY (id_cobr) REFERENCES cobr(id_cobr);
ALTER TABLE dup ADD CONSTRAINT fk_dup_cobr FOREIGN KEY (id_cobr) REFERENCES cobr(id_cobr);
ALTER TABLE dup ADD CONSTRAINT fk_dup_cobr FOREIGN KEY (id_cobr) REFERENCES cobr(id_cobr);
ALTER TABLE detpag ADD CONSTRAINT fk_detpag_pag FOREIGN KEY (id_pag) REFERENCES pag(id_pag);
ALTER TABLE card ADD CONSTRAINT fk_card_detpag FOREIGN KEY (id_detpag) REFERENCES detpag(id_detpag);
ALTER TABLE infadic ADD CONSTRAINT fk_infadic_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE infresptec ADD CONSTRAINT fk_infresptec_infnfe FOREIGN KEY (id_infnfe) REFERENCES infnfe(id_infnfe);
ALTER TABLE signature ADD CONSTRAINT fk_signature_nfe FOREIGN KEY (id_nfe) REFERENCES nfe(id_nfe);
ALTER TABLE reference ADD CONSTRAINT fk_reference_signedinfo FOREIGN KEY (id_signedinfo) REFERENCES signedinfo(id_signedinfo);
ALTER TABLE x509data ADD CONSTRAINT fk_x509data_keyinfo FOREIGN KEY (id_keyinfo) REFERENCES keyinfo(id_keyinfo);
CREATE INDEX idx_nfe_id ON nfe(id_nfe);
CREATE INDEX idx_ide_id ON ide(id_ide);
CREATE INDEX idx_emit_id ON emit(id_emit);
CREATE INDEX idx_enderemit_id ON enderemit(id_enderemit);
CREATE INDEX idx_dest_id ON dest(id_dest);
CREATE INDEX idx_enderdest_id ON enderdest(id_enderdest);
CREATE INDEX idx_entrega_id ON entrega(id_entrega);
CREATE INDEX idx_autxml_id ON autxml(id_autxml);
CREATE INDEX idx_infnfe_id ON infnfe(id_infnfe);
CREATE INDEX idx_prod_id ON prod(id_prod);
CREATE INDEX idx_icms20_id ON icms20(id_icms20);
CREATE INDEX idx_ipi_id ON ipi(id_ipi);
CREATE INDEX idx_ipitrib_id ON ipitrib(id_ipitrib);
CREATE INDEX idx_pisaliq_id ON pisaliq(id_pisaliq);
CREATE INDEX idx_cofinsaliq_id ON cofinsaliq(id_cofinsaliq);
CREATE INDEX idx_icmstot_id ON icmstot(id_icmstot);
CREATE INDEX idx_transp_id ON transp(id_transp);
CREATE INDEX idx_vol_id ON vol(id_vol);
CREATE INDEX idx_fat_id ON fat(id_fat);
CREATE INDEX idx_dup_id ON dup(id_dup);
CREATE INDEX idx_detpag_id ON detpag(id_detpag);
CREATE INDEX idx_card_id ON card(id_card);
CREATE INDEX idx_infadic_id ON infadic(id_infadic);
CREATE INDEX idx_infresptec_id ON infresptec(id_infresptec);
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
CREATE INDEX idx_entrega_id_infnfe ON entrega(id_infnfe);
CREATE INDEX idx_autxml_id_infnfe ON autxml(id_infnfe);
CREATE INDEX idx_prod_id_det ON prod(id_det);
CREATE INDEX idx_icms20_id_icms ON icms20(id_icms);
CREATE INDEX idx_ipi_id_imposto ON ipi(id_imposto);
CREATE INDEX idx_ipitrib_id_ipi ON ipitrib(id_ipi);
CREATE INDEX idx_pisaliq_id_pis ON pisaliq(id_pis);
CREATE INDEX idx_cofinsaliq_id_cofins ON cofinsaliq(id_cofins);
CREATE INDEX idx_prod_id_det ON prod(id_det);
CREATE INDEX idx_icms20_id_icms ON icms20(id_icms);
CREATE INDEX idx_ipi_id_imposto ON ipi(id_imposto);
CREATE INDEX idx_ipitrib_id_ipi ON ipitrib(id_ipi);
CREATE INDEX idx_pisaliq_id_pis ON pisaliq(id_pis);
CREATE INDEX idx_cofinsaliq_id_cofins ON cofinsaliq(id_cofins);
CREATE INDEX idx_prod_id_det ON prod(id_det);
CREATE INDEX idx_icms20_id_icms ON icms20(id_icms);
CREATE INDEX idx_ipi_id_imposto ON ipi(id_imposto);
CREATE INDEX idx_ipitrib_id_ipi ON ipitrib(id_ipi);
CREATE INDEX idx_pisaliq_id_pis ON pisaliq(id_pis);
CREATE INDEX idx_cofinsaliq_id_cofins ON cofinsaliq(id_cofins);
CREATE INDEX idx_icmstot_id_total ON icmstot(id_total);
CREATE INDEX idx_transp_id_infnfe ON transp(id_infnfe);
CREATE INDEX idx_vol_id_transp ON vol(id_transp);
CREATE INDEX idx_fat_id_cobr ON fat(id_cobr);
CREATE INDEX idx_dup_id_cobr ON dup(id_cobr);
CREATE INDEX idx_dup_id_cobr ON dup(id_cobr);
CREATE INDEX idx_detpag_id_pag ON detpag(id_pag);
CREATE INDEX idx_card_id_detpag ON card(id_detpag);
CREATE INDEX idx_infadic_id_infnfe ON infadic(id_infnfe);
CREATE INDEX idx_infresptec_id_infnfe ON infresptec(id_infnfe);
CREATE INDEX idx_signature_id_nfe ON signature(id_nfe);
CREATE INDEX idx_reference_id_signedinfo ON reference(id_signedinfo);
CREATE INDEX idx_x509data_id_keyinfo ON x509data(id_keyinfo);

-- Fim do script SQL