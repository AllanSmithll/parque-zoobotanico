# Parque Zoobotânico Arnaldo Calixto César

## Objetivo
Criar um banco de dados relacional em MySQL com base na elaboração do minimundo.

## Minimundo
O Parque Zoobotânico Arnaldo Calixto César (Parque Arsar) é o maior zoológico do Brasil e referência global em pesquisa científica. Ele abriga 150 espécies de animais e 300 de plantas, recebendo entre 2.000 e 4.000 visitantes diários, incluindo cientistas estrangeiros e brasileiros. 

Com a alta demanda de visitas, pesquisas e novas espécies chegando, o diretor do parque solicitou um banco de dados para otimizar a gestão e controle de operações.

### Exigências
- **Visitantes:** Nome, data de nascimento, endereço (país, estado, cidade), CPF, RG, e-mail e, opcionalmente, gênero e números de telefone.
- **Ingressos:** Identificação única, tipo (adulto, pesquisador, infantil), cor, preço e áreas permitidas.
- **Animais:** Código, data de chegada, estado de saúde, nome comum/científico, tipo de alimentação e habitat ou ala de reabilitação.
- **Funcionários:** Nome, CPF, matrícula, endereço, função e telefone(s). Veterinários precisam de CRMV e especialização; motoristas precisam de CNH.
- **Habitats:** Código, quantidade de árvores, presença de fosso, tipo de solo e número de animais.
- **Recursos:** Alimentos, remédios e equipamentos com nome, validade, localização (setor, galpão, prateleira) e identificador.
- **Fornecedores:** Nome fantasia, CNPJ, endereço e e-mail(s).
- **Exames:** Para animais doentes, registrar resultados, data, veterinário e medicamentos prescritos.
- **Pesquisas:** Nome, CPF e e-mail dos pesquisadores, título, datas (início/finalização) e identificador do projeto. Todos os pesquisadores são visitantes.
- **Ingressos Físicos/Digitais:** Os físicos são adquiridos na bilheteria e precisam registrar o funcionário responsável. Os digitais são comprados online. Ambos devem registrar data, hora e quantidade da compra.
- **Pesquisadores:** Identificação via carteirinha com número de 8 dígitos, dados pessoais, instituição de vínculo, matrícula e grau acadêmico.
- **Habitat e Reabilitação:** Animais podem ser destinados a habitats ou à ala de reabilitação, registrando entrada e devolução à natureza.
- **Equipe e Gerência:** Chefes de departamento e o diretor são responsáveis por gerenciar equipes. O diretor é a autoridade máxima.

### Modelo Entidade Relacionamento (DER)
![DER](./docs/DER/modelo-DER.png)

### Modelo Lógico
![Modelo Lógico](./docs/Logico/modelo-Logico.png)

## Notas Finais
Estamos abertos a dúvidas, comentários e sugestões 😊
