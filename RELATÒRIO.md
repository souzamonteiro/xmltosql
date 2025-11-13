Analisando o SQL gerado, identifiquei vários problemas nos tipos de dados:

## Problemas Principais:

### 1. **Tipos Numéricos Incorretos**
- `CNPJ` como `NUMERIC(20,0)` - deveria ser `VARCHAR(14)`
- `IE` (Inscrição Estadual) como `BIGINT` - deveria ser `VARCHAR(20)`
- `CEP` como `BIGINT` - deveria ser `VARCHAR(8)`
- `Fone` como `NUMERIC(20,0)` - deveria ser `VARCHAR(20)`

### 2. **Booleanos Onde Deveriam Ser Inteiros**
- `serie`, `tpnf`, `iddest`, `tpimp`, `tpemis`, `tpamb`, `finnfe`, `indfinal`, `indpres`, `procemi` como `BOOLEAN` - deveriam ser `INTEGER` ou `SMALLINT`

### 3. **Strings com Tamanhos Insuficientes**
- `xFant` como `VARCHAR(10)` - muito pequeno
- `xBairro` como `VARCHAR(10)` ou `VARCHAR(20)` - insuficiente
- `xPais` como `VARCHAR(10)` - muito pequeno
- `xProd` como `VARCHAR(50)` - pode ser insuficiente

### 4. **Valores Monetários com Tipos Errados**
- `vDesc` em `fat` como `BOOLEAN` - deveria ser `DECIMAL(15,2)`
- `vICMSDeson`, `vFCP`, `vBCST`, etc. como `SMALLINT` - deveriam ser `DECIMAL(15,2)`

### 5. **Quantidades com Tipos Incorretos**
- `qCom` e `qTrib` como `SMALLINT` - deveriam ser `DECIMAL(15,4)`
- `cProd` como `BIGINT` - deveria ser `VARCHAR(20)`

### 6. **Campos de Código/Identificação**
- `mod` como `SMALLINT` - deveria ser `VARCHAR(10)`
- `modBC` como `SMALLINT` - deveria ser `VARCHAR(10)`
- `cEAN` e `cEANTrib` como `VARCHAR(50)` - tamanho excessivo

### 7. **Problemas com Valores Percentuais**
- `pICMS`, `pIPI`, etc. como `SMALLINT` - deveriam ser `DECIMAL(15,4)`

### 8. **Falta de Chaves Estrangeiras**
- Muitas tabelas não têm as colunas de chave estrangeira (ex: `id_infnfe`, `id_det`, etc.)

### 9. **Tabelas Faltantes**
- Não foram criadas tabelas como `nfeProc`, `nfe`, `det`, `imposto`, `icms`, `ipi`, `pis`, `cofins`, `total`, `transp`, `cobr`, `pag`, `infAdic`, etc.

### 10. **Precisão Decimal Inadequada**
- `pesoL` e `pesoB` como `DECIMAL(15,3)` - pode ser insuficiente

O lexer está classificando mal os tipos porque:
- Está interpretando números como booleanos quando são 0/1
- Não está reconhecendo padrões específicos (CNPJ, CEP, etc.)
- Está usando tipos numéricos para dados que são strings
- Está subestimando o tamanho necessário para campos de texto

Precisa de melhorias no algoritmo de detecção de tipos!