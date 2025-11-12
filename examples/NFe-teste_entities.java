package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "nfe")
public class Nfe {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_nfe")
    private Long id;

    @Column(name = "versao")
    private BigDecimal versao;

    @Column(name = "id")
    private String id;

    public Nfe() {
        // Construtor padrão exigido pelo JPA
    }

    public Nfe(BigDecimal versao, String id) {
        this.versao = versao;
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getVersao() {
        return versao;
    }

    public void setVersao(BigDecimal versao) {
        this.versao = versao;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Nfe that = (Nfe) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Nfe{" +
                "id=" + id + 
                ", versao=" + versao + 
                ", id=" + id +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "ide")
public class Ide {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_ide")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_infnfe")
    private Infnfe infnfe;

    @Column(name = "cuf")
    private Integer cuf;

    @Column(name = "cnf")
    private Integer cnf;

    @Column(name = "natop")
    private String natop;

    @Column(name = "mod")
    private Integer mod;

    @Column(name = "serie")
    private Integer serie;

    @Column(name = "nnf")
    private Integer nnf;

    @Column(name = "dhemi")
    private LocalDateTime dhemi;

    @Column(name = "tpnf")
    private Integer tpnf;

    @Column(name = "iddest")
    private Integer iddest;

    @Column(name = "cmunfg")
    private Integer cmunfg;

    @Column(name = "tpimp")
    private Integer tpimp;

    @Column(name = "tpemis")
    private Integer tpemis;

    @Column(name = "cdv")
    private Integer cdv;

    @Column(name = "tpamb")
    private Integer tpamb;

    @Column(name = "finnfe")
    private Integer finnfe;

    @Column(name = "indfinal")
    private Integer indfinal;

    @Column(name = "indpres")
    private Integer indpres;

    @Column(name = "procemi")
    private Integer procemi;

    @Column(name = "verproc")
    private BigDecimal verproc;

    public Ide() {
        // Construtor padrão exigido pelo JPA
    }

    public Ide(Integer cuf, Integer cnf, String natop, Integer mod, Integer serie, Integer nnf, LocalDateTime dhemi, Integer tpnf, Integer iddest, Integer cmunfg, Integer tpimp, Integer tpemis, Integer cdv, Integer tpamb, Integer finnfe, Integer indfinal, Integer indpres, Integer procemi, BigDecimal verproc) {
        this.cuf = cuf;
        this.cnf = cnf;
        this.natop = natop;
        this.mod = mod;
        this.serie = serie;
        this.nnf = nnf;
        this.dhemi = dhemi;
        this.tpnf = tpnf;
        this.iddest = iddest;
        this.cmunfg = cmunfg;
        this.tpimp = tpimp;
        this.tpemis = tpemis;
        this.cdv = cdv;
        this.tpamb = tpamb;
        this.finnfe = finnfe;
        this.indfinal = indfinal;
        this.indpres = indpres;
        this.procemi = procemi;
        this.verproc = verproc;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdinfnfe() {
        return idInfnfe;
    }

    public void setIdinfnfe(Long idInfnfe) {
        this.idInfnfe = idInfnfe;
    }

    public Integer getCuf() {
        return cuf;
    }

    public void setCuf(Integer cuf) {
        this.cuf = cuf;
    }

    public Integer getCnf() {
        return cnf;
    }

    public void setCnf(Integer cnf) {
        this.cnf = cnf;
    }

    public String getNatop() {
        return natop;
    }

    public void setNatop(String natop) {
        this.natop = natop;
    }

    public Integer getMod() {
        return mod;
    }

    public void setMod(Integer mod) {
        this.mod = mod;
    }

    public Integer getSerie() {
        return serie;
    }

    public void setSerie(Integer serie) {
        this.serie = serie;
    }

    public Integer getNnf() {
        return nnf;
    }

    public void setNnf(Integer nnf) {
        this.nnf = nnf;
    }

    public LocalDateTime getDhemi() {
        return dhemi;
    }

    public void setDhemi(LocalDateTime dhemi) {
        this.dhemi = dhemi;
    }

    public Integer getTpnf() {
        return tpnf;
    }

    public void setTpnf(Integer tpnf) {
        this.tpnf = tpnf;
    }

    public Integer getIddest() {
        return iddest;
    }

    public void setIddest(Integer iddest) {
        this.iddest = iddest;
    }

    public Integer getCmunfg() {
        return cmunfg;
    }

    public void setCmunfg(Integer cmunfg) {
        this.cmunfg = cmunfg;
    }

    public Integer getTpimp() {
        return tpimp;
    }

    public void setTpimp(Integer tpimp) {
        this.tpimp = tpimp;
    }

    public Integer getTpemis() {
        return tpemis;
    }

    public void setTpemis(Integer tpemis) {
        this.tpemis = tpemis;
    }

    public Integer getCdv() {
        return cdv;
    }

    public void setCdv(Integer cdv) {
        this.cdv = cdv;
    }

    public Integer getTpamb() {
        return tpamb;
    }

    public void setTpamb(Integer tpamb) {
        this.tpamb = tpamb;
    }

    public Integer getFinnfe() {
        return finnfe;
    }

    public void setFinnfe(Integer finnfe) {
        this.finnfe = finnfe;
    }

    public Integer getIndfinal() {
        return indfinal;
    }

    public void setIndfinal(Integer indfinal) {
        this.indfinal = indfinal;
    }

    public Integer getIndpres() {
        return indpres;
    }

    public void setIndpres(Integer indpres) {
        this.indpres = indpres;
    }

    public Integer getProcemi() {
        return procemi;
    }

    public void setProcemi(Integer procemi) {
        this.procemi = procemi;
    }

    public BigDecimal getVerproc() {
        return verproc;
    }

    public void setVerproc(BigDecimal verproc) {
        this.verproc = verproc;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Ide that = (Ide) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Ide{" +
                "id=" + id + 
                ", cuf=" + cuf + 
                ", cnf=" + cnf + 
                ", natop=" + natop + 
                ", mod=" + mod + 
                ", serie=" + serie + 
                ", nnf=" + nnf + 
                ", dhemi=" + dhemi + 
                ", tpnf=" + tpnf + 
                ", iddest=" + iddest + 
                ", cmunfg=" + cmunfg + 
                ", tpimp=" + tpimp + 
                ", tpemis=" + tpemis + 
                ", cdv=" + cdv + 
                ", tpamb=" + tpamb + 
                ", finnfe=" + finnfe + 
                ", indfinal=" + indfinal + 
                ", indpres=" + indpres + 
                ", procemi=" + procemi + 
                ", verproc=" + verproc +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "emit")
public class Emit {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_emit")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_infnfe")
    private Infnfe infnfe;

    @Column(name = "cnpj")
    private Integer cnpj;

    @Column(name = "xnome")
    private String xnome;

    @Column(name = "ie")
    private Integer ie;

    @Column(name = "crt")
    private Integer crt;

    public Emit() {
        // Construtor padrão exigido pelo JPA
    }

    public Emit(Integer cnpj, String xnome, Integer ie, Integer crt) {
        this.cnpj = cnpj;
        this.xnome = xnome;
        this.ie = ie;
        this.crt = crt;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdinfnfe() {
        return idInfnfe;
    }

    public void setIdinfnfe(Long idInfnfe) {
        this.idInfnfe = idInfnfe;
    }

    public Integer getCnpj() {
        return cnpj;
    }

    public void setCnpj(Integer cnpj) {
        this.cnpj = cnpj;
    }

    public String getXnome() {
        return xnome;
    }

    public void setXnome(String xnome) {
        this.xnome = xnome;
    }

    public Integer getIe() {
        return ie;
    }

    public void setIe(Integer ie) {
        this.ie = ie;
    }

    public Integer getCrt() {
        return crt;
    }

    public void setCrt(Integer crt) {
        this.crt = crt;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Emit that = (Emit) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Emit{" +
                "id=" + id + 
                ", cnpj=" + cnpj + 
                ", xnome=" + xnome + 
                ", ie=" + ie + 
                ", crt=" + crt +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "enderemit")
public class Enderemit {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_enderemit")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_emit")
    private Emit emit;

    @Column(name = "xlgr")
    private String xlgr;

    @Column(name = "nro")
    private Integer nro;

    @Column(name = "xcpl")
    private String xcpl;

    @Column(name = "xbairro")
    private String xbairro;

    @Column(name = "cmun")
    private Integer cmun;

    @Column(name = "xmun")
    private String xmun;

    @Column(name = "uf")
    private String uf;

    @Column(name = "cep")
    private Integer cep;

    @Column(name = "cpais")
    private Integer cpais;

    @Column(name = "xpais")
    private String xpais;

    @Column(name = "fone")
    private Integer fone;

    public Enderemit() {
        // Construtor padrão exigido pelo JPA
    }

    public Enderemit(String xlgr, Integer nro, String xcpl, String xbairro, Integer cmun, String xmun, String uf, Integer cep, Integer cpais, String xpais, Integer fone) {
        this.xlgr = xlgr;
        this.nro = nro;
        this.xcpl = xcpl;
        this.xbairro = xbairro;
        this.cmun = cmun;
        this.xmun = xmun;
        this.uf = uf;
        this.cep = cep;
        this.cpais = cpais;
        this.xpais = xpais;
        this.fone = fone;
    }

    public Emit getEmit() {
        return emit;
    }

    public void setEmit(Emit emit) {
        this.emit = emit;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdemit() {
        return idEmit;
    }

    public void setIdemit(Long idEmit) {
        this.idEmit = idEmit;
    }

    public String getXlgr() {
        return xlgr;
    }

    public void setXlgr(String xlgr) {
        this.xlgr = xlgr;
    }

    public Integer getNro() {
        return nro;
    }

    public void setNro(Integer nro) {
        this.nro = nro;
    }

    public String getXcpl() {
        return xcpl;
    }

    public void setXcpl(String xcpl) {
        this.xcpl = xcpl;
    }

    public String getXbairro() {
        return xbairro;
    }

    public void setXbairro(String xbairro) {
        this.xbairro = xbairro;
    }

    public Integer getCmun() {
        return cmun;
    }

    public void setCmun(Integer cmun) {
        this.cmun = cmun;
    }

    public String getXmun() {
        return xmun;
    }

    public void setXmun(String xmun) {
        this.xmun = xmun;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    public Integer getCep() {
        return cep;
    }

    public void setCep(Integer cep) {
        this.cep = cep;
    }

    public Integer getCpais() {
        return cpais;
    }

    public void setCpais(Integer cpais) {
        this.cpais = cpais;
    }

    public String getXpais() {
        return xpais;
    }

    public void setXpais(String xpais) {
        this.xpais = xpais;
    }

    public Integer getFone() {
        return fone;
    }

    public void setFone(Integer fone) {
        this.fone = fone;
    }

    public Emit getEmit() {
        return emit;
    }

    public void setEmit(Emit emit) {
        this.emit = emit;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Enderemit that = (Enderemit) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Enderemit{" +
                "id=" + id + 
                ", xlgr=" + xlgr + 
                ", nro=" + nro + 
                ", xcpl=" + xcpl + 
                ", xbairro=" + xbairro + 
                ", cmun=" + cmun + 
                ", xmun=" + xmun + 
                ", uf=" + uf + 
                ", cep=" + cep + 
                ", cpais=" + cpais + 
                ", xpais=" + xpais + 
                ", fone=" + fone +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "dest")
public class Dest {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_dest")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_infnfe")
    private Infnfe infnfe;

    @Column(name = "cnpj")
    private Integer cnpj;

    @Column(name = "xnome")
    private String xnome;

    @Column(name = "indiedest")
    private Integer indiedest;

    @Column(name = "email")
    private String email;

    public Dest() {
        // Construtor padrão exigido pelo JPA
    }

    public Dest(Integer cnpj, String xnome, Integer indiedest, String email) {
        this.cnpj = cnpj;
        this.xnome = xnome;
        this.indiedest = indiedest;
        this.email = email;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdinfnfe() {
        return idInfnfe;
    }

    public void setIdinfnfe(Long idInfnfe) {
        this.idInfnfe = idInfnfe;
    }

    public Integer getCnpj() {
        return cnpj;
    }

    public void setCnpj(Integer cnpj) {
        this.cnpj = cnpj;
    }

    public String getXnome() {
        return xnome;
    }

    public void setXnome(String xnome) {
        this.xnome = xnome;
    }

    public Integer getIndiedest() {
        return indiedest;
    }

    public void setIndiedest(Integer indiedest) {
        this.indiedest = indiedest;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Dest that = (Dest) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Dest{" +
                "id=" + id + 
                ", cnpj=" + cnpj + 
                ", xnome=" + xnome + 
                ", indiedest=" + indiedest + 
                ", email=" + email +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "enderdest")
public class Enderdest {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_enderdest")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_dest")
    private Dest dest;

    @Column(name = "xlgr")
    private String xlgr;

    @Column(name = "nro")
    private Integer nro;

    @Column(name = "xbairro")
    private String xbairro;

    @Column(name = "cmun")
    private Integer cmun;

    @Column(name = "xmun")
    private String xmun;

    @Column(name = "uf")
    private String uf;

    @Column(name = "cep")
    private Integer cep;

    @Column(name = "cpais")
    private Integer cpais;

    @Column(name = "xpais")
    private String xpais;

    @Column(name = "fone")
    private Integer fone;

    public Enderdest() {
        // Construtor padrão exigido pelo JPA
    }

    public Enderdest(String xlgr, Integer nro, String xbairro, Integer cmun, String xmun, String uf, Integer cep, Integer cpais, String xpais, Integer fone) {
        this.xlgr = xlgr;
        this.nro = nro;
        this.xbairro = xbairro;
        this.cmun = cmun;
        this.xmun = xmun;
        this.uf = uf;
        this.cep = cep;
        this.cpais = cpais;
        this.xpais = xpais;
        this.fone = fone;
    }

    public Dest getDest() {
        return dest;
    }

    public void setDest(Dest dest) {
        this.dest = dest;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIddest() {
        return idDest;
    }

    public void setIddest(Long idDest) {
        this.idDest = idDest;
    }

    public String getXlgr() {
        return xlgr;
    }

    public void setXlgr(String xlgr) {
        this.xlgr = xlgr;
    }

    public Integer getNro() {
        return nro;
    }

    public void setNro(Integer nro) {
        this.nro = nro;
    }

    public String getXbairro() {
        return xbairro;
    }

    public void setXbairro(String xbairro) {
        this.xbairro = xbairro;
    }

    public Integer getCmun() {
        return cmun;
    }

    public void setCmun(Integer cmun) {
        this.cmun = cmun;
    }

    public String getXmun() {
        return xmun;
    }

    public void setXmun(String xmun) {
        this.xmun = xmun;
    }

    public String getUf() {
        return uf;
    }

    public void setUf(String uf) {
        this.uf = uf;
    }

    public Integer getCep() {
        return cep;
    }

    public void setCep(Integer cep) {
        this.cep = cep;
    }

    public Integer getCpais() {
        return cpais;
    }

    public void setCpais(Integer cpais) {
        this.cpais = cpais;
    }

    public String getXpais() {
        return xpais;
    }

    public void setXpais(String xpais) {
        this.xpais = xpais;
    }

    public Integer getFone() {
        return fone;
    }

    public void setFone(Integer fone) {
        this.fone = fone;
    }

    public Dest getDest() {
        return dest;
    }

    public void setDest(Dest dest) {
        this.dest = dest;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Enderdest that = (Enderdest) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Enderdest{" +
                "id=" + id + 
                ", xlgr=" + xlgr + 
                ", nro=" + nro + 
                ", xbairro=" + xbairro + 
                ", cmun=" + cmun + 
                ", xmun=" + xmun + 
                ", uf=" + uf + 
                ", cep=" + cep + 
                ", cpais=" + cpais + 
                ", xpais=" + xpais + 
                ", fone=" + fone +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "autxml")
public class Autxml {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_autxml")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_infnfe")
    private Infnfe infnfe;

    @Column(name = "cnpj")
    private Integer cnpj;

    public Autxml() {
        // Construtor padrão exigido pelo JPA
    }

    public Autxml(Integer cnpj) {
        this.cnpj = cnpj;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdinfnfe() {
        return idInfnfe;
    }

    public void setIdinfnfe(Long idInfnfe) {
        this.idInfnfe = idInfnfe;
    }

    public Integer getCnpj() {
        return cnpj;
    }

    public void setCnpj(Integer cnpj) {
        this.cnpj = cnpj;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Autxml that = (Autxml) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Autxml{" +
                "id=" + id + 
                ", cnpj=" + cnpj +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "infnfe")
public class Infnfe {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_infnfe")
    private Long id;

    @Column(name = "nitem")
    private Integer nitem;

    public Infnfe() {
        // Construtor padrão exigido pelo JPA
    }

    public Infnfe(Integer nitem) {
        this.nitem = nitem;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getNitem() {
        return nitem;
    }

    public void setNitem(Integer nitem) {
        this.nitem = nitem;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Infnfe that = (Infnfe) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Infnfe{" +
                "id=" + id + 
                ", nitem=" + nitem +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "prod")
public class Prod {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_prod")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_det")
    private Det det;

    @Column(name = "cprod")
    private Integer cprod;

    @Column(name = "cean")
    private Integer cean;

    @Column(name = "xprod")
    private String xprod;

    @Column(name = "ncm")
    private Integer ncm;

    @Column(name = "cest")
    private Integer cest;

    @Column(name = "indescala")
    private String indescala;

    @Column(name = "cfop")
    private Integer cfop;

    @Column(name = "ucom")
    private String ucom;

    @Column(name = "qcom")
    private BigDecimal qcom;

    @Column(name = "vuncom")
    private BigDecimal vuncom;

    @Column(name = "vprod")
    private BigDecimal vprod;

    @Column(name = "ceantrib")
    private Integer ceantrib;

    @Column(name = "utrib")
    private String utrib;

    @Column(name = "qtrib")
    private BigDecimal qtrib;

    @Column(name = "vuntrib")
    private BigDecimal vuntrib;

    @Column(name = "indtot")
    private Integer indtot;

    public Prod() {
        // Construtor padrão exigido pelo JPA
    }

    public Prod(Integer cprod, Integer cean, String xprod, Integer ncm, Integer cest, String indescala, Integer cfop, String ucom, BigDecimal qcom, BigDecimal vuncom, BigDecimal vprod, Integer ceantrib, String utrib, BigDecimal qtrib, BigDecimal vuntrib, Integer indtot) {
        this.cprod = cprod;
        this.cean = cean;
        this.xprod = xprod;
        this.ncm = ncm;
        this.cest = cest;
        this.indescala = indescala;
        this.cfop = cfop;
        this.ucom = ucom;
        this.qcom = qcom;
        this.vuncom = vuncom;
        this.vprod = vprod;
        this.ceantrib = ceantrib;
        this.utrib = utrib;
        this.qtrib = qtrib;
        this.vuntrib = vuntrib;
        this.indtot = indtot;
    }

    public Det getDet() {
        return det;
    }

    public void setDet(Det det) {
        this.det = det;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIddet() {
        return idDet;
    }

    public void setIddet(Long idDet) {
        this.idDet = idDet;
    }

    public Integer getCprod() {
        return cprod;
    }

    public void setCprod(Integer cprod) {
        this.cprod = cprod;
    }

    public Integer getCean() {
        return cean;
    }

    public void setCean(Integer cean) {
        this.cean = cean;
    }

    public String getXprod() {
        return xprod;
    }

    public void setXprod(String xprod) {
        this.xprod = xprod;
    }

    public Integer getNcm() {
        return ncm;
    }

    public void setNcm(Integer ncm) {
        this.ncm = ncm;
    }

    public Integer getCest() {
        return cest;
    }

    public void setCest(Integer cest) {
        this.cest = cest;
    }

    public String getIndescala() {
        return indescala;
    }

    public void setIndescala(String indescala) {
        this.indescala = indescala;
    }

    public Integer getCfop() {
        return cfop;
    }

    public void setCfop(Integer cfop) {
        this.cfop = cfop;
    }

    public String getUcom() {
        return ucom;
    }

    public void setUcom(String ucom) {
        this.ucom = ucom;
    }

    public BigDecimal getQcom() {
        return qcom;
    }

    public void setQcom(BigDecimal qcom) {
        this.qcom = qcom;
    }

    public BigDecimal getVuncom() {
        return vuncom;
    }

    public void setVuncom(BigDecimal vuncom) {
        this.vuncom = vuncom;
    }

    public BigDecimal getVprod() {
        return vprod;
    }

    public void setVprod(BigDecimal vprod) {
        this.vprod = vprod;
    }

    public Integer getCeantrib() {
        return ceantrib;
    }

    public void setCeantrib(Integer ceantrib) {
        this.ceantrib = ceantrib;
    }

    public String getUtrib() {
        return utrib;
    }

    public void setUtrib(String utrib) {
        this.utrib = utrib;
    }

    public BigDecimal getQtrib() {
        return qtrib;
    }

    public void setQtrib(BigDecimal qtrib) {
        this.qtrib = qtrib;
    }

    public BigDecimal getVuntrib() {
        return vuntrib;
    }

    public void setVuntrib(BigDecimal vuntrib) {
        this.vuntrib = vuntrib;
    }

    public Integer getIndtot() {
        return indtot;
    }

    public void setIndtot(Integer indtot) {
        this.indtot = indtot;
    }

    public Det getDet() {
        return det;
    }

    public void setDet(Det det) {
        this.det = det;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Prod that = (Prod) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Prod{" +
                "id=" + id + 
                ", cprod=" + cprod + 
                ", cean=" + cean + 
                ", xprod=" + xprod + 
                ", ncm=" + ncm + 
                ", cest=" + cest + 
                ", indescala=" + indescala + 
                ", cfop=" + cfop + 
                ", ucom=" + ucom + 
                ", qcom=" + qcom + 
                ", vuncom=" + vuncom + 
                ", vprod=" + vprod + 
                ", ceantrib=" + ceantrib + 
                ", utrib=" + utrib + 
                ", qtrib=" + qtrib + 
                ", vuntrib=" + vuntrib + 
                ", indtot=" + indtot +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "icms00")
public class Icms00 {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_icms00")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_icms")
    private Icms icms;

    @Column(name = "orig")
    private Integer orig;

    @Column(name = "cst")
    private Integer cst;

    @Column(name = "modbc")
    private Integer modbc;

    @Column(name = "vbc")
    private BigDecimal vbc;

    @Column(name = "picms")
    private BigDecimal picms;

    @Column(name = "vicms")
    private BigDecimal vicms;

    public Icms00() {
        // Construtor padrão exigido pelo JPA
    }

    public Icms00(Integer orig, Integer cst, Integer modbc, BigDecimal vbc, BigDecimal picms, BigDecimal vicms) {
        this.orig = orig;
        this.cst = cst;
        this.modbc = modbc;
        this.vbc = vbc;
        this.picms = picms;
        this.vicms = vicms;
    }

    public Icms getIcms() {
        return icms;
    }

    public void setIcms(Icms icms) {
        this.icms = icms;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdicms() {
        return idIcms;
    }

    public void setIdicms(Long idIcms) {
        this.idIcms = idIcms;
    }

    public Integer getOrig() {
        return orig;
    }

    public void setOrig(Integer orig) {
        this.orig = orig;
    }

    public Integer getCst() {
        return cst;
    }

    public void setCst(Integer cst) {
        this.cst = cst;
    }

    public Integer getModbc() {
        return modbc;
    }

    public void setModbc(Integer modbc) {
        this.modbc = modbc;
    }

    public BigDecimal getVbc() {
        return vbc;
    }

    public void setVbc(BigDecimal vbc) {
        this.vbc = vbc;
    }

    public BigDecimal getPicms() {
        return picms;
    }

    public void setPicms(BigDecimal picms) {
        this.picms = picms;
    }

    public BigDecimal getVicms() {
        return vicms;
    }

    public void setVicms(BigDecimal vicms) {
        this.vicms = vicms;
    }

    public Icms getIcms() {
        return icms;
    }

    public void setIcms(Icms icms) {
        this.icms = icms;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Icms00 that = (Icms00) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Icms00{" +
                "id=" + id + 
                ", orig=" + orig + 
                ", cst=" + cst + 
                ", modbc=" + modbc + 
                ", vbc=" + vbc + 
                ", picms=" + picms + 
                ", vicms=" + vicms +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "pisaliq")
public class Pisaliq {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_pisaliq")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_pis")
    private Pis pis;

    @Column(name = "cst")
    private Integer cst;

    @Column(name = "vbc")
    private BigDecimal vbc;

    @Column(name = "ppis")
    private BigDecimal ppis;

    @Column(name = "vpis")
    private BigDecimal vpis;

    public Pisaliq() {
        // Construtor padrão exigido pelo JPA
    }

    public Pisaliq(Integer cst, BigDecimal vbc, BigDecimal ppis, BigDecimal vpis) {
        this.cst = cst;
        this.vbc = vbc;
        this.ppis = ppis;
        this.vpis = vpis;
    }

    public Pis getPis() {
        return pis;
    }

    public void setPis(Pis pis) {
        this.pis = pis;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdpis() {
        return idPis;
    }

    public void setIdpis(Long idPis) {
        this.idPis = idPis;
    }

    public Integer getCst() {
        return cst;
    }

    public void setCst(Integer cst) {
        this.cst = cst;
    }

    public BigDecimal getVbc() {
        return vbc;
    }

    public void setVbc(BigDecimal vbc) {
        this.vbc = vbc;
    }

    public BigDecimal getPpis() {
        return ppis;
    }

    public void setPpis(BigDecimal ppis) {
        this.ppis = ppis;
    }

    public BigDecimal getVpis() {
        return vpis;
    }

    public void setVpis(BigDecimal vpis) {
        this.vpis = vpis;
    }

    public Pis getPis() {
        return pis;
    }

    public void setPis(Pis pis) {
        this.pis = pis;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Pisaliq that = (Pisaliq) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Pisaliq{" +
                "id=" + id + 
                ", cst=" + cst + 
                ", vbc=" + vbc + 
                ", ppis=" + ppis + 
                ", vpis=" + vpis +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "cofinsaliq")
public class Cofinsaliq {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_cofinsaliq")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_cofins")
    private Cofins cofins;

    @Column(name = "cst")
    private Integer cst;

    @Column(name = "vbc")
    private BigDecimal vbc;

    @Column(name = "pcofins")
    private BigDecimal pcofins;

    @Column(name = "vcofins")
    private BigDecimal vcofins;

    public Cofinsaliq() {
        // Construtor padrão exigido pelo JPA
    }

    public Cofinsaliq(Integer cst, BigDecimal vbc, BigDecimal pcofins, BigDecimal vcofins) {
        this.cst = cst;
        this.vbc = vbc;
        this.pcofins = pcofins;
        this.vcofins = vcofins;
    }

    public Cofins getCofins() {
        return cofins;
    }

    public void setCofins(Cofins cofins) {
        this.cofins = cofins;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdcofins() {
        return idCofins;
    }

    public void setIdcofins(Long idCofins) {
        this.idCofins = idCofins;
    }

    public Integer getCst() {
        return cst;
    }

    public void setCst(Integer cst) {
        this.cst = cst;
    }

    public BigDecimal getVbc() {
        return vbc;
    }

    public void setVbc(BigDecimal vbc) {
        this.vbc = vbc;
    }

    public BigDecimal getPcofins() {
        return pcofins;
    }

    public void setPcofins(BigDecimal pcofins) {
        this.pcofins = pcofins;
    }

    public BigDecimal getVcofins() {
        return vcofins;
    }

    public void setVcofins(BigDecimal vcofins) {
        this.vcofins = vcofins;
    }

    public Cofins getCofins() {
        return cofins;
    }

    public void setCofins(Cofins cofins) {
        this.cofins = cofins;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Cofinsaliq that = (Cofinsaliq) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Cofinsaliq{" +
                "id=" + id + 
                ", cst=" + cst + 
                ", vbc=" + vbc + 
                ", pcofins=" + pcofins + 
                ", vcofins=" + vcofins +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "icmstot")
public class Icmstot {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_icmstot")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_total")
    private Total total;

    @Column(name = "vbc")
    private BigDecimal vbc;

    @Column(name = "vicms")
    private BigDecimal vicms;

    @Column(name = "vicmsdeson")
    private BigDecimal vicmsdeson;

    @Column(name = "vfcp")
    private BigDecimal vfcp;

    @Column(name = "vbcst")
    private BigDecimal vbcst;

    @Column(name = "vst")
    private BigDecimal vst;

    @Column(name = "vfcpst")
    private BigDecimal vfcpst;

    @Column(name = "vfcpstret")
    private BigDecimal vfcpstret;

    @Column(name = "vprod")
    private BigDecimal vprod;

    @Column(name = "vfrete")
    private BigDecimal vfrete;

    @Column(name = "vseg")
    private BigDecimal vseg;

    @Column(name = "vdesc")
    private BigDecimal vdesc;

    @Column(name = "vii")
    private BigDecimal vii;

    @Column(name = "vipi")
    private BigDecimal vipi;

    @Column(name = "vipidevol")
    private BigDecimal vipidevol;

    @Column(name = "vpis")
    private BigDecimal vpis;

    @Column(name = "vcofins")
    private BigDecimal vcofins;

    @Column(name = "voutro")
    private BigDecimal voutro;

    @Column(name = "vnf")
    private BigDecimal vnf;

    public Icmstot() {
        // Construtor padrão exigido pelo JPA
    }

    public Icmstot(BigDecimal vbc, BigDecimal vicms, BigDecimal vicmsdeson, BigDecimal vfcp, BigDecimal vbcst, BigDecimal vst, BigDecimal vfcpst, BigDecimal vfcpstret, BigDecimal vprod, BigDecimal vfrete, BigDecimal vseg, BigDecimal vdesc, BigDecimal vii, BigDecimal vipi, BigDecimal vipidevol, BigDecimal vpis, BigDecimal vcofins, BigDecimal voutro, BigDecimal vnf) {
        this.vbc = vbc;
        this.vicms = vicms;
        this.vicmsdeson = vicmsdeson;
        this.vfcp = vfcp;
        this.vbcst = vbcst;
        this.vst = vst;
        this.vfcpst = vfcpst;
        this.vfcpstret = vfcpstret;
        this.vprod = vprod;
        this.vfrete = vfrete;
        this.vseg = vseg;
        this.vdesc = vdesc;
        this.vii = vii;
        this.vipi = vipi;
        this.vipidevol = vipidevol;
        this.vpis = vpis;
        this.vcofins = vcofins;
        this.voutro = voutro;
        this.vnf = vnf;
    }

    public Total getTotal() {
        return total;
    }

    public void setTotal(Total total) {
        this.total = total;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdtotal() {
        return idTotal;
    }

    public void setIdtotal(Long idTotal) {
        this.idTotal = idTotal;
    }

    public BigDecimal getVbc() {
        return vbc;
    }

    public void setVbc(BigDecimal vbc) {
        this.vbc = vbc;
    }

    public BigDecimal getVicms() {
        return vicms;
    }

    public void setVicms(BigDecimal vicms) {
        this.vicms = vicms;
    }

    public BigDecimal getVicmsdeson() {
        return vicmsdeson;
    }

    public void setVicmsdeson(BigDecimal vicmsdeson) {
        this.vicmsdeson = vicmsdeson;
    }

    public BigDecimal getVfcp() {
        return vfcp;
    }

    public void setVfcp(BigDecimal vfcp) {
        this.vfcp = vfcp;
    }

    public BigDecimal getVbcst() {
        return vbcst;
    }

    public void setVbcst(BigDecimal vbcst) {
        this.vbcst = vbcst;
    }

    public BigDecimal getVst() {
        return vst;
    }

    public void setVst(BigDecimal vst) {
        this.vst = vst;
    }

    public BigDecimal getVfcpst() {
        return vfcpst;
    }

    public void setVfcpst(BigDecimal vfcpst) {
        this.vfcpst = vfcpst;
    }

    public BigDecimal getVfcpstret() {
        return vfcpstret;
    }

    public void setVfcpstret(BigDecimal vfcpstret) {
        this.vfcpstret = vfcpstret;
    }

    public BigDecimal getVprod() {
        return vprod;
    }

    public void setVprod(BigDecimal vprod) {
        this.vprod = vprod;
    }

    public BigDecimal getVfrete() {
        return vfrete;
    }

    public void setVfrete(BigDecimal vfrete) {
        this.vfrete = vfrete;
    }

    public BigDecimal getVseg() {
        return vseg;
    }

    public void setVseg(BigDecimal vseg) {
        this.vseg = vseg;
    }

    public BigDecimal getVdesc() {
        return vdesc;
    }

    public void setVdesc(BigDecimal vdesc) {
        this.vdesc = vdesc;
    }

    public BigDecimal getVii() {
        return vii;
    }

    public void setVii(BigDecimal vii) {
        this.vii = vii;
    }

    public BigDecimal getVipi() {
        return vipi;
    }

    public void setVipi(BigDecimal vipi) {
        this.vipi = vipi;
    }

    public BigDecimal getVipidevol() {
        return vipidevol;
    }

    public void setVipidevol(BigDecimal vipidevol) {
        this.vipidevol = vipidevol;
    }

    public BigDecimal getVpis() {
        return vpis;
    }

    public void setVpis(BigDecimal vpis) {
        this.vpis = vpis;
    }

    public BigDecimal getVcofins() {
        return vcofins;
    }

    public void setVcofins(BigDecimal vcofins) {
        this.vcofins = vcofins;
    }

    public BigDecimal getVoutro() {
        return voutro;
    }

    public void setVoutro(BigDecimal voutro) {
        this.voutro = voutro;
    }

    public BigDecimal getVnf() {
        return vnf;
    }

    public void setVnf(BigDecimal vnf) {
        this.vnf = vnf;
    }

    public Total getTotal() {
        return total;
    }

    public void setTotal(Total total) {
        this.total = total;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Icmstot that = (Icmstot) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Icmstot{" +
                "id=" + id + 
                ", vbc=" + vbc + 
                ", vicms=" + vicms + 
                ", vicmsdeson=" + vicmsdeson + 
                ", vfcp=" + vfcp + 
                ", vbcst=" + vbcst + 
                ", vst=" + vst + 
                ", vfcpst=" + vfcpst + 
                ", vfcpstret=" + vfcpstret + 
                ", vprod=" + vprod + 
                ", vfrete=" + vfrete + 
                ", vseg=" + vseg + 
                ", vdesc=" + vdesc + 
                ", vii=" + vii + 
                ", vipi=" + vipi + 
                ", vipidevol=" + vipidevol + 
                ", vpis=" + vpis + 
                ", vcofins=" + vcofins + 
                ", voutro=" + voutro + 
                ", vnf=" + vnf +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "transp")
public class Transp {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_transp")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_infnfe")
    private Infnfe infnfe;

    @Column(name = "modfrete")
    private Integer modfrete;

    public Transp() {
        // Construtor padrão exigido pelo JPA
    }

    public Transp(Integer modfrete) {
        this.modfrete = modfrete;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdinfnfe() {
        return idInfnfe;
    }

    public void setIdinfnfe(Long idInfnfe) {
        this.idInfnfe = idInfnfe;
    }

    public Integer getModfrete() {
        return modfrete;
    }

    public void setModfrete(Integer modfrete) {
        this.modfrete = modfrete;
    }

    public Infnfe getInfnfe() {
        return infnfe;
    }

    public void setInfnfe(Infnfe infnfe) {
        this.infnfe = infnfe;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Transp that = (Transp) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Transp{" +
                "id=" + id + 
                ", modfrete=" + modfrete +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "detpag")
public class Detpag {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_detpag")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_pag")
    private Pag pag;

    @Column(name = "tpag")
    private Integer tpag;

    @Column(name = "vpag")
    private BigDecimal vpag;

    public Detpag() {
        // Construtor padrão exigido pelo JPA
    }

    public Detpag(Integer tpag, BigDecimal vpag) {
        this.tpag = tpag;
        this.vpag = vpag;
    }

    public Pag getPag() {
        return pag;
    }

    public void setPag(Pag pag) {
        this.pag = pag;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdpag() {
        return idPag;
    }

    public void setIdpag(Long idPag) {
        this.idPag = idPag;
    }

    public Integer getTpag() {
        return tpag;
    }

    public void setTpag(Integer tpag) {
        this.tpag = tpag;
    }

    public BigDecimal getVpag() {
        return vpag;
    }

    public void setVpag(BigDecimal vpag) {
        this.vpag = vpag;
    }

    public Pag getPag() {
        return pag;
    }

    public void setPag(Pag pag) {
        this.pag = pag;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Detpag that = (Detpag) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Detpag{" +
                "id=" + id + 
                ", tpag=" + tpag + 
                ", vpag=" + vpag +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "signature")
public class Signature {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_signature")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_nfe")
    private Nfe nfe;

    @Column(name = "signaturevalue")
    private String signaturevalue;

    public Signature() {
        // Construtor padrão exigido pelo JPA
    }

    public Signature(String signaturevalue) {
        this.signaturevalue = signaturevalue;
    }

    public Nfe getNfe() {
        return nfe;
    }

    public void setNfe(Nfe nfe) {
        this.nfe = nfe;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdnfe() {
        return idNfe;
    }

    public void setIdnfe(Long idNfe) {
        this.idNfe = idNfe;
    }

    public String getSignaturevalue() {
        return signaturevalue;
    }

    public void setSignaturevalue(String signaturevalue) {
        this.signaturevalue = signaturevalue;
    }

    public Nfe getNfe() {
        return nfe;
    }

    public void setNfe(Nfe nfe) {
        this.nfe = nfe;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Signature that = (Signature) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Signature{" +
                "id=" + id + 
                ", signaturevalue=" + signaturevalue +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "signedinfo")
public class Signedinfo {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_signedinfo")
    private Long id;

    @Column(name = "algorithm")
    private String algorithm;

    @Column(name = "uri")
    private String uri;

    public Signedinfo() {
        // Construtor padrão exigido pelo JPA
    }

    public Signedinfo(String algorithm, String uri) {
        this.algorithm = algorithm;
        this.uri = uri;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAlgorithm() {
        return algorithm;
    }

    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Signedinfo that = (Signedinfo) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Signedinfo{" +
                "id=" + id + 
                ", algorithm=" + algorithm + 
                ", uri=" + uri +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "reference")
public class Reference {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_reference")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_signedinfo")
    private Signedinfo signedinfo;

    @Column(name = "algorithm")
    private String algorithm;

    @Column(name = "digestvalue")
    private String digestvalue;

    public Reference() {
        // Construtor padrão exigido pelo JPA
    }

    public Reference(String algorithm, String digestvalue) {
        this.algorithm = algorithm;
        this.digestvalue = digestvalue;
    }

    public Signedinfo getSignedinfo() {
        return signedinfo;
    }

    public void setSignedinfo(Signedinfo signedinfo) {
        this.signedinfo = signedinfo;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdsignedinfo() {
        return idSignedinfo;
    }

    public void setIdsignedinfo(Long idSignedinfo) {
        this.idSignedinfo = idSignedinfo;
    }

    public String getAlgorithm() {
        return algorithm;
    }

    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }

    public String getDigestvalue() {
        return digestvalue;
    }

    public void setDigestvalue(String digestvalue) {
        this.digestvalue = digestvalue;
    }

    public Signedinfo getSignedinfo() {
        return signedinfo;
    }

    public void setSignedinfo(Signedinfo signedinfo) {
        this.signedinfo = signedinfo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Reference that = (Reference) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Reference{" +
                "id=" + id + 
                ", algorithm=" + algorithm + 
                ", digestvalue=" + digestvalue +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "transforms")
public class Transforms {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_transforms")
    private Long id;

    @Column(name = "algorithm")
    private String algorithm;

    public Transforms() {
        // Construtor padrão exigido pelo JPA
    }

    public Transforms(String algorithm) {
        this.algorithm = algorithm;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAlgorithm() {
        return algorithm;
    }

    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Transforms that = (Transforms) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Transforms{" +
                "id=" + id + 
                ", algorithm=" + algorithm +
                '}';
    }
}

package com.example.nfe.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "x509data")
public class X509data {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hibernate_sequence")
    @SequenceGenerator(name = "hibernate_sequence", sequenceName = "hibernate_sequence")
    @Column(name = "id_x509data")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_keyinfo")
    private Keyinfo keyinfo;

    @Column(name = "x509certificate")
    private String x509certificate;

    public X509data() {
        // Construtor padrão exigido pelo JPA
    }

    public X509data(String x509certificate) {
        this.x509certificate = x509certificate;
    }

    public Keyinfo getKeyinfo() {
        return keyinfo;
    }

    public void setKeyinfo(Keyinfo keyinfo) {
        this.keyinfo = keyinfo;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdkeyinfo() {
        return idKeyinfo;
    }

    public void setIdkeyinfo(Long idKeyinfo) {
        this.idKeyinfo = idKeyinfo;
    }

    public String getX509certificate() {
        return x509certificate;
    }

    public void setX509certificate(String x509certificate) {
        this.x509certificate = x509certificate;
    }

    public Keyinfo getKeyinfo() {
        return keyinfo;
    }

    public void setKeyinfo(Keyinfo keyinfo) {
        this.keyinfo = keyinfo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        X509data that = (X509data) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "X509data{" +
                "id=" + id + 
                ", x509certificate=" + x509certificate +
                '}';
    }
}
