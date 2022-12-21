CREATE DATABASE IF NOT EXISTS ZOOLOGICO;
USE ZOOLOGICO;

/* tabela VISITANTE */ 
CREATE TABLE IF NOT EXISTS VISITANTE
(
CPF		char(11)		    NOT NULL,
RG		char(7)		        NOT NULL,	
nome		varchar(30)		NOT NULL,
genero      char(1)	    	NULL        DEFAULT 'M',
email		varchar(35)		NULL,
data_nasc	date			NOT NULL,
pais_orig	varchar(25)		NOT NULL    DEFAULT 'BRASIL',
esta_prov	varchar(45)		NOT NULL    DEFAULT 'PARAÍBA',
cidade	varchar(45)		NOT NULL        DEFAULT 'SÃO MIGUEL DO TAIPU',

CONSTRAINT	PRIMARY KEY (CPF)
);

/* tabela TELEFONE-VISITANTE */
CREATE TABLE IF NOT EXISTS TELEFONE_VIS(
CPF	char(11)		NOT NULL,
numero	char(14)		NOT NULL,

CONSTRAINT	PRIMARY KEY (CPF, numero),
CONSTRAINT 	FOREIGN KEY (CPF) REFERENCES VISITANTE(CPF)
);

/* tabela INGRESSO */ 

/* tabela INGRESSO_CATALAGO */ 
CREATE TABLE IF NOT EXISTS INGRESSO_CATALAGO
(
tipo_id		int(1)		NOT NULL AUTO_INCREMENT,
tipo_nome   varchar(20) NOT NULL,
preco		decimal(4,2)NOT NULL,	
area_perm	text		NOT NULL,
cor		    varchar(13)	NOT NULL,

CONSTRAINT	PRIMARY KEY (tipo_id)
);

/* tabela INGRESSO_DISPONIVEL */ 
CREATE TABLE IF NOT EXISTS INGRESSO_DISPONIVEL
(
ID   	    char(8)	    NOT NULL,
tipo		INT(1)      NOT NULL,

CONSTRAINT	PRIMARY KEY (ID),
CONSTRAINT	FOREIGN KEY (tipo) REFERENCES INGRESSO_CATALAGO(tipo_id)
);

/* tabela PESQUISADOR */ 

CREATE TABLE IF NOT EXISTS PESQUISADOR
(
CPF	            char(11)		NOT NULL,
nume_id_cart	char(8)		    NOT NULL,	
instituicao		VARCHAR(45)		NULL,
grad_acad		varchar(30)		NULL,
concl_supe  	YEAR    	    NULL,

CONSTRAINT	PRIMARY KEY (CPF),
CONSTRAINT 	UNIQUE (nume_id_cart),
CONSTRAINT 	FOREIGN KEY (CPF) REFERENCES VISITANTE(CPF)
);


/* tabela PROJETO_PESQUISA*/ 

CREATE TABLE IF NOT EXISTS PROJETO_PESQUISA
(
ID		    char(8)		    NOT NULL,
titulo		varchar(45)		NOT NULL,	
subtitulo	text		    NULL,

CONSTRAINT	PRIMARY KEY (ID)
);

/* tabela DESENVOLVIMENTO_PROJETO*/ 

CREATE TABLE IF NOT EXISTS DESENVOLVIMENTO_PROJETO
(
cod_proj		char(8)		    NOT NULL,
pesquisador		char(11)		NOT NULL,
data_inicio		date			NOT NULL,	
data_final		date			NULL,

CONSTRAINT	PRIMARY KEY (cod_proj, pesquisador, data_inicio),
CONSTRAINT	FOREIGN KEY (pesquisador) REFERENCES PESQUISADOR(CPF),
CONSTRAINT	FOREIGN KEY (cod_proj) REFERENCES PROJETO_PESQUISA(ID)
);

/* tabela HABITAT*/ 

CREATE TABLE IF NOT EXISTS HABITAT
(
ID              char(10)		NOT NULL,
fosso			boolean			NOT NULL,	
tipo_solo		varchar(25)		NOT NULL DEFAULT 'GRAMA',
arvore_quant    tinyint  		NOT NULL DEFAULT 0 ,

CONSTRAINT	PRIMARY KEY (ID)
);

/* tabela ANIMAL*/

CREATE TABLE IF NOT EXISTS ANIMAL
(
ID		        char(10)		NOT NULL AUTO_INCREMENT,
data_cheg		date			NOT NULL,
saude			varchar(15)		NOT NULL DEFAULT 'SAUDÁVEL',
nome_cien		varchar(35)		NOT NULL,	
nome_popu		varchar(30)		NULL,
alimentacao		varchar(25)		NOT NULL,
clima_adap		varchar(15)		NOT NULL,
habitat 		char(10)		NULL,

CONSTRAINT	PRIMARY KEY (ID),
CONSTRAINT	FOREIGN KEY (habitat) REFERENCES HABITAT(ID)
);

/* tabela ALA_CLINICA*/ 

CREATE TABLE IF NOT EXISTS ALA_CLINICA
(
setor_nume		int(4)		NOT NULL,
alas_livre  	int(2)		NOT NULL DEFAULT 10,

CONSTRAINT	PRIMARY KEY (setor_nume)
);

/* tabela INTERNACOES*/ 

CREATE TABLE IF NOT EXISTS ANIMAL_INTERNACAO
(
setor_nume		int(4)		    NOT NULL AUTO_INCREMENT,
animal		    char(10)		NOT NULL,
data_entr		date			NOT NULL,
data_saida		date			NULL,

CONSTRAINT	PRIMARY KEY(setor_nume, animal, data_entr),
CONSTRAINT	FOREIGN KEY(setor_nume)	REFERENCES	ALA_CLINICA(setor_nume),
CONSTRAINT	FOREIGN KEY(animal)	REFERENCES ANIMAL(ID)
);

/* tabela FUNCIONARIO */ 
CREATE TABLE IF NOT EXISTS FUNCIONARIO
(
matricula	char(8)         NOT NULL,
CPF		    char(11)		NOT NULL,	
nome		varchar(30)		NOT NULL,
funcao	    varchar(20)		NOT NULL,
salario		decimal			NOT NULL,
CNH		    char(10)		NULL,
gerente	    char(8)		    NULL,
CEP		    char(8)		    NOT NULL,
rua		    varchar(45)		NOT NULL,
bairro	    varchar(45)		NOT NULL,
cidade      varchar(45)     NOT NULL DEFAULT 'SÃO MIGUEL DO TAIPU',

CONSTRAINT	PRIMARY KEY(matricula),
CONSTRAINT	UNIQUE (CPF),
CONSTRAINT	FOREIGN KEY(gerente)	REFERENCES FUNCIONARIO(matricula)
);

/* tabela TELEFONE_FUNC*/
CREATE TABLE IF NOT EXISTS TELEFONE_FUNC
(
funcionario	char(8)		    NOT NULL,
numero	    char(14)		NOT NULL,

CONSTRAINT	PRIMARY KEY (funcionario, numero),
CONSTRAINT 	FOREIGN KEY (funcionario) REFERENCES FUNCIONARIO(matricula)
);

/* tabela VETERINARIO */ 

CREATE TABLE IF NOT EXISTS VETERINARIO
(
matricula		char(8)		NOT NULL,
CRMV			char(8)		NOT NULL,
setor_resp		int(2)		NULL,	

CONSTRAINT	PRIMARY KEY (matricula),
CONSTRAINT 	UNIQUE (CRMV),
CONSTRAINT 	FOREIGN KEY (matricula) REFERENCES FUNCIONARIO(matricula)
);

/* tabela INGRESSOS_COMPRADOS*/
CREATE TABLE IF NOT EXISTS INGRESSOS_COMPRADOS
(
id_compra		char(11)		NOT NULL,
comprador		CHAR(11)		NOT NULL,
ingresso		char(8)		    NOT NULL,
auxiliador_func	char(8)		    NULL,
data_compra		date			NOT NULL,

CONSTRAINT	PRIMARY KEY (id_compra),
CONSTRAINT 	FOREIGN KEY (auxiliador_func)   REFERENCES FUNCIONARIO(matricula),
CONSTRAINT 	FOREIGN KEY (comprador)         REFERENCES VISITANTE(CPF),
CONSTRAINT 	FOREIGN KEY (ingresso) 		    REFERENCES INGRESSO_DISPONIVEL(ID)
);

/* tabela FORNECEDOR*/
CREATE TABLE IF NOT EXISTS FORNECEDOR
(
CNPJ		char(14)		NOT NULL,
ENDERECO	VARchar(45)		NOT NULL,
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
data_compra	date			NOT NULL,
data_vali	date			NOT NULL,
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
funcionario	char(8)	    NOT NULL,
data_inicio	datetime	NOT NULL,
data_final	datetime	NULL,	
descricao	text	    NOT NULL,

CONSTRAINT PRIMARY KEY (habitat , funcionario, data_inicio),
CONSTRAINT FOREIGN KEY (habitat) REFERENCES HABITAT(ID),
CONSTRAINT FOREIGN KEY (funcionario) REFERENCES FUNCIONARIO(matricula)
);

/* tabela EXAME_ANIMAL*/
CREATE TABLE IF NOT EXISTS EXAME_ANIMAL
(
data_exam	datetime	NOT NULL,
veterinario	char(8)	    NOT NULL,
animal	    char(10)	NOT NULL,

CONSTRAINT PRIMARY KEY (data_exam, veterinario, animal),
CONSTRAINT FOREIGN KEY (veterinario) REFERENCES VETERINARIO(matricula),
CONSTRAINT FOREIGN KEY (animal)      REFERENCES ANIMAL(ID)
);

/* tabela PRESCRICAO_EXAME*/
CREATE TABLE IF NOT EXISTS PRESCRICAO_EXAME
(
data_exam	datetime	NOT NULL,
veterinario	char(8)	    NOT NULL,
animal	    char(10)	NOT NULL,
remedio 	char(8)	    NOT NULL,

CONSTRAINT PRIMARY KEY (data_exam, veterinario, animal, remedio),

CONSTRAINT FOREIGN KEY (veterinario, animal, data_exam)    REFERENCES EXAME_ANIMAL(veterinario, animal, data_exam),

CONSTRAINT FOREIGN KEY (REMEDIO)        REFERENCES RECURSO_ARMAZENADO(id)
);

