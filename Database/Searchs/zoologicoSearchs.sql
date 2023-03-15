/*Demonstrando todas as tabelas */
select * from VISITANTE;
select * from TELEFONE_VISITANTE;

select * from PESQUISADOR;
select * from PROJETO_PESQUISA;
select * from DESENVOLVIMENTO_PROJETO;

select * from INGRESSO_CATALAGO;
select * from INGRESSO_DISPONIVEL;
select * from INGRESSOS_COMPRADOS;

select * from FUNCIONARIO;
select * from TELEFONE_FUNC;
select * from VETERINARIO;

select * from HABITAT;
select * from MANUNTECAO_HABITAT;

select * from ANIMAL;
select * from ANIMAL_INTERNACAO;

select * from ALA_CLINICA;
select * from PRESCRICAO_EXAME;
select * from EXAME_ANIMAL;

select * from RECURSO_ARMAZENADO;
select * from FORNECEDOR;
select * from FORNECEDOR_EMAIL;


/*
1. Informe a quantidade de ingressos vendidos e a quantidade arrecada para cada tipo de ingresso no catalogo.
*/

select CI.tipo_nome, count(*) as "Quantidade Ingressos Vendidos", SUM(CI.preco) as "Valores ARRECADADOS"
from ingressos_comprados as BI
inner join ingresso_catalago as CI
inner join ingresso_disponivel as DI
on BI.ingresso = DI.ID && DI.tipo = CI.tipo_id
group by CI.tipo_nome;

/* 
2. Informe o CPF, nome, data de nascimento dos visitantes do gênero Feminimo da PARAÍBA em ordem decrescente pela data de nascimento
*/

select CPF, Nome, data_nasc
From VISITANTE
where upper(esta_prov) in ('PARAÍBA') and upper(genero)='F'
Order by data_Nasc desc ;

/* 
3. Informe o nome dos visitantes e os seus respectivos estados/provincia que não são da Paraíba e que compraram ingressos 
*/

/*
4. Informe quais são os funcionários que possuem JOSÉ no nome e possuam salários acima de 10 mil reais.
*/

/*
5. Informe a quantidade de manutenções que foram realizadas por cada tipo de habitat 
*/

/*
6. Informe o nome, CRMV, Salario e o setor no qual o Veterinário é responsável.
*/


/*
7.Informe a media da quantidade de recursos amazenados para cada tipo.
*/


/*
8. Informe todas as informações dos animais que ainda estão internados. 
*/
