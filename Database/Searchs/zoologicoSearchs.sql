/* 
1. Procure, na tabela visitante, quando nasceu os visitantes mais novo e o mais velho
*/

SELECT min(idnasc), max(idnasc)
FROM VISITANTE;

/*
2. Selecione o nome de vistantes por ordem decresente 
*/

SELECT FROM PROJETO_PESQUISA
ORDER BY instituicao  DESC;
/*
3. selecione apenas visitantes de são paulo
*/
SELECT FROM VISITANTE
WHERE esta_prov IN ('São Paulo');

/*
3. selecione apenas  visitantes  que não são da bahia
*/

SELECT FROM VISTITANE
WHERE esta_prov NOT IN ('Bahia');

/*
4.Retorne os pesquisadores formados entre 1990 e 2000 
*/
SELECT FROM PESQUISADOR 
WHERE concl_supe BETWEEN 1990 AND 2000;
/*
4. Retorna os funcionarios cujo salario não está entre 1500 à 2000
*/
SELECT FROM FUNCIONARIO
WHERE salario NOT BETWEEN 1500 AND 2000;

/*
5. Mostre projetos de pesquisa onde não existe subtitulo
*/

SELECT FROM PROJETO_PESQUISA
WHERE subtitulo IS NULL;

/*
5. Mostre apenas projetos com datas
*/

SELECT FROM DESENVOLVIMENTO_PROJETO
WHERE data_final IS NOT NULL;

/*
6. Mostre apenas os animais inciados com a letra "a"
*/

SELECT FROM ANIMAL
WHERE nome_popu LIKE 'a%';

/*
6. Mostre apenas os vistantes de paises que nao começam com a letra "a"
*/

SELECT FROM VISITANTE
WHERE pais_orig NOT LIKE 'a%';

/*
7.Seleciona a media de quais os tipos de recursos amazenados
*/
SELECT AVG(tipo)
FROM RECURSO_ARMAZENADO;
/*
7.Mostre onde a quantidade de fornecedores é menor que 10 
*/

SELECT FROM RECURSO_ARMAZENADO
HAVING COUNT(quant_forn) > 10;
