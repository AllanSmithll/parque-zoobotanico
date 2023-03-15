Use ZOOLOGICO;

CREATE TABLE IF NOT EXISTS VISITANTE
(
CPF		char(11)		    NOT NULL,
RG		char(7)		        NOT NULL,	
nome		varchar(30)		NOT NULL,
genero      char(1)	    	NULL        DEFAULT 'M',
email		varchar(35)		NULL,
data_nasc	varchar(40)			NOT NULL,
pais_orig	varchar(25)		NOT NULL    DEFAULT 'BRASIL',
esta_prov	varchar(45)		NOT NULL    DEFAULT 'PARAÍBA',
cidade	varchar(45)		NOT NULL        DEFAULT 'SÃO MIGUEL DO TAIPU',

CONSTRAINT	PRIMARY KEY (CPF)
);

/* tabela TELEFONE-VISITANTE depende de VISITANTE*/
CREATE TABLE IF NOT EXISTS TELEFONE_VISITANTE (
CPF	char(11)		NOT NULL,
numero	char(14)		NOT NULL,

CONSTRAINT	PRIMARY KEY (CPF, numero),
CONSTRAINT 	FOREIGN KEY (CPF) REFERENCES VISITANTE(CPF)
);

/* tabela INGRESSO_CATALAGO independente */ 
CREATE TABLE IF NOT EXISTS INGRESSO_CATALAGO
(
tipo_id		int(1)		NOT NULL AUTO_INCREMENT,
tipo_nome   varchar(20) NOT NULL,
preco		decimal(4,2)NOT NULL,	
area_perm	text		NOT NULL,
cor		    varchar(13)	NOT NULL,

CONSTRAINT	PRIMARY KEY (tipo_id)
);

/* tabela INGRESSO_DISPONIVEL depende de INGRESSO_CATALOGO*/ 
CREATE TABLE IF NOT EXISTS INGRESSO_DISPONIVEL
(
ID   	    char(8)	    NOT NULL,
tipo		INT(1)      NOT NULL,

CONSTRAINT	PRIMARY KEY (ID),
CONSTRAINT	FOREIGN KEY (tipo) REFERENCES INGRESSO_CATALAGO(tipo_id)
);

/* tabela PESQUISADOR  depende de VISITANTE*/ 

CREATE TABLE IF NOT EXISTS PESQUISADOR
(
CPF	            char(11)		NOT NULL,
nume_id_cart	char(8)		    NOT NULL,	
instituicao		VARCHAR(80)		NULL,
grad_acad		varchar(40)		NULL,
conclusao     	YEAR    	    NULL,

CONSTRAINT	PRIMARY KEY (CPF),
CONSTRAINT 	UNIQUE (nume_id_cart),
CONSTRAINT 	FOREIGN KEY (CPF) REFERENCES VISITANTE(CPF)
);

/* tabela PROJETO_PESQUISA independente*/ 

CREATE TABLE IF NOT EXISTS PROJETO_PESQUISA
(
ID		    char(8)		    NOT NULL,
titulo		varchar(45)		NOT NULL,	
subtitulo	text		    NULL,

CONSTRAINT	PRIMARY KEY (ID)
);

/* tabela DESENVOLVIMENTO_PROJETO depende de PESQUISADOR e PROJETO_PESQUISA*/ 

CREATE TABLE IF NOT EXISTS DESENVOLVIMENTO_PROJETO
(
cod_proj		char(8)		    NOT NULL,
pesquisador		char(11)		NOT NULL,
data_inicio		varchar(40)			NOT NULL,	
data_final		varchar(40)			NULL,

CONSTRAINT	PRIMARY KEY (cod_proj, pesquisador, data_inicio),
CONSTRAINT	FOREIGN KEY (pesquisador) REFERENCES PESQUISADOR(CPF),
CONSTRAINT	FOREIGN KEY (cod_proj) REFERENCES PROJETO_PESQUISA(ID)
);

/* tabela HABITAT independente*/ 

CREATE TABLE IF NOT EXISTS HABITAT
(
ID              char(10)		NOT NULL,
fosso			boolean			NOT NULL,	
tipo_solo		varchar(25)		NOT NULL DEFAULT 'GRAMA',
arvore_quant    tinyint  		NOT NULL DEFAULT 0 ,

CONSTRAINT	PRIMARY KEY (ID)
);

/* tabela ANIMAL independente*/

CREATE TABLE IF NOT EXISTS ANIMAL
(
ID		        char(10)		NOT NULL,
data_cheg		varchar(40)			NOT NULL,
saude			varchar(15)		NOT NULL DEFAULT 'SAUDÁVEL',
nome_cien		varchar(35)		NOT NULL,	
nome_popu		varchar(30)		NULL,
alimentacao		varchar(25)		NOT NULL,
clima_adap		varchar(15)		NOT NULL,
habitat 		char(10)		NULL,

CONSTRAINT	PRIMARY KEY (ID),
CONSTRAINT	FOREIGN KEY (habitat) REFERENCES HABITAT(ID)
);

