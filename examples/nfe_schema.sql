-- Generated SQL Schema from XML Structure
-- =========================================

-- Table: nfeproc
CREATE TABLE nfeproc (
  id SERIAL PRIMARY KEY
);

-- Table: nfeproc_nfe
CREATE TABLE nfeproc_nfe (
  id SERIAL PRIMARY KEY,
  nfeproc_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe
CREATE TABLE nfeproc_nfe_infnfe (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_ide
CREATE TABLE nfeproc_nfe_infnfe_ide (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL,
  cuf INTEGER,
  cnf INTEGER,
  natop TEXT,
  mod INTEGER,
  serie INTEGER,
  nnf INTEGER,
  dhemi TEXT,
  dhsaient TEXT,
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
  verproc TEXT
);

-- Table: nfeproc_nfe_infnfe_emit
CREATE TABLE nfeproc_nfe_infnfe_emit (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL,
  cnpj TEXT,
  xnome TEXT,
  xfant TEXT,
  ie TEXT,
  crt INTEGER
);

-- Table: nfeproc_nfe_infnfe_emit_enderemit
CREATE TABLE nfeproc_nfe_infnfe_emit_enderemit (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_emit_id INTEGER NOT NULL,
  xlgr TEXT,
  nro INTEGER,
  xbairro TEXT,
  cmun INTEGER,
  xmun TEXT,
  uf TEXT,
  cep TEXT,
  cpais INTEGER,
  xpais TEXT,
  fone TEXT
);

-- Table: nfeproc_nfe_infnfe_dest
CREATE TABLE nfeproc_nfe_infnfe_dest (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL,
  cnpj TEXT,
  xnome TEXT,
  indiedest INTEGER,
  ie TEXT
);

-- Table: nfeproc_nfe_infnfe_dest_enderdest
CREATE TABLE nfeproc_nfe_infnfe_dest_enderdest (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_dest_id INTEGER NOT NULL,
  xlgr TEXT,
  nro INTEGER,
  xbairro TEXT,
  cmun INTEGER,
  xmun TEXT,
  uf TEXT,
  cep TEXT,
  cpais INTEGER,
  xpais TEXT,
  fone TEXT
);

-- Table: nfeproc_nfe_infnfe_entrega
CREATE TABLE nfeproc_nfe_infnfe_entrega (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL,
  cnpj TEXT,
  xlgr TEXT,
  nro INTEGER,
  xbairro TEXT,
  cmun INTEGER,
  xmun TEXT,
  uf TEXT
);

-- Table: nfeproc_nfe_infnfe_autxml
CREATE TABLE nfeproc_nfe_infnfe_autxml (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL,
  cnpj TEXT
);

-- Table: nfeproc_nfe_infnfe_det
CREATE TABLE nfeproc_nfe_infnfe_det (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_det_prod
CREATE TABLE nfeproc_nfe_infnfe_det_prod (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_id INTEGER NOT NULL,
  cprod INTEGER,
  cean TEXT,
  xprod TEXT,
  ncm INTEGER,
  cfop INTEGER,
  ucom TEXT,
  qcom INTEGER,
  vuncom DECIMAL(15,4),
  vprod DECIMAL(15,4),
  ceantrib TEXT,
  utrib TEXT,
  qtrib INTEGER,
  vuntrib DECIMAL(15,4),
  indtot INTEGER,
  xped INTEGER,
  nitemped INTEGER,
  cest INTEGER,
  indescala TEXT,
  extipi INTEGER
);

-- Table: nfeproc_nfe_infnfe_det_imposto
CREATE TABLE nfeproc_nfe_infnfe_det_imposto (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_det_imposto_icms
CREATE TABLE nfeproc_nfe_infnfe_det_imposto_icms (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_imposto_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_det_imposto_icms_icms20
CREATE TABLE nfeproc_nfe_infnfe_det_imposto_icms_icms20 (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_imposto_icms_id INTEGER NOT NULL,
  orig INTEGER,
  cst INTEGER,
  modbc INTEGER,
  predbc DECIMAL(15,4),
  vbc DECIMAL(15,4),
  picms DECIMAL(15,4),
  vicms DECIMAL(15,4)
);

-- Table: nfeproc_nfe_infnfe_det_imposto_ipi
CREATE TABLE nfeproc_nfe_infnfe_det_imposto_ipi (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_imposto_id INTEGER NOT NULL,
  cenq INTEGER
);

-- Table: nfeproc_nfe_infnfe_det_imposto_ipi_ipitrib
CREATE TABLE nfeproc_nfe_infnfe_det_imposto_ipi_ipitrib (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_imposto_ipi_id INTEGER NOT NULL,
  cst INTEGER,
  vbc DECIMAL(15,4),
  pipi DECIMAL(15,4),
  vipi DECIMAL(15,4)
);

-- Table: nfeproc_nfe_infnfe_det_imposto_pis
CREATE TABLE nfeproc_nfe_infnfe_det_imposto_pis (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_imposto_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_det_imposto_pis_pisaliq
CREATE TABLE nfeproc_nfe_infnfe_det_imposto_pis_pisaliq (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_imposto_pis_id INTEGER NOT NULL,
  cst INTEGER,
  vbc DECIMAL(15,4),
  ppis DECIMAL(15,4),
  vpis DECIMAL(15,4)
);

-- Table: nfeproc_nfe_infnfe_det_imposto_cofins
CREATE TABLE nfeproc_nfe_infnfe_det_imposto_cofins (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_imposto_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_det_imposto_cofins_cofinsaliq
CREATE TABLE nfeproc_nfe_infnfe_det_imposto_cofins_cofinsaliq (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_det_imposto_cofins_id INTEGER NOT NULL,
  cst INTEGER,
  vbc DECIMAL(15,4),
  pcofins DECIMAL(15,4),
  vcofins DECIMAL(15,4)
);

-- Table: nfeproc_nfe_infnfe_total
CREATE TABLE nfeproc_nfe_infnfe_total (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_total_icmstot
CREATE TABLE nfeproc_nfe_infnfe_total_icmstot (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_total_id INTEGER NOT NULL,
  vbc DECIMAL(15,4),
  vicms DECIMAL(15,4),
  vicmsdeson INTEGER,
  vfcp INTEGER,
  vbcst INTEGER,
  vst INTEGER,
  vfcpst INTEGER,
  vfcpstret INTEGER,
  vprod DECIMAL(15,4),
  vfrete INTEGER,
  vseg INTEGER,
  vdesc INTEGER,
  vii INTEGER,
  vipi DECIMAL(15,4),
  vipidevol INTEGER,
  vpis DECIMAL(15,4),
  vcofins DECIMAL(15,4),
  voutro INTEGER,
  vnf DECIMAL(15,4),
  vtottrib INTEGER
);

-- Table: nfeproc_nfe_infnfe_transp
CREATE TABLE nfeproc_nfe_infnfe_transp (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL,
  modfrete INTEGER
);

-- Table: nfeproc_nfe_infnfe_transp_vol
CREATE TABLE nfeproc_nfe_infnfe_transp_vol (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_transp_id INTEGER NOT NULL,
  nvol INTEGER,
  pesol DECIMAL(15,4),
  pesob DECIMAL(15,4)
);

-- Table: nfeproc_nfe_infnfe_cobr
CREATE TABLE nfeproc_nfe_infnfe_cobr (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_cobr_fat
CREATE TABLE nfeproc_nfe_infnfe_cobr_fat (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_cobr_id INTEGER NOT NULL,
  nfat INTEGER,
  vorig DECIMAL(15,4),
  vdesc INTEGER,
  vliq DECIMAL(15,4)
);

-- Table: nfeproc_nfe_infnfe_cobr_dup
CREATE TABLE nfeproc_nfe_infnfe_cobr_dup (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_cobr_id INTEGER NOT NULL,
  ndup INTEGER,
  dvenc TEXT,
  vdup DECIMAL(15,4)
);

-- Table: nfeproc_nfe_infnfe_pag
CREATE TABLE nfeproc_nfe_infnfe_pag (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_infnfe_pag_detpag
CREATE TABLE nfeproc_nfe_infnfe_pag_detpag (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_pag_id INTEGER NOT NULL,
  indpag INTEGER,
  tpag INTEGER,
  vpag DECIMAL(15,4)
);

-- Table: nfeproc_nfe_infnfe_pag_detpag_card
CREATE TABLE nfeproc_nfe_infnfe_pag_detpag_card (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_pag_detpag_id INTEGER NOT NULL,
  tpintegra INTEGER,
  cnpj TEXT,
  tband INTEGER,
  caut INTEGER
);

-- Table: nfeproc_nfe_infnfe_infadic
CREATE TABLE nfeproc_nfe_infnfe_infadic (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL,
  infcpl TEXT
);

-- Table: nfeproc_nfe_infnfe_infresptec
CREATE TABLE nfeproc_nfe_infnfe_infresptec (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_infnfe_id INTEGER NOT NULL,
  cnpj TEXT,
  xcontato TEXT,
  email TEXT,
  fone TEXT
);

-- Table: nfeproc_nfe_signature
CREATE TABLE nfeproc_nfe_signature (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_id INTEGER NOT NULL,
  signaturevalue TEXT
);

-- Table: nfeproc_nfe_signature_signedinfo
CREATE TABLE nfeproc_nfe_signature_signedinfo (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_signature_id INTEGER NOT NULL,
  canonicalizationmethod TEXT,
  signaturemethod TEXT
);

-- Table: nfeproc_nfe_signature_signedinfo_reference
CREATE TABLE nfeproc_nfe_signature_signedinfo_reference (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_signature_signedinfo_id INTEGER NOT NULL,
  digestmethod TEXT,
  digestvalue TEXT
);

-- Table: nfeproc_nfe_signature_signedinfo_reference_transforms
CREATE TABLE nfeproc_nfe_signature_signedinfo_reference_transforms (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_signature_signedinfo_reference_id INTEGER NOT NULL,
  transform TEXT
);

-- Table: nfeproc_nfe_signature_keyinfo
CREATE TABLE nfeproc_nfe_signature_keyinfo (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_signature_id INTEGER NOT NULL
);

-- Table: nfeproc_nfe_signature_keyinfo_x509data
CREATE TABLE nfeproc_nfe_signature_keyinfo_x509data (
  id SERIAL PRIMARY KEY,
  nfeproc_nfe_signature_keyinfo_id INTEGER NOT NULL,
  x509certificate TEXT
);

-- Table: nfeproc_protnfe
CREATE TABLE nfeproc_protnfe (
  id SERIAL PRIMARY KEY,
  nfeproc_id INTEGER NOT NULL
);

-- Table: nfeproc_protnfe_infprot
CREATE TABLE nfeproc_protnfe_infprot (
  id SERIAL PRIMARY KEY,
  nfeproc_protnfe_id INTEGER NOT NULL,
  tpamb INTEGER,
  veraplic INTEGER,
  chnfe TEXT,
  dhrecbto TEXT,
  nprot INTEGER,
  digval TEXT,
  cstat INTEGER,
  xmotivo TEXT
);

-- Foreign Key Constraints
-- =======================

ALTER TABLE nfeproc_nfe
ADD CONSTRAINT fk_nfeproc_nfe_nfeproc
FOREIGN KEY (nfeproc_id) REFERENCES nfeproc(id);

ALTER TABLE nfeproc_nfe_infnfe
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_nfeproc_nfe
FOREIGN KEY (nfeproc_nfe_id) REFERENCES nfeproc_nfe(id);

ALTER TABLE nfeproc_nfe_infnfe_ide
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_ide_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_emit
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_emit_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_emit_enderemit
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_emit_enderemit_nfeproc_nfe_infnfe_emit
FOREIGN KEY (nfeproc_nfe_infnfe_emit_id) REFERENCES nfeproc_nfe_infnfe_emit(id);

ALTER TABLE nfeproc_nfe_infnfe_dest
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_dest_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_dest_enderdest
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_dest_enderdest_nfeproc_nfe_infnfe_dest
FOREIGN KEY (nfeproc_nfe_infnfe_dest_id) REFERENCES nfeproc_nfe_infnfe_dest(id);

ALTER TABLE nfeproc_nfe_infnfe_entrega
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_entrega_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_autxml
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_autxml_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_det
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_det_prod
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_prod_nfeproc_nfe_infnfe_det
FOREIGN KEY (nfeproc_nfe_infnfe_det_id) REFERENCES nfeproc_nfe_infnfe_det(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_nfeproc_nfe_infnfe_det
FOREIGN KEY (nfeproc_nfe_infnfe_det_id) REFERENCES nfeproc_nfe_infnfe_det(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_icms
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_icms_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_icms_icms20
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_icms_icms20_nfeproc_nfe_infnfe_det_imposto_icms
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_icms_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_icms(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_ipi
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_ipi_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_ipi_ipitrib
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_ipi_ipitrib_nfeproc_nfe_infnfe_det_imposto_ipi
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_ipi_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_ipi(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_pis
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_pis_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_pis_pisaliq
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_pis_pisaliq_nfeproc_nfe_infnfe_det_imposto_pis
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_pis_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_pis(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_cofins
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_cofins_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_cofins_cofinsaliq
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_cofins_cofinsaliq_nfeproc_nfe_infnfe_det_imposto_cofins
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_cofins_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_cofins(id);

ALTER TABLE nfeproc_nfe_infnfe_det
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_det_prod
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_prod_nfeproc_nfe_infnfe_det
FOREIGN KEY (nfeproc_nfe_infnfe_det_id) REFERENCES nfeproc_nfe_infnfe_det(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_nfeproc_nfe_infnfe_det
FOREIGN KEY (nfeproc_nfe_infnfe_det_id) REFERENCES nfeproc_nfe_infnfe_det(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_icms
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_icms_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_icms_icms20
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_icms_icms20_nfeproc_nfe_infnfe_det_imposto_icms
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_icms_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_icms(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_ipi
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_ipi_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_ipi_ipitrib
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_ipi_ipitrib_nfeproc_nfe_infnfe_det_imposto_ipi
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_ipi_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_ipi(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_pis
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_pis_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_pis_pisaliq
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_pis_pisaliq_nfeproc_nfe_infnfe_det_imposto_pis
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_pis_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_pis(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_cofins
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_cofins_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_cofins_cofinsaliq
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_cofins_cofinsaliq_nfeproc_nfe_infnfe_det_imposto_cofins
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_cofins_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_cofins(id);

ALTER TABLE nfeproc_nfe_infnfe_det
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_det_prod
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_prod_nfeproc_nfe_infnfe_det
FOREIGN KEY (nfeproc_nfe_infnfe_det_id) REFERENCES nfeproc_nfe_infnfe_det(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_nfeproc_nfe_infnfe_det
FOREIGN KEY (nfeproc_nfe_infnfe_det_id) REFERENCES nfeproc_nfe_infnfe_det(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_icms
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_icms_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_icms_icms20
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_icms_icms20_nfeproc_nfe_infnfe_det_imposto_icms
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_icms_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_icms(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_ipi
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_ipi_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_ipi_ipitrib
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_ipi_ipitrib_nfeproc_nfe_infnfe_det_imposto_ipi
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_ipi_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_ipi(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_pis
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_pis_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_pis_pisaliq
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_pis_pisaliq_nfeproc_nfe_infnfe_det_imposto_pis
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_pis_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_pis(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_cofins
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_cofins_nfeproc_nfe_infnfe_det_imposto
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_id) REFERENCES nfeproc_nfe_infnfe_det_imposto(id);

ALTER TABLE nfeproc_nfe_infnfe_det_imposto_cofins_cofinsaliq
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_det_imposto_cofins_cofinsaliq_nfeproc_nfe_infnfe_det_imposto_cofins
FOREIGN KEY (nfeproc_nfe_infnfe_det_imposto_cofins_id) REFERENCES nfeproc_nfe_infnfe_det_imposto_cofins(id);

ALTER TABLE nfeproc_nfe_infnfe_total
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_total_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_total_icmstot
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_total_icmstot_nfeproc_nfe_infnfe_total
FOREIGN KEY (nfeproc_nfe_infnfe_total_id) REFERENCES nfeproc_nfe_infnfe_total(id);

ALTER TABLE nfeproc_nfe_infnfe_transp
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_transp_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_transp_vol
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_transp_vol_nfeproc_nfe_infnfe_transp
FOREIGN KEY (nfeproc_nfe_infnfe_transp_id) REFERENCES nfeproc_nfe_infnfe_transp(id);

ALTER TABLE nfeproc_nfe_infnfe_cobr
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_cobr_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_cobr_fat
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_cobr_fat_nfeproc_nfe_infnfe_cobr
FOREIGN KEY (nfeproc_nfe_infnfe_cobr_id) REFERENCES nfeproc_nfe_infnfe_cobr(id);

ALTER TABLE nfeproc_nfe_infnfe_cobr_dup
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_cobr_dup_nfeproc_nfe_infnfe_cobr
FOREIGN KEY (nfeproc_nfe_infnfe_cobr_id) REFERENCES nfeproc_nfe_infnfe_cobr(id);

ALTER TABLE nfeproc_nfe_infnfe_cobr_dup
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_cobr_dup_nfeproc_nfe_infnfe_cobr
FOREIGN KEY (nfeproc_nfe_infnfe_cobr_id) REFERENCES nfeproc_nfe_infnfe_cobr(id);

ALTER TABLE nfeproc_nfe_infnfe_pag
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_pag_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_pag_detpag
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_pag_detpag_nfeproc_nfe_infnfe_pag
FOREIGN KEY (nfeproc_nfe_infnfe_pag_id) REFERENCES nfeproc_nfe_infnfe_pag(id);

ALTER TABLE nfeproc_nfe_infnfe_pag_detpag_card
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_pag_detpag_card_nfeproc_nfe_infnfe_pag_detpag
FOREIGN KEY (nfeproc_nfe_infnfe_pag_detpag_id) REFERENCES nfeproc_nfe_infnfe_pag_detpag(id);

ALTER TABLE nfeproc_nfe_infnfe_infadic
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_infadic_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_infnfe_infresptec
ADD CONSTRAINT fk_nfeproc_nfe_infnfe_infresptec_nfeproc_nfe_infnfe
FOREIGN KEY (nfeproc_nfe_infnfe_id) REFERENCES nfeproc_nfe_infnfe(id);

ALTER TABLE nfeproc_nfe_signature
ADD CONSTRAINT fk_nfeproc_nfe_signature_nfeproc_nfe
FOREIGN KEY (nfeproc_nfe_id) REFERENCES nfeproc_nfe(id);

ALTER TABLE nfeproc_nfe_signature_signedinfo
ADD CONSTRAINT fk_nfeproc_nfe_signature_signedinfo_nfeproc_nfe_signature
FOREIGN KEY (nfeproc_nfe_signature_id) REFERENCES nfeproc_nfe_signature(id);

ALTER TABLE nfeproc_nfe_signature_signedinfo_reference
ADD CONSTRAINT fk_nfeproc_nfe_signature_signedinfo_reference_nfeproc_nfe_signature_signedinfo
FOREIGN KEY (nfeproc_nfe_signature_signedinfo_id) REFERENCES nfeproc_nfe_signature_signedinfo(id);

ALTER TABLE nfeproc_nfe_signature_signedinfo_reference_transforms
ADD CONSTRAINT fk_nfeproc_nfe_signature_signedinfo_reference_transforms_nfeproc_nfe_signature_signedinfo_reference
FOREIGN KEY (nfeproc_nfe_signature_signedinfo_reference_id) REFERENCES nfeproc_nfe_signature_signedinfo_reference(id);

ALTER TABLE nfeproc_nfe_signature_keyinfo
ADD CONSTRAINT fk_nfeproc_nfe_signature_keyinfo_nfeproc_nfe_signature
FOREIGN KEY (nfeproc_nfe_signature_id) REFERENCES nfeproc_nfe_signature(id);

ALTER TABLE nfeproc_nfe_signature_keyinfo_x509data
ADD CONSTRAINT fk_nfeproc_nfe_signature_keyinfo_x509data_nfeproc_nfe_signature_keyinfo
FOREIGN KEY (nfeproc_nfe_signature_keyinfo_id) REFERENCES nfeproc_nfe_signature_keyinfo(id);

ALTER TABLE nfeproc_protnfe
ADD CONSTRAINT fk_nfeproc_protnfe_nfeproc
FOREIGN KEY (nfeproc_id) REFERENCES nfeproc(id);

ALTER TABLE nfeproc_protnfe_infprot
ADD CONSTRAINT fk_nfeproc_protnfe_infprot_nfeproc_protnfe
FOREIGN KEY (nfeproc_protnfe_id) REFERENCES nfeproc_protnfe(id);

-- Schema Statistics:
-- Tables: 41
-- Fields: 154
-- Relationships: 63
