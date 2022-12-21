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