/* tabela ALA_CLINICA independente*/ 

CREATE TABLE IF NOT EXISTS ALA_CLINICA
(
setor_nume		int(4)		NOT NULL,
alas_livre  	int(2)		NOT NULL DEFAULT 10,

CONSTRAINT	PRIMARY KEY (setor_nume)
);

/* tabela INTERNACOES depende de  ANIMAL e ALA_CLINICA*/ 

CREATE TABLE IF NOT EXISTS ANIMAL_INTERNACAO
(
setor_nume		int(4)		    NOT NULL AUTO_INCREMENT,
animal		    char(10)		NOT NULL,
data_entr		varchar(40)			NOT NULL,
data_saida		varchar(40)			NULL,

CONSTRAINT	PRIMARY KEY(setor_nume, animal, data_entr),
CONSTRAINT	FOREIGN KEY(setor_nume)	REFERENCES	ALA_CLINICA(setor_nume),
CONSTRAINT	FOREIGN KEY(animal)	REFERENCES ANIMAL(ID)
);

/* tabela FUNCIONARIO independente */ 
CREATE TABLE IF NOT EXISTS FUNCIONARIO
(
matricula	char(11)         NOT NULL,
CPF		    char(11)		NOT NULL,	
nome		varchar(30)		NOT NULL,
funcao	    varchar(20)		NOT NULL,
salario		decimal			NOT NULL,
CNH		    char(10)		NULL,
gerente	    char(11)		    NULL,
CEP		    char(8)		    NOT NULL,
rua		    varchar(45)		NOT NULL,
bairro	    varchar(45)		NOT NULL,
cidade      varchar(45)     NOT NULL DEFAULT 'SÃO MIGUEL DO TAIPU',

CONSTRAINT	PRIMARY KEY(matricula),
CONSTRAINT	UNIQUE (CPF)
);
/*CONSTRAINT	FOREIGN KEY(gerente)	REFERENCES FUNCIONARIO(matricula)*/

/* tabela TELEFONE_FUNC depende de FUNCIONARIO*/
CREATE TABLE IF NOT EXISTS TELEFONE_FUNC
(
funcionario	char(11)		    NOT NULL,
numero	    char(14)		NOT NULL,

CONSTRAINT	PRIMARY KEY (funcionario, numero),
CONSTRAINT 	FOREIGN KEY (funcionario) REFERENCES FUNCIONARIO(matricula)
);

/* tabela VETERINARIO depende de FUNCIONARIO*/ 

CREATE TABLE IF NOT EXISTS VETERINARIO
(
matricula		char(11)		NOT NULL,
CRMV			char(8)		NOT NULL,
setor_resp		int(2)		NULL,	

CONSTRAINT	PRIMARY KEY (matricula),
CONSTRAINT 	UNIQUE (CRMV),
CONSTRAINT 	FOREIGN KEY (matricula) REFERENCES FUNCIONARIO(matricula)
);

/* tabela INGRESSOS_COMPRADOS depende de INGRESSO_DISPONIVEL e VISITANTE*/
CREATE TABLE IF NOT EXISTS INGRESSOS_COMPRADOS
(
id_compra		char(11)		NOT NULL,
comprador		CHAR(11)		NOT NULL,
ingresso		char(8)		    NOT NULL,
auxiliador_func	char(8)		    NULL,
data_compra		varchar(40)			NOT NULL,

CONSTRAINT	PRIMARY KEY (id_compra),
CONSTRAINT 	FOREIGN KEY (auxiliador_func)   REFERENCES FUNCIONARIO(matricula),
CONSTRAINT 	FOREIGN KEY (comprador)         REFERENCES VISITANTE(CPF),
CONSTRAINT 	FOREIGN KEY (ingresso) 		    REFERENCES INGRESSO_DISPONIVEL(ID)
);

/* tabela FORNECEDOR*/
CREATE TABLE IF NOT EXISTS FORNECEDOR
(
CNPJ		char(14)		NOT NULL,
ENDERECO	text		NOT NULL,
nome_fant	varchar(45)		NOT NULL,

CONSTRAINT	PRIMARY KEY (CNPJ)
);

/* tabela FORNECEDOR_EMAIL*/
CREATE TABLE IF NOT EXISTS FORNECEDOR_EMAIL
(
CNPJ		char(14)		NOT NULL,
email		VARchar(45)		NOT NULL,

CONSTRAINT	PRIMARY KEY (CNPJ, email),
CONSTRAINT FOREIGN KEY (CNPJ) REFERENCES FORNECEDOR(CNPJ)
);