ALTER TABLE VISITANTE   ADD CONSTRAINT gen_check CHECK (genero='M' or genero='F');
ALTER TABLE VISITANTE   ADD CONSTRAINT mail_VISITANTE_check CHECK (email like '%@%.%');

ALTER TABLE INGRESSO_CATALAGO   ADD CONSTRAINT preco_check CHECK (preco >=0);
ALTER TABLE INGRESSO_CATALAGO   ADD CONSTRAINT cor_check CHECK (cor in ('AZUL','VERDE',"AMARELO",'VERMELHO','PÚRPURA'));

ALTER TABLE PESQUISADOR   ADD CONSTRAINT graduacao_check CHECK (grad_acad in ('TECNOLÓGO','BACHARELADO','MESTRADO','DOUTORADO'));

ALTER TABLE HABITAT   ADD CONSTRAINT arvores_check CHECK (arvore_quant >=0);

ALTER TABLE ANIMAL   ADD CONSTRAINT saude_check CHECK (saude in ('SAUDÁVEL','ENFERMO','MORIBUNDO','MORTO'));

ALTER TABLE ALA_CLINICA   ADD CONSTRAINT setor_check CHECK (setor_nume >0);
ALTER TABLE ALA_CLINICA   ADD CONSTRAINT alas_livre_check CHECK (alas_livre >=0);

ALTER TABLE FUNCIONARIO   ADD CONSTRAINT salario_check CHECK (salario >0);

ALTER TABLE FORNECEDOR_EMAIL  ADD CONSTRAINT mail_FORNECEDOR_check CHECK (email like '%@%.%');

ALTER TABLE RECURSO_ARMAZENADO   ADD CONSTRAINT quant_estoq_check CHECK (quant_estoq > 0);
ALTER TABLE RECURSO_ARMAZENADO   ADD CONSTRAINT quant_forn_check CHECK (quant_forn >0);
ALTER TABLE RECURSO_ARMAZENADO   ADD CONSTRAINT nume_galpao_check CHECK (nume_galpao >0)

/* Inserções */

/* VISITANTE */

INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('11914755308', '1191475',	'Melvin',	'M',	'MelvinSConway@einrot.com',	"5/18/2003",	DEFAULT,	"Santa Catarina",	"Florianópolis"
)

INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('64482378798', '6448237',	'Marjorie',    'F',	'MarjorieMSoriano@armyspy.com',	"12/13/1947",	DEFAULT,	DEFAULT,	"São Roque"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('23156909432', '2315690',	'Eric',	'M',	'EricOAllison@rhyta.com',	"8/2/1951",	DEFAULT,	DEFAULT,	"Belford Roxo"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('24344841158', '2434484',	'Esther',	'F',	'EstherEBowser@gustr.com',	"1/29/1980",	DEFAULT,	"Alagoas",	"Maceió"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('76426078735', '7642607',	'Andrew',	'M',	'AndrewKBliss@dayrep.com',	"4/29/1943",	DEFAULT,	'Tocantins',	"Gurupi"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('97723581319', '9772358',	'Sherry',	'F',	'SherryTStanton@dayrep.com',	"10/14/1970",	DEFAULT,	"Goiás",	"Formosa"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('52107813647', '5210781',	'Sonia',	'F',	'SoniaDAguirre@teleworm.us',	"6/9/1942",	DEFAULT,	"Paraná",	"Curitiba"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('67781375505', '6778137',	'Duane',	'M',	'DuaneELigon@jourrapide.com',	"11/10/1977",	DEFAULT,	"Pernambuco",	"Recife"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('23940071501', '2394007',	'Anthony',	'M',	'AnthonyJParson@dayrep.com',	"10/9/1968",	DEFAULT,	DEFAULT,	"São Bernardo do Campo"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('63612908405', '6361290',	'Kevin',	'M',	'KevinAWilliams@einrot.com',	"1/30/1961",	DEFAULT,	"Santa Catarina",	"São José"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('54052700597', '5405270',	'Sandra',	'F',	'SandraBLyon@fleckens.hu',	"4/27/1956",	DEFAULT,	"Mato Grosso",	"Cuiabá"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('71106412443', '7110641',	'Carolyn',	'F',	'CarolynCOliver@dayrep.com',	"8/3/2001",	DEFAULT,	"Mato Grosso",	"Cuiabá"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('11581721927', '1158172',	'Susan',	'F',	'SusanKCrawford@dayrep.com',	"6/18/1993",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('41497522498', '4149752',	'Billy',	'M',	'BillyLColby@teleworm.us',	"7/28/1980",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('44028157706', '4402815',	'Keith',	'M',	'KeithRGaylor@jourrapide.com',	"11/25/1948",	DEFAULT,	"Espírito Santo",	"Serra"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('55537846543', '5553784',	'Mary',	'F',	'MarySTrawick@teleworm.us',	"1/18/1955",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('83668066850', '8366806',	'Joseph',	'M',	'JosephJSlay@gustr.com',	"7/25/1937",	DEFAULT,	DEFAULT,	"Itapevi"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('99288674101', '9928867',	'Michael',	'M',	'MichaelAWoolsey@rhyta.com',	"11/28/1986",	DEFAULT,	DEFAULT,	"Votorantim"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('98503973901', '9850397',	'Terry',	'M',	'TerryMSaine@teleworm.us',	"1/24/1942",	DEFAULT,	DEFAULT,	"Belo Horizonte"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('64603661010', '6460366',	'Brittany',	'F',	'BrittanyMNazario@superrito.com',	"1/16/1999",	DEFAULT,	DEFAULT,	"Três Rios"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('67926064726', '6792606',	'Ivory',	'M',	'IvorySDecker@teleworm.us',	"12/31/1949",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('95385258415', '9538525',	'Douglas',	'M',	'DouglasJMathis@superrito.com',	"9/21/1953",	DEFAULT,	DEFAULT,	"Assis"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('48949340860', '4894934',	'Mary',	'F',	'MaryLBarrick@jourrapide.com',	"7/17/1937",	DEFAULT,	"Distrito Federal",	"Núcleo Bandeirante"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('96837117408', '9683711',	'Jeanne',	'F',	'JeanneCWebster@armyspy.com',	"10/8/1982",	DEFAULT,	DEFAULT,	"Osasco"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('49879959485', '4987995',	'Selena',	'F',	'SelenaWWilder@einrot.com',	"1/11/1969",	DEFAULT,	"Distrito Federal",	"Brasília"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('93417036542', '9341703',	'Thomas',	'M',	'ThomasJLoftis@gustr.com',	"1/26/1975",	DEFAULT,	DEFAULT,	"Passos"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('34228058507', '3422805',	'Gayle',	'F',	'GayleJRunge@gustr.com',	"4/26/1997",	DEFAULT,	DEFAULT,	Default
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('47994960006', '4799496',	'William',	'M',	'WilliamMSnyder@einrot.com',	"12/10/2003",	DEFAULT,	DEFAULT,	"Teófilo Otoni"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('29934345781', '2993434',	'Daniel',	'M',	'DanielTDonnelly@superrito.com',	"12/14/1970",	DEFAULT,	DEFAULT,	"Piracicaba"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('38661444829', '3866144',	'Jack',	'M',	'JackJCobbs@superrito.com',	"7/7/1967",	DEFAULT,	Sergipe	Aracaju
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('58623066251', '5862306',	'Cindy',	'F',	'CindyGBaker@rhyta.com',	"8/23/1958",	DEFAULT,	DEFAULT,	DEFAULT
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('60590923145', '6059092',	'Matthew',	'M',	'MatthewSAbraham@gustr.com',	"4/29/1982",	DEFAULT,	DEFAULT,	"Belford Roxo"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('71945058609', '7194505',	'Patricia',	'F',	'PatriciaJHolder@teleworm.us',	"11/16/1983",	DEFAULT,	"Distrito Federal",	"Brazlândia"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('51218481706', '5121848',	'Jean',	'F',	'JeanLReynolds@superrito.com',	"5/13/1957",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('50914287630', '5091428',	'Mary',	'F',	'MaryRCook@rhyta.com',	"12/17/1961",	DEFAULT,	"Distrito Federal",	"Taguatinga"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('72313085708', '7231308',	'Robert',	'M',	'RobertEStoll@einrot.com',	"6/19/1937",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('37353265523', '3735326',	'Robert',	'M',	'RobertNHare@rhyta.com',	"3/9/1952",	DEFAULT,	DEFAULT,	"Campinas"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('57095314802', '5709531',	'Rodrigo',	'M',	'RodrigoJBrown@cuvox.de',	"6/28/1987",	DEFAULT,	DEFAULT,	"Piracicaba"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('31295917025', '3129591',	'Gary',	'M',	'GaryMHill@cuvox.de',	"1/23/2001",	DEFAULT,	DEFAULT,	"Ourinhos"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('13725158282', '1372515',	'Dolores',	'F',	'DoloresAAllen@einrot.com',	"3/12/1982",	DEFAULT,	"Distrito Federal",	"Riacho Fundo"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('87940104047', '8794010',	'Mary',	'F',	'MaryJKeck@armyspy.com',	"11/18/1980",	DEFAULT,	DEFAULT,	"Ribeirão" 
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('67584336841', '6758433',	'Clyde',	'M',	'ClydeKLittle@jourrapide.com',	"11/13/1977",	DEFAULT,	"Santa Catarina",	"Florianópolis"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('43335280032', '4333528',	'Brian',	'M',	'BrianCRivera@jourrapide.com',	"11/25/1979",	DEFAULT,	"Rio Grande do Sul"	"Passo Fundo"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('96981046407', '9698104',	'Christina',	'F',	'ChristinaMJohnson@armyspy.com',	"3/15/1947",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('90320237729', '9032023',	'Rene',	'M',	'ReneLSullivan@dayrep.com',	"9/30/1984",	DEFAULT,	DEFAULT,	"Ponte Nova"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('94684010228', '9468401',	'Darlene',	'F',	'DarleneBMcMullen@fleckens.hu',	"3/24/1970",	DEFAULT,	"Pará"	"Redenção"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('35860652569', '3586065',	'Rosemary',	'F',	'RosemaryCTaylor@fleckens.hu',	"3/28/1976",	DEFAULT,	"Ceará"	"Fortaleza"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('53852974534', '5385297',	'Rossie',	'F',	'RossieRAnaya@dayrep.com',	"3/21/1953",	DEFAULT,	"Pernambuco",	"Jaboatão" 
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('83943706168', '8394370',	'Gina',	'F',	'GinaRPratt@rhyta.com',	"4/25/1961",	DEFAULT,	"Pernambuco",	"Petrolina"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('14375303549', '1437530',	'Flora',	'F',	'FloraRGriffin@fleckens.hu',	"1/13/1952",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('86063755861', '8606375',	'Janet',	'F',	'JanetPOkeefe@teleworm.us',	"12/3/1955",	DEFAULT,	"Ceará"	"Fortaleza"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('63782435818', '6378243',	'Virgil',	'M',	'VirgilJWilson@jourrapide.com',	"4/7/1946",	DEFAULT,	DEFAULT,	"Santo ,André"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('60159197287', '6015919',	'Betty',	'F',	'BettyJWilkinson@einrot.com',	"6/5/1955",	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('79889368919', '7988936',	'Scott',	'M',	'ScottBAnderson@jourrapide.com',	"9/5/1980",	DEFAULT,	"Rio Grande do Sul"	
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('73648130048', '7364813',	'Paul',	'M',	'PaulLMarshall@rhyta.com',	"8/11/1970",	DEFAULT,	"Ceará"	"Sobral"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('51833500350', '5183350',	'Cynthia',	'F',	'CynthiaCMiller@jourrapide.com',	"8/5/1968",	DEFAULT,	DEFAULT,	"Uberlândia"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('53220781187', '5322078',	'Troy',	'M',	'TroyCMertz@fleckens.hu',	"3/8/1944",	DEFAULT,	DEFAULT,	"Contagem"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('33530650757', '3353065',	'Albert',	'M',	'AlbertMFearon@teleworm.us',	"7/31/1967",	DEFAULT,	DEFAULT,	"Campinas"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('84251814100', '8425181',	'Timothy',	'M',	'TimothyDEbbert@cuvox.de',	"9/26/1974",	DEFAULT,	DEFAULT,	
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('47867205268', '4786720',	'Elaine',	'F',	'ElaineFAustria@superrito.com',	"5/17/2000",	DEFAULT,	"Rio Grande do Sul"	"Esteio"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('93298973122', '9329897',	'Susan',	'F',	'SusanDMorgan@einrot.com',	"1/22/1978",	DEFAULT,	"Distrito Federal",	"Brasília"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('80247071102', '8024707',	'Jeff',	'M',	'JeffKBoivin@gustr.com',	"5/18/1969",	DEFAULT,	DEFAULT,	"Belo Horizonte"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('26618488354', '2661848',	'Simon',	'M',	'SimonNSullivan@cuvox.de',	"10/19/1971",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('40113187106', '4011318',	'Ella',	'F',	'EllaJBailey@superrito.com',	"10/25/1967",	DEFAULT,	"Pará"	"Belém"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('16950339496', '1695033',	'Cheryl',	'F',	'CherylRBurton@jourrapide.com',	"8/24/1977",	DEFAULT,	"Pará"	"Belém"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('12683202261', '1268320',	'Fred',	'M',	'FredLHall@dayrep.com',	"3/27/1998",	DEFAULT,	DEFAULT,	
)
i;nsert VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('10181769930', '1018176',	'Bernadette',	'F',	'BernadetteTPittman@dayrep.com',	"2/10/1991",	DEFAULT,	"Bahia" "Feira"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('94567438450', '9456743',	'Robert',	'M',	'RobertKAskew@rhyta.com',	"7/2/1998",	DEFAULT,	"Pernambuco",	"Recife"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('97084191097', '9708419',	'Byron',	'M',	'ByronSRunyon@gustr.com',	"7/6/1966",	DEFAULT,	"Distrito Federal",	"Gama"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('63979484807', '6397948',	'Andrew',	'M',	'AndrewLCharboneau@armyspy.com',	"8/18/1998",	DEFAULT,	DEFAULT,	DEFAULT,
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('13921434386', '1392143',	'Cynthia',	'F',	'CynthiaRFlores@gustr.com',	"12/10/1960",	DEFAULT,	"Goiás",	
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('68285106403', '6828510',	'Mark',	'M',	'MarkBMunn@rhyta.com',	"7/4/1960",	DEFAULT,	"Rio Grande do Sul"	
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('40351060979', '4035106',	'John',	'M',	'JohnPValentine@armyspy.com',	"4/21/1951",	DEFAULT,	"Pernambuco",	"Paulista"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('39496798551', '3949679',	'Curtis',	'M',	'CurtisMWebb@teleworm.us',	"5/13/1960",	DEFAULT,	DEFAULT,	"Ribeirão Preto"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('57423634948', '5742363',	'Harry',	'M',	'HarryCLawson@superrito.com',	"4/9/1945",	DEFAULT,	DEFAULT,	"Mauá"
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('10670004294', '1067000',	'Jane',	'F',	'JaneKHogan@superrito.com',	"7/28/1970",	DEFAULT,	"Goiás",	"Goiás",
);
INSERT VISITANTE(CPF, RG, nome,genero,email,data_nasc,pais_orig,esta_prov,cidade) values('76596456412', '7659645',	'Christopher',	'M',	'ChristopherRMcClary@gustr.com',	"9/12/1980",	DEFAULT,	DEFAULT,	DEFAULT,)

/* RECURSO_ARMAZENADO */

insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("ALINDLPP", "75108761000160", "carne", 200.70, "KG", "Alimento", "13-12-2022", "10-02-2023", 500.00, "AA001", 1, "AAA01"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("MANBUBUS", "11661872000117", "tinta", 50.00, "l", "Manutenção", "02-10-2022", "02-10-2037", 120.00, 'BB001', 1, 'AAA01'
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("LIMJINDJ", "08799660000113", "sabão", 100.00, "KG", "Limpeza", "15-12-2022", "15-12-2023", 200.00, "CC001", 1, "AAA01"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("JAUWUIWS", "07530555000194", "jaula", 13, "unid", "Jaula", "29-08-2022", "00-00-00", 20, "DD001", 1, "DDD01"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FARIWWWX", "08917962000111", "analgésico", 12, "unid", "Fármaco", "10-12-2022", "10-12-2024", 20, "EE001", 1, "AAA01"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FARDUWBQ", "08917962000111", "anti-inflamatório", 15, "unid", "Fármaco", "10-12-2022", "10-12-2023", 20, "EE001", 1, "AAA02"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("ALIWUHHO", "97429620000182", "penca de banana", 94, "unid", "Alimento", "20-12-2022", "27-12-2022", 150, "AA001", 1, "AAA02"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("VETQCMPI", "96793493000133", "vac antirábica", 7, "unid", "Veterinário", "15-12-2022", "22-12-2025", 15, "FF001", 1, "AAA01"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("VETDUIWW", "96793493000133", "anestésico", 16, "unid", "Veterinário", "12-11-2022", "22-12-2025", 20, "FF001", 1, "AAA01"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("PROWESDP", "37829203000132", "par de luvas", 34, "unid", "Mat. Profissa", "10-11-2022", "00-00-0000", 100, "GG001", 1, "AAA02"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("ALIWSPME", "75108761000160", "cacho de uvas", 82, "unid", "Alimento", "20-12-2022", "29-12-2022", "AA001", 1, "AAA03"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("MANXCMEA", "11661872000117", "ferramentas", 63, "unid", "Manutenção", "09-09-2021", "00-00-0000", "BB001", 1, "AAA02"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("LIMCNCWM", "08799660000113", "desinfetante", 14, "unid", "Limpeza", "10-12-2022", "10-12-2024", "CC001", 1, "AAA02"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FAMCOWOW", "08917962000111", "antialérgico", 9, "unid", "Fármaco", "07-11-2022", "07-11-2024", 15, "EE001", 1, "AAA03"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FAMNANAC", "08917962000111", "antibiótico", 11, "unid", "Fármaco", "08-10-2022", "08-10-2024", 25, "EE001", 1, "AAA04"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("ALISOWMD", "97429620000182", "manga", 20, "unid", "Alimento", "20-12-2022", "27-10-2022", 40, "AA001", 1, "AAA04"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("ALISOWMQ", "97429620000182", "maçã", 20, "unid", "Alimento", "20-12-2022", "27-10-2022", 40, "AA001", 1, "AAA05"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FAREMOIC", "08917962000111", "cicatrizante", 28, "unid", "Fármaco", "19-12-2022", "19-12-2024", 45, "EE001", 1, "AAA05"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FARWENIU", "08917962000111", "vermifungo", 30, "unid", "Fármaco", "19-12-2022", "19-12-2024", 45, "EE001", 1, "AAA06"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("LIMDOHDO", "08799660000113", "cloro", 13, "l", "Limpeza", "10-09-2022", "10-09-2024", 30, "CC001", 1, "AAA03"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FARMPZEC", "08917962000111", "antitóxico", 20, "unid", "20-11-2022", "20-11-2024", 45, "EE001", 1, "AAA07"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FARPNVWP", "08917962000111", "antitetânico", 26, "unid", "20-09-2022", "20-09-2024", 30, "EE001", 1, "AAA08"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FAREWPWN", "08917962000111", "dexametasona", 28, "unid", "17-10-2022", "17-10-2024", 30, "EE001", 1, "AAA09"
);
insert RECURSO_ARMAZENADO(id,Forn_CNPJ,nome,quant_estoq,unidade, tipo, data_compra, data_vali,quant_forn,setor,nume_galpao,codi_prat) values("FARHQWQW", "08917962000111", "sulfamexazol", 29, "unid", "13-08-2022", "13-08-2024", 30, "EE001", 1, "AAA10");

/* PROJETO_PESQUISADO */

insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("25444487", "Convivência de Humanos com animais",  null
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("41215854", "importância na adaptação aos habitats", null
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("11344774", "Ansiedade em animais silvestres",  "Tratando das causas"
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("01744478", "Poluição sonora frente aos animais",  "Comportamento Animal"
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("92475154", "Enfretamento a poluição",  "Impacto nos Animais"
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("10414765", "Desenvolvimento sustentavél", null
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("14875434", "Alimentação inadequada por visitantes", "E como enfrentar"
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("68955794", "A influência Da vegetação",   "E beneficios dela" 
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("35442851", "Causas de enfermidades em animais", null
)
insert PROJETO_PESQUISA(ID,titulo,subtitulo)
values("75145896", "O Conivio entre os animais",    "E como comportam-se")

/* PROJETO DESENVOLVIDO */

insert(pesquisador,cod_proj,data_inicio,data_final) values("64482378798", "41215854","2012-04-10", "2013-05-12"
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("11914755308", "25444487","2010-11-25", "2013-10-28"
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("24344841158", "01744478","2017-02-01", "2018-10-25"
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("23156909432", "11344774","2015-06-29", "2016-12-05"
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("97723581319", "10414765","2010-10-10", "2011-05-16"
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("76426078735", "92475154","2013-12-02", "2015-06-17"
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("67781375505", "68955794","2014-06-05", "2016-12-12"
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("52107813647", "14875434","2012-12-12", "2014-01-25"
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("63612908405", "75145896","2011-08-20", "2013-01-10" 
)
insert(pesquisador,cod_proj,data_inicio,data_final) values("23940071501", "35442851" ,"2016-09-17", "2018-04-21")

/* PEQUISADOR */
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("64482378798", "99844114", "UFPB - Campus João Pessoa","Superior Completo - Bacharelado" , 2020
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("23156909432", "34141937", "IFPB - Campus João Pessoa","Ensino Médio completo",	         2018
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("24344841158", "66672372", "UERJ - Campus Maracanã",   "Superior Completo - Pós graduado", 2000
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("76426078735", "34309530", "IFPE - Campus Recife",     "Superior incompleto - Tecnólogo",    2022
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("97723581319", "63963130", "UFCG - Campus Cajazeiras", "Superior incompleto - Bachalerado",2005)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("52107813647", "94079542", Null, Null, NULL
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("67781375505", "63998365", "UFMG - Campus Belo Horizonte", "Superior incompleto - Bachalerado", 2001
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("23940071501", "37983688", "UFMS - Campus Pantanal",    "Superior Completo - Pós graduado",   2000
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("63612908405", "79365839", "UFCG - Campus Cajazeiras",  "Superior Completo - Bachalerado",    2008
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("54052700597", "65981431", Null,Null,Null
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("71106412443", "15965869", "UFBA - Campus Salvador",    "Superior Completo - Tecnólogo",      2020
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("11581721927", "25797981", "UFSM - Campus Sachoeira Do Sul", "Superior Completo - Tecnólogo", 2021
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("41497522498", "76973274"  "UFSM - Campus Sachoeira Do Sul", "Superior incompleto - Bachalerado", Null
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("44028157706", "47628026", "UFBA - Campus Salvador",   "Superior incompleto - Pós graduado",      2007             
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("55537846543", "16623773", "UFSC - Campus Joinville",  "Superior Completo - Doutorado",      2004
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("83668066850", "88010090", "USP -  Campus São Carlos", "Superior Completo - Pós graduado",   2005                
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("99288674101", "98459854", "UFRJ - Campus Duque De Caxias", "Superior Completo - Doutorado", 1995
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("98503973901", "75655932", "UERJ - Campus Maracanã",    "Superior Completo - Pós graduado",  2018
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("64603661010", "18374189", "UFCG - Campus João Pessoa", "Superior Completo - Doutorado",   "2003"
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("67926064726", "15875125", "USP -  Campus São Carlos",  "Superior Completo - Tecnólogo",   2020
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("95385258415", "81647247", "UFRJ - Campus Duque De Caxias", "Superior Completo - Doutorado", "1985"
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("48949340860", "60874566", "UFPE - Campus Recife",    "Superior Completo - Bachalerado",  NULL
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("96837117408", "81417163", "UFC -  Campus Fortaleza", "Superior Completo - Doutorado",    "1986"
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("49879959485", "20233883", "UFBA - Campus Salvador",  "Superior Completo - Doutorado",    "1998"
)
insert PESQUISADOR( CPF,nume_id_cart,instituicao,grad_acad,concl_supe)
values("93417036542", "11589966", "UFMG - Campus Belo Horizonte", "Superior Completo - Bachalerado", 2021)

/* INGRESSO_DISPONÍVEL */

insert INGRESSO_DISPONIVEL(ID,tipo)
values("84376803", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("3121H045", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("251405U2", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5K63IG74", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("47243P85", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("C2L24B0R", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("42528BE7", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5N754P0G", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("4SPW7H14", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("L302C6M4", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("4Q7411M0", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("502FB233", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("AQ62133H", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("G5K5B214", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("KK112B77", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("241874P5", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("0L702053", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("21EN62X7", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("73732UJ3", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("1O73S073", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("P28H2355", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("US22G4P7", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5M5R58T4", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("FVH7E770", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("580I43UI", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("I8O77X62", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("SJI1V025", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("1Y3NE070", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("0JM5X857", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("2564CX65", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("WYL58V4O", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("SOF10258", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("58LPT5C5", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("8G28F154", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("7W46Y0G4", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("2668MVA6", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("T84G1175", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("147NQ737", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("3XS7G48Q", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("YI080AKB", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("N7H0L270", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("1V0772X7", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5727Q18E", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("2348XX5U", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("8M86536J", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("6J7S0230", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("8WIUW477", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("2W15GR6F", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5385SICA", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("04MD5Y18", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("414138FS", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("0UQ3GQ5W", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("41FFYM3F", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("88834GPO", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("60H30TA5", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("VNYG501L", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("I05436TB", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("4CC357C7", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("0EC08558", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("6G885435", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("U11XY5U5", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("3Y51RS7Q", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("11330451", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("558GF658", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("AH570060", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("K01W5KJ7", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("T565IN61", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("23205Y70", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("DL806DB3", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("8138872T", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("N1EE75L8", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("C275WKMY", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("618DI008", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5I624XF5", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("7121W4L7", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("14854750", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("066372FV", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("R5OP1K86", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("FQ60663B", 5);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("20325243", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("N3B535L4", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("6741VGK3", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("W226Q856", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("6DJSN854", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("UT804OKY", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("R46T7H35", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("I0705W8E", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("77M326A7", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5010VUU2", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("44V31567", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("004S4622", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("S5YY4O32", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("JK78B616", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("G5Q47M7O", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("K22U6508", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("V70B01U8", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("15763208", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("88853887", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("78ER2N55", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("418544X8", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("50124360", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("Q244686T", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("2723A715", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("00R81172", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("3R500H55", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("1H7H1114", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("75BJ25L5", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("1430TQ4R", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("4K650051", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("4B4366S2", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("OI4LN7H0", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("H1H3G3FC", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("28243247", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("HX6Q52V1", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("O51B1NF0", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("SB211165", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5H148508", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("812H1530", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("17L0GX8A", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("0401L8K1", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("D161020M", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("18GA163U", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("41034182", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("AC5OIL86", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("1234Q400", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("6522Q5M0", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("M5TT7P00", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("2C037166", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("10CAQ2W3", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("4146200I", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("4207863H", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("J7X43243", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("3232424M", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("75FH14GA", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("5N72Y286", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("EO2387F8", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("3W644IT8", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("R0GMJ443", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("8DHE7BO1", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("6G2746PS", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("18Q34007", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("04TC15G0", 1);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("3K664G70", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("11523058", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("0T337TL4", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("DU86YU4B", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("O13221I3", 2);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("274CSB2I", 4);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("513J6NNE", 3);
insert INGRESSO_DISPONIVEL(ID,tipo)
values("8H70V427", 4);

/* INGRESSOS_COMPRADOS */

INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("P61X26734V4", "83668066850","8G28F154",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("RN112702424", "99288674101","C275WKMY",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("4SS420275W5", "98503973901","77M326A7",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("0M07NK6SDQP", "64603661010","T565IN61",NULL,"2022-12-16");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("2M1660701FS", "67926064726","N7H0L270",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("88H7TT41GN5", "95385258415","O51B1NF0",NULL,"2022-12-15");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("2PFO07P7010", "48949340860","5010VUU2",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("075TG08687Y", "96837117408","6G885435",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("64C7236X264", "49879959485","3121H045",NULL,"2022-12-16");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("5FMG42A540B", "93417036542","004S4622",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("465S05028FF", "34228058507","8DHE7BO1",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("238YJ821KE1", "47994960006","0401L8K1",NULL,"2022-12-15");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("6L2Q5L187YO", "29934345781","11523058",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("2W46172I6V0", "38661444829","18GA163U",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("706Q1145S27", "58623066251","21EN62X7",NULL,"2022-12-15");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("2J3DP8A584F", "60590923145","4CC357C7",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("218375EH7LT", "71945058609","5385SICA",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("Q7J0066462G", "51218481706","558GF658",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("EJ33A87V532", "50914287630","R5OP1K86",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("4HNJPE54K37", "72313085708","78ER2N55",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("PD37003311X", "37353265523","20325243",NULL,"2022-12-15");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("186N8524RE1", "57095314802","2W15GR6F",NULL,"2022-12-15");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("I2I3238100J", "31295917025","58LPT5C5",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("H308D773352", "13725158282","580I43UI",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("26AUV7231U7", "87940104047","JK78B616",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("2Q1110384KL", "67584336841","N1EE75L8",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("N1DU45X11BW", "43335280032","3W644IT8",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("13YKW73N8IN", "96981046407","6741VGK3",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("46I87WT8EV2", "90320237729","U11XY5U5",NULL,"2022-12-15");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("74O8O7Q6E00", "94684010228","88853887",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("22L17118011", "35860652569","8M86536J",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("5B8N15G8500", "53852974534","SB211165",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("61850DDY4KP", "83943706168","1V0772X7",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("8781675E316", "14375303549","0L702053",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("353M7287M3E", "86063755861","AQ62133H",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("58N3PH3454D", "63782435818","6J7S0230",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("40561M7W317", "60159197287","KK112B77",NULL,"2022-12-15");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("876A15KJT81", "79889368919","15763208",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("JXV66772114", "73648130048","147NQ737",NULL,"2022-12-16");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("44WGE458584", "51833500350","42528BE7",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("42783F3V18B", "53220781187","2348XX5U",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("78U56236OXN", "33530650757","SJI1V025",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("2474458420M", "84251814100","41FFYM3F",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("R8S51DB2YU6", "47867205268","5H148508",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("25CD471M82V", "93298973122","AC5OIL86",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("40DW4WB8C33", "80247071102","4B4366S2",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("5618EF5G3W4", "26618488354","N3B535L4",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("KP45GQE064S", "40113187106","47243P85",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("GKD5288B06Q", "16950339496","5M5R58T4",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("DYW8N27C325", "12683202261","T84G1175",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("2J6664FE064", "10181769930","4146200I",NULL,"2022-12-15");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("JJ0SM543N36", "94567438450","K22U6508",NULL,"2022-12-19");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("S3I3W723M75", "97084191097","10CAQ2W3",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("0F173K05238", "63979484807","251405U2",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("2W5O4186120", "13921434386","0UQ3GQ5W",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("60603L8E25E", "68285106403","14854750",NULL,"2022-12-17");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("FM734CJLTVX", "40351060979","6G2746PS",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("377UE122FW7", "39496798551","17L0GX8A",NULL,"2022-12-16");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("824U0271EUB", "57423634948","EO2387F8",NULL,"2022-12-20");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("CH77826I516", "10670004294","WYL58V4O",NULL,"2022-12-18");
INSERT INGRESSOS_COMPRADOS(id_compra,comprador,ingresso,auxiliador_func,data_compra) VALUES("180J0YF3W27", "76596456412","Q244686T",NULL,"2022-12-18");

/* INGRESSO_CATALOGO */

insert (tipo_id,preco,area_perm,cor) values('ADULTO', '15.00', 'Áreas de lazer; Parte externa dos habitats e estufas;', 'AZUL');
insert (tipo_id,preco,area_perm,cor) values('PESQUISADOR', '10.00', 'Áreas de lazer; Parte externa e interna dos habitats e estufas; Àreas de pesquisa e coleta de amostras;', 'VERDE');
insert (tipo_id,preco,area_perm,cor) values('INFANTIL', '5.00', 'Áreas de lazer; Parte externa dos habitats e estufas; Praça infantil;', 'AMARELO');
insert (tipo_id,preco,area_perm,cor) values('ESCOLAR', '3.50', 'Áreas de lazer; Parte externa dos habitats e estufas; Àreas de diversão extremas; Praça Infantil; Espaço na área de Amostra', 'VERMELHO');
insert (tipo_id,preco,area_perm,cor) values('APRECIANTE DE COMIDA EXÓTICA', '0.00', 'Parte interna dos habitats e estufas; restaurante privado', 'PÚRPURA');

/* HABITAT */

insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("WKUPCFJBXV", True, "neve", 1);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("WWQQNSJWVQ", False, "areia", 6);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("THDRHUABEV", True, "rocha", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("URUMXODBTH", True, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("IWQXWMKTBW", False, "híbrido", 5);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("OIERVHEHLR", False, "granito", 2);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("SZTOKXPWJO", True, "neve", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("KBWQNIRNZZ", True, "híbrido", 4);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("VDDFYLAMZV", True, DEFAULT, 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("YHWYZVBWAI", False, "neve", 1);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("OZNYQASVOP", False, "granito", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("OQMGEHZRRG", False, "areia", 5);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("WSSCNMTLHC", True, Default, 9);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("XIRUZGRBAI", True, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("TETZVZOOFR", True, Default, 5);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("MELQHANYVP", True, "granito", 9);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("XLDBUKVVNM", False, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("JPGICPVWWH", False, DEFAULT, 5);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("GSUYEEDLGN", False, "híbrido", 8);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("BGURSDPASI", False, Default, 5);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("DCAZGJVPMJ", True, "granito", 1);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("BIGKQLNQSB", True, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("ZDVRGKWSHK", True, "areia", 4);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("MNZRINWTPZ", True, "neve", 2);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("KOCIISRBFF", True, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("AWGKBAJRFQ", False, "granito", 4);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("HUPZCKBPCL", False, Default, 7);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("JDHRQCBYQF", False, "neve", 5);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("PQQNMNOTRE", False, "areia", 2);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("EZUMVXICDS", False, Default, 9);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("PKKPZHRYSC", True, "granito", 9);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("APLEOUASAG", True, "rocha", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("TEJAGKPHLM", True, "híbrido", 4);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("ILYAXWQZDK", True, "rocha", 2);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("WXRWRJQJRT", True, "híbrido", 9);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("OFORHMUICA", False, "híbrido", 2);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("WDGBAMCIQB", False, Default, 10);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("SXLXRAVMQE", False, "rocha", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("POYKKGLRTP", False, "areia", 7);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("HXIXSRZMYD", False, "granito", 8);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("FDJUYIMSUY", False, "rocha", 7);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("HHGLOZQUDW", False, Default, 5);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("IHLJDRJURM", True, "rocha", 6);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("MJGFTHGOJS", False, Default, 10);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("CFVJBWQYJX", True, "granito", 9);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("KZDUDCQEOU", False, Default, 9);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("FLTJREKWRX", True, "areia", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("DHLGWTQAWD", False, "granito", 1);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("QFLPIHDGNC", True, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("TNUNYGZNRD", True, "neve", 6);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("EZACYYNISU", False, "granito", 8);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("UZEAMZNXAN", False, "granito", 2);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("ANVWQWPXYT", False, "areia", 6);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("VUYPUXJAZB", False, Default, 2);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("VAWGOAEZIH", False, "neve", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("LSOIXLADKC", False, "granito", 2);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("DEARFJQZAI", False, "granito", 4);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("TQPEGWXCYV", False, "neve", 8);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("XCWCYASPTN", False, Default, 8);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("NQPBFXEHGP", True, Default, 1);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("FVSXYSBZNQ", False, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("MJGPNUSNNH", True, "neve", 5);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("OXFUQXXTGV", True, "granito",6);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("BWHIALZRBB", True, "granito", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("AAOILQDASH", True, "areia", 1);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("KYTDNXRCTH", False, "granito", 6);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("THGMZTSIDB", False, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("UGDFSKWZRQ", True, "areia", 3);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("RUSMRIHOVK", False, "neve", 9);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("NTZZHUZKXG", False, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("RXHRFGDGLO", False, "granito", 4);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("QLQOCBYDEH", False, "água", DEFAULT);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("BVEVLDUUGA", False, "areia", 1);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("PTDNZUENPG", True, "granito", 8);
insert HABITAT(ID,fosso,tipo_solo,arvore_quant) values("IRTBPKZIVB", True, "água", DEFAULT);

/* FORNECEDOR */

insert FORNECEDOR(CNPJ,ENDERECO, nome_fant)
values("75108761000160", "Av. Francislau, 40, Edifício João Cléber, apartamento 20 - Centro - João Pessoa - Paraíba", "Imaculada Alimentos LTDA"
);
insert FORNECEDOR(CNPJ,ENDERECO, nome_fant)
values("11661872000117", "Rua Rodofreldo, 190, perto do lado da oficina do Romeu - Cristo - João Pessoa - Paraíba", "Djique Manutenção de Habitats LTDA"
);
insert FORNECEDOR(CNPJ,ENDERECO, nome_fant)
values("80799660000113", "Av. Dom João Figueredo, 410, de frente ao Mercado da Barganha - Geisel - João Pessoa - Paraíba", "Vulgo Castro Materiais de Limpeza LTDA"
);
insert FORNECEDOR(CNPJ,ENDERECO, nome_fant)
values("07530555000194", "Av. Jabuticaba, 128 - Saúde - São Paulo - São Paulo", "Alfredo Jaulas LTDA"
);
insert FORNECEDOR(CNPJ,ENDERECO, nome_fant)
values("08917962000111", "Rua da Jumenta, 400, via Expressa de Café com Leite - Chade - Florianópoles - Santa Catarina", "Ultrafarma Comercio de Produtos Farmaceuticos LTDA" 
);
insert FORNECEDOR(CNPJ,ENDERECO, nome_fant)
values("97429620000182", "Av. do Cabrito, 24, por trás da loja Brasilianos - Maneiro - Manaus - Amazonas", "Haiz Frutas Naturais LTDA"
);
insert FORNECEDOR(CNPJ,ENDERECO, nome_fant)
values("96793493000133", "Rua dos Faz Tudo e Mais um pouco, 9, ao lado da creche - Bessa - João Pessoa - Paraíba", "João Bosco Equipamento Veterinário"
);
insert FORNECEDOR(CNPJ,ENDERECO, nome_fant)
values("37829203000132", "Av. João Boscudo, 10, em frente a Palhoça do Açougueiro - Centro - Recife - Pernambuco", "Loki Equipamento Profissional");

/* FORNECEDOR_EMAIL */

insert FORNECEDOR_EMAIL(CNPJ, email) values ("75108761000160", "imaculadaalimentos@gmail.com");
insert FORNECEDOR_EMAIL(CNPJ, email) values ("11661872000117", "djiquemanutencao@email.com");
insert FORNECEDOR_EMAIL(CNPJ, email) values ("80799660000113", "saopaulino.carnes@yahoo.com");
insert FORNECEDOR_EMAIL(CNPJ, email) values ("07530555000194", "alfredojaulas@outlook.com");
insert FORNECEDOR_EMAIL(CNPJ, email) values ("08917962000111", "ultrafarma.farma@gmail.com");
insert FORNECEDOR_EMAIL(CNPJ, email) values ("97429620000182", "haiz.frutas@gmail.com");
insert FORNECEDOR_EMAIL(CNPJ, email) values ("96793493000133", "joaobosco@equipamento.vet.com");

/* EXAME_ANIMAL */

insert EXAME_ANIMAL(data_exam, veterinario, animal) values("2010-07-12", "75256732345", "F8420I25K8");
insert EXAME_ANIMAL(data_exam, veterinario, animal) values("2021-01-28", "69535214606", "68306448J5");
insert EXAME_ANIMAL(data_exam, veterinario, animal) values("2022-07-02", "65129976022", "S8X5LA03CR");
insert EXAME_ANIMAL(data_exam, veterinario, animal) values("2022-05-12", "58756599949", "3461J17382");
insert EXAME_ANIMAL(data_exam, veterinario, animal) values("2004-12-24", "21424074564", "32QGTNHP80");
insert EXAME_ANIMAL(data_exam, veterinario, animal) values("2020-11-05", "65068305179", "14W4G81L60");
insert EXAME_ANIMAL(data_exam, veterinario, animal) values("2018-02-17", "60962609123", "3U8X2YL04O");
insert EXAME_ANIMAL(data_exam, veterinario, animal) values("2018-02-17", "46894747871", "3I61750241");

/* ANIMAL_INTERNADO */

insert(setor,animal,data_entr,data_saida)
values("1201", "F8420I25K8", "2021-28-01", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1301", "68306448J5", "2010-12-07", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1303", "S8X5LA03CR", "2022-02-07", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1105", "3461J17382", "2022-12-05", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1301", "32QGTNHP80", "2004-24-12", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1305", "14W4G81L60", "2020-05-11", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1305", "3U8X2YL04O", "2018-17-02", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1301", "3I61750241", "2008-18-04", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1301", "6S32130145", "2020-30-01", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1303", "2E5Y77S550", "2022-24-05", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1603", "A5V5IVG0E0", "2011-06-04", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1604", "74CH07608D", "2022-12-04", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1604", "M261603122", "2011-15-03", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1102", "05W0NOY832", "2020-05-01", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1105", "UJ72152U1H", "2022-15-07", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1102", "08524L2187", "2012-17-05", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1201", "11J0X058LR", "2000-18-03", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1604", "S001410K26", "2022-15-08", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1604", "15FX04E60F", "2021-19-01", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1604", "N452322623", "2022-26-07", NULL
)
insert(setor,animal,data_entr,data_saida)
values("1102", "P70554I0AM", "2021-01-03", "2021-02-02"
)
insert(setor,animal,data_entr,data_saida)
values("1105", "M35027O253", "2010-28-08", "2010-12-10"
)
insert(setor,animal,data_entr,data_saida)
values("1102", "I7L7837T5U", "2022-09-08", "2022-02-09"
)
insert(setor,animal,data_entr,data_saida)
values("1105", "3461J17382", "2022-24-04", "2022-17-05"
)
insert(setor,animal,data_entr,data_saida)
values("1204", "R14RQ8O886", "2005-7-12", "2005-5-12"
)
insert(setor,animal,data_entr,data_saida)
values("1204", "I2256N2K52", "2022-10-11", "2022-16-11"
)
insert(setor,animal,data_entr,data_saida)
values("1204", "M261603122", "2018-25-06", "2018-01-07"
)
insert(setor,animal,data_entr,data_saida)
values("1102", "NTP764E45E", "2009-09-09", "2009-12-09"
)
insert(setor,animal,data_entr,data_saida)
values("1102", "05W0NOY832", "2020-10-12", "2020-12-12"
)
insert(setor,animal,data_entr,data_saida)
values("1304", "06LV43MR04", "2022-2-01", "2022-17-05"
)
insert(setor,animal,data_entr,data_saida)
values("1304", "8267Y03574", "2012-10-02", "2012-16-02"
)
insert(setor,animal,data_entr,data_saida)
values("1102", "45803578T7", "2011-2-08", "2011-2-08"
)
insert(setor,animal,data_entr,data_saida)
values("1304", "05W0NOY832", "2022-2-01", "2022-15-02")

/* ANIMAIS */

insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("6DH5Y663K5", "2010-11-13", "saudável", "Caninus Lupus", "lobinho", "carnivoro", "temperado", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("L48PCE5300", "2007-4-27", "saudável", "Hippopotamus amphibius", "Hipopótamo", "onívoro", "quente", `IHLJDRJURM`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("6CS4167N26", "2022-8-2", "saudável", "Leopardus pardalis", "Jaguatirica", "carnívoro", "quente", `VUYPUXJAZB`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("24HHY21O88", "2007-5-22", "DEFAULT", "Chrysocyon brachyurus", "Lobo guará", "carnívoro", "temperado", `DHLGWTQAWD`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("74CH07608D", "2006-8-9", "mórbido", "Panthera tigris", "Tigre", "carnívoro", "temperado", `RXHRFGDGLO`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("J514084851", "2021-3-13", "saudável", "Bubalus", "Búfalo", "herbívoro", "quente", `TETZVZOOFR`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("5307438347", "2021-11-28", "saudável", "Boa constrictor", "Jiboia", "carnívoro", "temperado", `MELQHANYVP`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("F8420I25K8", "1999-3-21", "enfermo", "Lynx", "Lince", "carnívoro", "temperado", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("68306448J5", "1998-6-21", "enfermo", "Panthera onca", "Onça pintada", "carnívoro", "temperado", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("S8X5LA03CR", "2010-6-14", "enfermo", "Hippopotamus amphibius", "Hipopótamo", "onívoro", "quente", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("41O538F355", "2010-1-11", "saudável", "Hyaenidae", "Hiena", "carnívoro", "temperado", `WDGBAMCIQB`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("32QGTNHP80", "2014-1-26", "enfermo", "Lynx", "Lince", "carnívoro", "temperado", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("7383EC1380", "1998-8-6", "saudável", "Equus zebra", "Zebra", "herbívoro", "temperado", `UZEAMZNXAN`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("P70554I0AM", "2018-3-6", "saudável", "Chrysocyon brachyurus", "Lobo guará", "carnívoro", "temperado", `EZACYYNISU`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("3B0352X5I7", "2022-9-9", "saudável", "Hydrochoerus hydrochaeris", "Capivara", "herbívoro", "aquático", `FVSXYSBZNQ`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("6STK3UUNLU", "2014-11-24", "saudável", "Ursus maritimus", "Urso polar", "onívoro", "frio", `OXFUQXXTGV`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("14W4G81L60", "2013-1-16", "enfermo", "Lynx", "Lince", "carnívoro", "temperado", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("3W0OGC27U0", "2021-9-26", "saudável", "Hippopotamus amphibius", "Hipopótamo", "onívoro", "quente", `MJGFTHGOJS`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("04S3H7F67K", "2005-12-26", "DEFAULT", "Bubalus", "Búfalo", "herbívoro", "quente", `TETZVZOOFR`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("XT2O65QV64", "2005-1-21", "saudável", "Canis latrans", "Coiote", "carnívoro", "temperado", `CFVJBWQYJX`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("VL1KIL106P", "2010-11-23", "saudável", "Macropus rufus", "Canguru vermelho", "herbívoro", "quente", `VDDFYLAMZV`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("M35027O253", "2005-10-22", "saudável", "Inia geoffrensis", "Boto cor de rosa", "peixivoro", "aquático", `URUMXODBTH`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("351756I505", "2015-7-29", "saudável", "Macropus rufus", "Canguru vermelho", "herbívoro", "quente", `HXIXSRZMYD`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("A0627B11D3", "2021-7-11", "saudável", "Chiroptera", "Morcego", "onívoro", "temperado", `POYKKGLRTP`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("7J77C30002", "2003-1-9", "saudável", "Haliaetus leucocephalus", "Águia de cabeça branca", "carnívoro", "temperado", `JPGICPVWWH`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("6X35843818", "2016-9-9", "saudável", "Panthera onca", "Onça pintada", "carnívoro", "temperado", `ZDVRGKWSHK`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("NTP764E45E", "2005-6-1", "saudável", "Leopardus pardalis", "Jaguatirica", "carnívoro", "quente", `THDRHUABEV`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("6523R0E8YI", "2021-12-17", "saudável", "Chiroptera", "Morcego", "onívoro", "temperado", `KYTDNXRCTH`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("U3O006U653", "2020-10-2", "saudável", "Haliaetus leucocephalus", "Águia de cabeça branca", "carnívoro", "temperado", `JPGICPVWWH`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("IIL15H37SS", "2005-11-2", "saudável", "Boa constrictor", "Jiboia", "carnívoro", "temperado", `OQMGEHZRRG`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("I7L7837T5U", "2013-10-26", "saudável", "Phascolarctos cinereus", "Coala", "herbívoro", "quente", `PTDNZUENPG`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("3U8X2YL04O", "2005-10-22", "enfermo", "Leopardus pardalis", "Jaguatirica", "carnívoro", "quente", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("0OG5U2V536", "2001-11-24", "DEFAULT", "Manis pentadactyla", "Pangolim chinês", "onívoro", "temperado", `DEARFJQZAI`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("UEY7A5502D", "2021-3-18", "saudável", "Sus scrofa", "Javali", "onívoro", "Temperado", `TEJAGKPHLM`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("6RA6MY6603", "2002-4-10", "DEFAULT", "Giraffa", "Girafa", "herbívoro", "quente", `EZUMVXICDS`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("M261603122", "2018-9-12", "mórbido", "Coragyps atratus", "Urubu de cabeça preta", "carniceiro", "temperado", `KZDUDCQEOU`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("3461J17382", "1999-12-27", "saudável", "Bubalus", "Búfalo", "herbívoro", "quente", `ILYAXWQZDK`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("3YTMWQ0G85", "2004-9-1", "saudável", "Leopardus pardalis", "Jaguatirica", "carnívoro", "quente", `ANVWQWPXYT`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("3I61750241", "2002-10-4", "enfermo", "Giraffa", "Girafa", "herbívoro", "quente", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("8724E047O0", "2016-11-14", "saudável", "Ursus maritimus", "Urso polar", "onívoro", "frio", `TQPEGWXCYV`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("QAY126C7D0", "2006-9-10", "saudável", "Hyaenidae", "Hiena", "carnívoro", "temperado", `IWQXWMKTBW`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("I5341S44X3", "2010-11-2", "saudável", "Phascolarctos cinereus", "Coala", "herbívoro", "quente", `NQPBFXEHGP`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("R14RQ8O886", "2000-7-4", "saudável", "Giraffa", "Girafa", "herbívoro", "quente", `BWHIALZRBB`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("5265V4U534", "2003-12-25", "saudável", "Hydrochoerus hydrochaeris", "Capivara", "herbívoro", "aquático", `SXLXRAVMQE`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("S001410K26", "2015-11-16", "mórbido", "Sus scrofa", "Javali", "onívoro", "Temperado", `FLTJREKWRX`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("1VB654O1V4", "2012-12-14", "saudável", "Lynx", "Lince", "carnívoro", "temperado", `KBWQNIRNZZ`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("1K2327TM46", "2017-8-29", "saudável", "Equus zebra", "Zebra", "herbívoro", "temperado", `HHGLOZQUDW`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("I2256N2K52", "2014-4-4", "saudável", "Pelecanus", "Pelicano", "Carnívoro", "aquático", `THGMZTSIDB`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("45803578T7", "2004-12-12", "saudável", "Bubalus", "Búfalo", "herbívoro", "quente", `BVEVLDUUGA`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("15FX04E60F", "2008-1-25", "mórbido", "Chrysocyon brachyurus", "Lobo guará", "carnívoro", "temperado", `DHLGWTQAWD`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("V41H5460L5", "2015-7-25", "saudável", "Manis pentadactyla", "Pangolim chinês", "onívoro", "temperado", `UGDFSKWZRQ`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("3U652C1772", "2015-2-7", "saudável", "Haliaetus leucocephalus", "Águia de cabeça branca", "carnívoro", "temperado", `AWGKBAJRFQ`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("8267Y03574", "2003-6-25", "saudável", "Coendou prehensilis", "Porco espinho", "frutífero", "temperado", `WWQQNSJWVQ`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("6S32130145", "2008-7-2", "enfermo", "Bubalus", "Búfalo", "herbívoro", "quente", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("KRQ63152U2", "2000-11-13", "DEFAULT", "Myrmecophaga tridactyla", "Tamanduá bandeira", "insectívoro", "quente", `WSSCNMTLHC`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("A8516BU7M3", "2006-4-6", "saudável", "Equus zebra", "Zebra", "herbívoro", "temperado", `UZEAMZNXAN`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("7HX2UR5611", "2001-5-22", "DEFAULT", "Macropus rufus", "Canguru vermelho", "herbívoro", "quente", `AAOILQDASH`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("N452322623", "2005-5-20", "mórbido", "Pelecanus", "Pelicano", "Carnívoro", "aquático", `OFORHMUICA`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("2E5Y77S550", "2020-11-20", "enfermo", "Ursus maritimus", "Urso polar", "onívoro", "frio", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("K48682837S", "2021-5-3", "saudável", "Phascolarctos cinereus", "Coala", "herbívoro", "quente", `APLEOUASAG`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("06LV43MR04", "2022-6-4", "saudável", "Tapirus terrestris", "Anta", "herbívoro", "temperado", `FDJUYIMSUY`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("074152F8SJ", "2008-7-21", "saudável", "Pteronura brasiliensis", "Ariranha", "onívoro", "aquático", `QFLPIHDGNC`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("34B08S2548", "2014-3-16", "saudável", "Ursus maritimus", "Urso polar", "onívoro", "frio", `PKKPZHRYSC`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("0N20382588", "2010-1-11", "saudável", "Ursus maritimus", "Urso polar", "onívoro", "frio", `DCAZGJVPMJ`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("735B65E54M", "2020-3-28", "saudável", "Manis pentadactyla", "Pangolim chinês", "onívoro", "temperado", `UGDFSKWZRQ`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("0ND25G6YUL", "2006-10-1", "saudável", "Tapirus terrestris", "Anta", "herbívoro", "temperado", `BGURSDPASI`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("7K3177EJC2", "2016-1-10", "saudável", "Canis latrans", "Coiote", "carnívoro", "temperado", `WXRWRJQJRT`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("D8287H7704", "2013-3-19", "saudável", "Canis latrans", "Coiote", "carnívoro", "temperado", `CFVJBWQYJX`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("A5V5IVG0E0", "2012-11-10", "enfermo", "Canis latrans", "Coiote", "carnívoro", "temperado", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("05W0NOY832", "2007-11-17", "enfermo", "Equus zebra", "Zebra", "herbívoro", "temperado", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("UJ72152U1H", "2018-12-10", "enfermo", "Equus zebra", "Zebra", "herbívoro", "temperado", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("3843A573T0", "1998-9-28", "saudável", "Ursus maritimus", "Urso polar", "onívoro", "frio", `VAWGOAEZIH`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("0614B54E51", "2008-6-10", "saudável", "Phascolarctos cinereus", "Coala", "herbívoro", "quente", `APLEOUASAG`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("08524L2187", "2005-6-5", "enfermo", "Leopardus pardalis", "Jaguatirica", "carnívoro", "quente", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("2M175UV26S", "2014-10-24", "saudável", "Lynx", "Lince", "carnívoro", "temperado", `KBWQNIRNZZ`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("11J0X058LR", "2008-9-8", "enfermo", "Hydrochoerus hydrochaeris", "Capivara", "herbívoro", "aquático", Null
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("88X6612617", "2011-5-25", "saudável", "Panthera tigris", "Tigre", "carnívoro", "temperado", `RXHRFGDGLO`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("D46X4G3N57", "2013-5-5", "DEFAULT", "Hydrochoerus hydrochaeris", "Capivara", "herbívoro", "aquático", `KOCIISRBFF`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("770005EWO3", "2002-10-16", "saudável", "Hydrochoerus hydrochaeris", "Capivara", "herbívoro", "aquático", `XLDBUKVVNM`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("2QLT05P1Q3", "2022-10-26", "saudável", "Carcharodon carcharias", "Tubarão branco", "carnívoro", "aquático", `BIGKQLNQSB`
);
insert ANIMAL(ID,data_cheg,nome_cien,nome_popu,alimentacao,clima_adap,habitat);
values("QQ6385544A", "2007-10-28", "saudável", "Hyaenidae", "Hiena", "carnívoro", "temperado", `IWQXWMKTBW`);

/* ALAS CLÍNICAS */

insert ALA_CLINICA(setor_nume,alas_livre) values(1101,20);
insert ALA_CLINICA(setor_nume,alas_livre) values(1102,20);
insert ALA_CLINICA(setor_nume,alas_livre) values(1103,20);
insert ALA_CLINICA(setor_nume,alas_livre) values(1104,20);
insert ALA_CLINICA(setor_nume,alas_livre) values(1105,20);

/* FUNCIONÁRIO */

insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("90807296975","13635678","Maria nascimento","Motorista", "2826,00", "69098273", "Travessa Cristal", "Novo Aleixo" "Manaus", "32019835473", "85268084806")
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("75256732345","18845678","Maria filha","Veterinário", "13750,00", "65045231", "Travessa da Companhia", "Anil", "Sao Luis", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("69535214606","19945678","Maria nascimento","Veterinário", "13750,00", "34580390", "Rua Rio Branco", "Sao Jose", "Sabaru",  "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("65129976022","13345678","Maria nazare","Veterinário", "13750,00", "21832125", "Rua Sao Boroncio", "Senador Camara", "Rio de Janeiro",  "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("83085118309","10045678","Maria yaeger","Veterinário", "13750,00", "44055010", "Rua Anajas", "Parque Ipa", "Feira de Santana", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("74439631056","11145675","Maria sousa","Veterinário", "13750,00", "96040140", "Rua Dirceu de avila Martins", "Fragata", "Pelotas",  "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("58756599949","11434567","Maria rosario","Veterinário", "13750,00", "58056694", " Rua Gecy Mercus Rodrigues", "Mangabeira", "Joao Pessoa", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("31231056284","15994567","Maria constatino","Manutenção_Habitat", "11840,00"", "69915300", "Conjunto Universitario", "Distrito Industrial", "Rio Branco" , "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("69251120876","15345678","Maria pereira","Veterinário", "13750,00", "83602566", "Rua Joao Tigrinho de Freitas", "Moradias Bom Jesus", "Campo Largo" , "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("67171010227","14992578","Maria silveiro","Motorista", "2826,00", "69908300", "Rua Joao Onofre", "Bosque", "Rio Branco", "32019835473", "13524927570")
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("31952488027","14885978","Rosana walker","Manutenção_Habitat", "11840,00"", "69306400", "Rua Jaricuna", "Nossa Senhora Aparecida", "Boa Vista", "32019835473" , NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("32733226752","19114578","Rosana Jalim","Veterinário", "13750,00", "65068286", "Rua Sol Nascente", "Vila Alonso Costa" , "Sao Luas"  , "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("21424074564","10445679","Rosana trajano","Veterinário", "13750,00", "69311064", "Rua X", "Cauama", "Boa Vista", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("72427309663","14045675","Rosana auricolia","Manutenção_Habitat", "11840,00"","78058422", "Rua Cinquenta e Cinco", "CPA III", "Cuiaba" , "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("60962609123","14645672","Rosana azumabito","Veterinário", "13750,00", "11454450", "Rua Guaratinguete", "Vila aurea (Vicente de Carvalho)", "Guaruja", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("39933253849","14545671","Ednaldo pereira","Veterinário", "13750,00", "69055737", "Condominio Parque dos Rios IV", "Parque 10 de Novembro", "Manaus", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("85996361750","14345672","Antonia inicio","Motorista", "2826,00", "69022324", "Rua 32", "Taruma-Aau", "Manaus", "32019835473", "08513151531")
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("77871602871","14399672","Rosana mauer","Manutenção_Habitat", "11840,00"", "64065290", " Rua Cachoeirinha", "Pedra Mole", "Teresina", "Piaua", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("51210234964","13345671","Rosana rothschild","Veterinário", "13750,00", "69304455", "Rua do Canario", "Mecejana", "Boa Vista", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("20777706533","13345672","Rosana alves","Manutenção_Habitat", "11840,00"", "11840,00"", "39406122", "Rua Cinco", "Colorado", "Montes Claros", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("61221444108","13345673","Andre filho","Manutenção_Habitat", "11840,00"", "27280755", "Servidao Carangola", "Vila Brasilia", "Volta Redonda" , "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("46894747871","13345674","Andre grifth","Veterinário", "13750,00", "74943380", "Rua Larga", "Jardim Buriti Sereno", "Aparecida de Goiania", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("65068305179","13345675","Andre lima","Veterinário", "13750,00", "69304467", "Rua Elias Pessoa", "Mecejana", "Boa Vista", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("44858232350","91545675","Matheus yakuza","Manutenção_Habitat", "11840,00"", "69312369", "Rua Sao Camilo", "Cinturao Verde" , "Boa Vista", "32019835473", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("48268852374","13345676","Manoel gomes","Veterinário", "13750,00", "57071208", "Rua Anadia", "Clima Bom", "Maceia", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("13522722755","13345677","Andre rockfeller","Manutenção_Habitat", "11840,00"", "63041-150", "Rua Engenheiro Carlos Alberto Bezerra", "Triangulo", "Juazeiro do Norte" , "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("41410814732","43345678","Andre musk","Motorista", "2826,00", "69317338", "Rua Luiz Reis Cristo", "Equatorial", "Boa Vista", "99009951", "67628669617")
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("88484251424","11345679","Ellon musk","Veterinário", "13750,00", "59069700", "Rua Camargo", "Pitimbu", "Natal" , "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("85846242728","41345648","Andre nascimento","Veterinário", "13750,00", "76912886", "Rua Santa Clara", "Jorge Teixeira", "Ji-Parana", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("82508474673","71345628","Bolsonaro messias","Veterinário", "13750,00", "77016352", "Quadra 603 Sul Alameda 10", "Plano Diretor Sul", "Palmas",  "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("19313860678","81345638","Fernando suarez","Veterinário", "13750,00", "05869223", "Rua Dois", "Jardim Sania Inga" , "Sao Paulo" , "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("22292435668","91345658","Daniel alves","Veterinário", "13750,00", "79839013", "Rua das Mangueiras", "Jardim Colibri", "Dourados", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("63969744381","13456978","Neymar junior","Motorista", "2826,00", "74461230", "Rua Maria Angalica Miguel", "Jardim Clarissa", "Goiania", "44674106", "67628669617")
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("24766270906","13456948","Fernando junior","Manutenção_Habitat", "11840,00"", "79106380", " Rua Gabriel Bertoni" , "Vila Popular", "Campo Grande", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("48988178049","19456938","Fernando silva","Veterinário", "13750,00", "88355065", "Rua SZ - 015", "Steffen", "Brusque", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("51803701120","10456948","Fernanda nascimento","Manutenção_Habitat", "11840,00"", "76813826", "Estrada dos Periquitos", "Ulysses Guimaraes", "Porto Velho" , "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("73671696377","10362789","Fernando matheus","Veterinário", "13750,00", "88075315" , "Vila Joao Vaz Sobrinho", "Balneario", "Florianapolis", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("58872151658","19396378","Fernando cipriano","Veterinário", "13750,00", "31870700", "Rua Olavo Ferreira", "Ribeiro de Abreu", "Belo Horizonte", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("20389313192","19547478","Joana souza","Motorista", "2826,00", "69316550", "Rua Genasio Alcimiro Lopes", "Senador Halio Campos", "Boa Vista", "67628669617", "10089149813")
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("63718324745","10397578","Fernando matheus","Veterinário", "13750,00", "89287303", "Rua Rodolfo Stoerberl" , "Rio Negro", " Sao Bento do Sul", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("16707201349","10479698","Jose cerra","Veterinário", "13750,00", "82970300", "Rua Reverendo Mariano Rodrigues de Castro", "Cajuru", "Curitiba" , "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("15377615636","18447738","Valquria lima","Veterinário", "13750,00", "78128588", "Rua Ezequiel Atanasio", "Santa Maria I", "Varzea Grande" , "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("65406506173","18947838","Jose paulo","Veterinário", "13750,00", "59064340", "Rua Anabal Correia", "Candelaria", "Natal", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("40752683541","18547038","Jose inacio","Manutenção_Habitat", "11840,00"", "49042590", " Rua Francisco Rollemberg Ramos", " Sao Conrado", "Aracaju", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("46118439458","14047138","Jose pinto","Manutenção_Habitat", "11840,00"", "93544385", "Rua Joao Antanio Alves", "Canudos", " Novo Hamburgo", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("84657959574","15047338","Jose ksovs","Manutenção_Habitat", "11840,00"", "79085033", "Rua Leancio de Souza Britto", "Conjunto Aero Rancho", "Campo Grande", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("66529304676","16047138","Jose Nascimento","Motorista", "2826,00", "21362150", " Rua Aparecida", "Madureira", "Rio de Janeiro", "41823009", "67628669617")
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("58091379185","17047238","Jose Pereira","Manutenção_Habitat", "11840,00"", "41260260", "Largo das Araras", "Canabrava", "Salvador", "67628669617", NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("32019835473","18047438","Jose Sousa","gerente", "11840,00"", "25680361", "Rua Presidente Kubitscheck", "Retiro", "Petrapolis", NULL , NULL )
insert FUNCIONARIO(matricula, CPF, nome, funcao, salario, CEP, rua, bairro, cidade, gerente, CHN) values ("67628669617","19036138","Jose Silva","gerente", "11840,00"", "56912330", "Rua Vania Maria F. Silva", "Varzea", "Serra Talhada", NULL , NULL )

/* MANUTENÇÃO HABITAT */

insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("THDRHUABEV", "31231056284", "2022-05-20", NULL, "Reforma no habitat")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("OZNYQASVOP", "31952488027", "2020-06-25", "2020-06-27", "Inovação para melhoramente do bem-estar animal")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("WSSCNMTLHC", "24766270906", "2004-08-19", "2003-12-15", "Reforma no habitat")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("XIRUZGRBAI", "51803701120", "2009-03-30", "2008-04-05", "Reforma no habitat")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("TETZVZOOFR", "13522722755", "2021-07-26", "2021-07-26", "Inovação para melhoramente do bem-estar animal")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("KOCIISRBFF", "44858232350", "2014-07-27", "2014-07-27", "Manutenção emergencial")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("AWGKBAJRFQ", "72427309663", "2022-02-17", "2022-02-18", "Manutenção emergencial")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("EZUMVXICDS", "31952488027", "2021-07-15", "2021-07-24", "Inovação para melhoramente do bem-estar animal")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("TEJAGKPHLM", "77871602871", "2022-06-16", "2021-02-04", "Inovação para melhoramente do bem-estar animal")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("TEJAGKPHLM", "61221444108", "2022-07-06", NULL, "Manutenção emergencial")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("MJGPNUSNNH", "20777706533", "2022-09-24", NULL, "Manutenção emergencial")
insert MANUTENCAO_HABITAT(habitat, funcionario, data_inicio, data_final, descricao) values ("VAWGOAEZIH", "72427309663", "2022-03-31", NULL, "Manutenção emergencial")

/* PRESCRIÇÃO_EXAME */

insert PRESCRICAO_EXAME(data_exam, veterinario, animal, remedio) values ("2010-07-12", "75256732345", "F8420I25K8", "FAMNANAC")
insert PRESCRICAO_EXAME(data_exam, veterinario, animal, remedio) values ("2021-01-28", "69535214606", "68306448J5", "FAMCOWOW")
insert PRESCRICAO_EXAME(data_exam, veterinario, animal, remedio) values ("2022-07-02", "65129976022", "S8X5LA03CR", "FARIWWWX")
insert PRESCRICAO_EXAME(data_exam, veterinario, animal, remedio) values ("2018-02-17", "46894747871", "3I61750241", "FARIWWWX")
insert PRESCRICAO_EXAME(data_exam, veterinario, animal, remedio) values ("2022-05-12", "58756599949", "3461J17382", "FAMNANAC")
insert PRESCRICAO_EXAME(data_exam, veterinario, animal, remedio) values ("2004-12-24", "21424074564", "32QGTNHP80", "FAMNANAC")
insert PRESCRICAO_EXAME(data_exam, veterinario, animal, remedio) values ("2020-11-05", "65068305179", "14W4G81L60", "FARWENIU")
insert PRESCRICAO_EXAME(data_exam, veterinario, animal, remedio) values ("2018-02-17", "60962609123", "3U8X2YL04O", "FAMNANAC")

/* VETERINÁRIOS */

insert VETERINARIO(matricula, CRMV, setor_resp) values ("75256732345" ,"CRMV-CE n°4037", 1101)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("69535214606" ,"CRMV-AM n°2889", 1101)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("65129976022" ,"CRMV-MA n°1403", 1103)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("83085118309" ,"CRMV-RS n°3408", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("74439631056" ,"CRMV-RR n°1463", 1105)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("58756599949" ,"CRMV-PB n°5326", 1105)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("69251120876" ,"CRMV-RJ n°5522", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("32733226752" ,"CRMV-PE n°6520", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("51210234964" ,"CRMV-RS n°2530", 1105)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("21424074564" ,"CRMV-BA n°5520", 1105)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("60962609123" ,"CRMV-RJ n°3895", 1102)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("39933253849" ,"CRMV-MS n°2214", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("46894747871" ,"CRMV-SE n°1893", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("65068305179" ,"CRMV-RN n°7777", 1103)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("48268852374" ,"CRMV-PR n°8015", 1102)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("88484251424" ,"CRMV-SC n°9593", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("85846242728" ,"CRMV-RR n°8325", 1105)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("82508474673" ,"CRMV-MG n°9033", 1101)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("19313860678" ,"CRMV-SC n°8520", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("22292435668" ,"CRMV-RO n°6752", 1101)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("48988178049" ,"CRMV-SC n°6386", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("73671696377" ,"CRMV-GO n°9285", 1104)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("58872151658" ,"CRMV-MS n°9847", 1105)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("63718324745" ,"CRMV-MS n°3015", 1102)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("16707201349" ,"CRMV-SP n°1597", 1101)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("15377615636" ,"CRMV-RO n°1013", 1101)
insert VETERINARIO(matricula, CRMV, setor_resp) values ("65406506173" ,"CRMV-RN n°7081", 1105)