/* tabela RECURSO_ARMAZENADO */ 
CREATE TABLE IF NOT EXISTS RECURSO_ARMAZENADO
(
id  		char(10)      	NOT NULL,
Forn_CNPJ	char(14)		NOT NULL,	
nome		varchar(30)		NOT NULL,
quant_estoq decimal  		Not NULL DEFAULT 0,
unidade	    varchar(5)  	NULL DEFAULT 'KG',
tipo		varchar(25)		NOT NULL,
data_compra	varchar(40)			NOT NULL,
data_vali	varchar(40)			NOT NULL,
quant_forn	decimal		    NOT NULL ,
setor		char(5)		    NOT NULL,
nume_galpao	int(4)		    NULL,
codi_prat	char(5)		    NULL,

CONSTRAINT	PRIMARY KEY (id),
CONSTRAINT FOREIGN KEY (Forn_CNPJ) REFERENCES FORNECEDOR(CNPJ)
);

/* tabela MANUNTENCAO_HABITAT*/
CREATE TABLE IF NOT EXISTS MANUNTECAO_HABITAT
(
habitat 	char(10)	NOT NULL,
funcionario	char(11)	    NOT NULL,
data_inicio	varchar(40)	NOT NULL,
data_final	varchar(40)	NULL,	
descricao	text	    NOT NULL,

CONSTRAINT PRIMARY KEY (habitat , funcionario, data_inicio),
CONSTRAINT FOREIGN KEY (habitat) REFERENCES HABITAT(ID),
CONSTRAINT FOREIGN KEY (funcionario) REFERENCES FUNCIONARIO(matricula)
);

/* tabela EXAME_ANIMAL*/
CREATE TABLE IF NOT EXISTS EXAME_ANIMAL
(
data_exam	varchar(40)	NOT NULL,
veterinario	char(11)	    NOT NULL,
animal	    char(10)	NOT NULL,

CONSTRAINT PRIMARY KEY (data_exam, veterinario, animal),
CONSTRAINT FOREIGN KEY (veterinario) REFERENCES VETERINARIO(matricula),
CONSTRAINT FOREIGN KEY (animal)      REFERENCES ANIMAL(ID)
);

/* tabela PRESCRICAO_EXAME*/
CREATE TABLE IF NOT EXISTS PRESCRICAO_EXAME
(
data_exam	varchar(40)	NOT NULL,
veterinario	char(11)	    NOT NULL,
animal	    char(10)	NOT NULL,
remedio 	char(8)	    NOT NULL,

CONSTRAINT PRIMARY KEY (data_exam, veterinario, animal, remedio),

CONSTRAINT FOREIGN KEY (data_exam, veterinario, animal )    REFERENCES EXAME_ANIMAL(data_exam, veterinario, animal),

CONSTRAINT FOREIGN KEY (REMEDIO)        REFERENCES RECURSO_ARMAZENADO(id)
);

ALTER TABLE VISITANTE   ADD CONSTRAINT gen_check CHECK (genero='M' or genero='F');
ALTER TABLE VISITANTE   ADD CONSTRAINT mail_VISITANTE_check CHECK (email like '%@%.%');

ALTER TABLE INGRESSO_CATALAGO   ADD CONSTRAINT preco_check CHECK (preco >=0);
/*ALTER TABLE INGRESSO_CATALAGO   ADD CONSTRAINT cor_check CHECK (cor in ('AZUL','VERDE',"AMARELO",'VERMELHO','PÚRPURA'));

--ALTER TABLE PESQUISADOR   ADD CONSTRAINT graduacao_check CHECK (grad_acad in ('TECNOLÓGO','BACHARELADO','MESTRADO','DOUTORADO'));*/

ALTER TABLE HABITAT   ADD CONSTRAINT arvores_check CHECK (arvore_quant >=0);

ALTER TABLE ANIMAL   ADD CONSTRAINT saude_check CHECK (saude in ('SAUDÁVEL','ENFERMO','MORIBUNDO','MORTO'));

ALTER TABLE ALA_CLINICA   ADD CONSTRAINT setor_check CHECK (setor_nume >0);
ALTER TABLE ALA_CLINICA   ADD CONSTRAINT alas_livre_check CHECK (alas_livre >=0);

ALTER TABLE FUNCIONARIO   ADD CONSTRAINT salario_check CHECK (salario >0);

ALTER TABLE FORNECEDOR_EMAIL  ADD CONSTRAINT mail_FORNECEDOR_check CHECK (email like '%@%.%');

ALTER TABLE RECURSO_ARMAZENADO   ADD CONSTRAINT quant_estoq_check CHECK (quant_estoq > 0);
ALTER TABLE RECURSO_ARMAZENADO   ADD CONSTRAINT quant_forn_check CHECK (quant_forn >0);
ALTER TABLE RECURSO_ARMAZENADO   ADD CONSTRAINT nume_galpao_check CHECK (nume_galpao >0);
