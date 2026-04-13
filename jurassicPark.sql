/*

🦖 Atividade: Investigando erros no banco de dados do Jurassic Park

O Jurassic Park decidiu informatizar o controle de seus dinossauros. Para isso, um estagiário de TI ficou responsável por criar o 
banco de dados que armazenaria informações importantes sobre os animais do parque.
Durante o desenvolvimento, o estagiário escreveu um script SQL com diversos comandos, incluindo criação de tabela, inserção de dados,
consultas, alterações na estrutura da tabela e atualizações de registros.
No entanto, após tentar executar o script, ele percebeu que vários comandos apresentavam erros, enquanto outros funcionavam, mas 
produziam resultados inesperados. Sem saber exatamente como resolver todos os problemas, ele pediu ajuda à equipe de analistas de 
dados.

Você foi chamado para investigar o script e identificar os problemas.

Sua missão

Analise o script fornecido e:
- Execute os comandos no banco de dados para observar o comportamento do sistema.
- Identifique quais comandos apresentam erro.
- Para cada comando com problema:
- Explique qual é o erro encontrado.

Apresente uma versão corrigida do comando.
Caso o comando execute sem erro, mas possua um problema lógico, explique qual seria o risco ou problema causado.

Observações importantes:
- Nem todos os comandos do script estão incorretos.
-  Alguns comandos apresentam erros de sintaxe.
- Outros apresentam problemas na estrutura do banco de dados.
- Em alguns casos, o comando pode executar sem erro, mas gerar um resultado incorreto.

Analise cada comando com atenção, pois sua tarefa é ajudar o estagiário a corrigir o banco de dados do Jurassic Park para que o 
sistema funcione corretamente.

Boa investigação! 🦖
*/


CREATE DATABASE jurassicPark;
USE jurassicPark;

CREATE TABLE dinossauro (
id INT primary key AUTO_INCREMENT, /*Adição de chave primaria*/
nome VARCHAR(45), /*aumentando a quantidade de caracteres do campo*/
tipo VARCHAR(10), /*aumentando a quantidade de caracteres do campo*/
CONSTRAINT chk_tipo CHECK (tipo IN( 'Marinho','Terrestre', 'aereo')),
peso DECIMAL(8,2), /*A quantidade de numeros decimais nao pode ser maior que a quantidade de numeros inteiros*/ 
altura FLOAT, /*remocao dos parametros*/
carnivoro CHAR(6), /*mundaca para comportar o talvez*/
CONSTRAINT chk_carnivoro CHECK (carnivoro = 'sim' OR carnivoro = 'não' OR carnivoro = 'talvez'), /*Mudanca de nome das constraint | correcao do check | deixando de verificar o tipo para ver se o dinossauto é carnivoro*/
ano_descoberta INT
);

CREATE TABLE parque (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
localizacao VARCHAR(100),
capacidade_maxima INT,
data_abertura DATE
);

/*criacao de uma nova tabela dependente da tabela parque*/
create table jaula(
	idJaula int,
    localizacao varchar(45),
    fk_parque int,
    constraint pk_jaula_parque primary key(idJaula, fk_parque),
    constraint fk_parque foreign key (fk_parque) references parque(id)
);

drop table jaula;


ALTER TABLE dinossauro
ADD id_jaula INT,
ADD CONSTRAINT fk_jaula
FOREIGN KEY (id_jaula) REFERENCES jaulas(id);

/*remocao do null para default*/
INSERT INTO dinossauro VALUES
(default,'Rex','Terrestre',8000.00,4.2,'sim',1902),
(default,'Blue','Terrestre',150.00,1.8,'sim',1924),
(default,'Mosa','Marinho',14000.00,10.5,'sim',1829),
(default,'Trike','Terrestre',6000.00,3,'não',1889),
(default,'Ptera','aereo',25.00,1.2,'não',1784);

ALTER TABLE dinossauro
ADD predador INT,
ADD CONSTRAINT fk_predador
FOREIGN KEY (predador) REFERENCES dinossauro(id/*apenas id*/); /*dinossauros para dinossauro*/

SELECT * FROM dinossauro;/*O nome correto da tabela é dinossauro*/
SELECT nome, carnivoro FROM dinossauro; /*o campo especie nao existe*/
SELECT * FROM dinossauro; /*nao existe campo nonne*/

SELECT nome, tipo FROM dinossauro; /*faltou virgula para separar os campos*/

INSERT INTO dinossauro VALUES
(default,'Rex','Terrestre',8000,4.2,'sim',1902,1); /*mudanca de null para default | há um campo a mais*/

/*a tabela jaula depende da tabela parque entao a posicao dele foi alterada para que o insert do parque venha primeiro*/
/*
INSERT INTO jaula VALUES
('Jaula Norte', 5),
('Jaula Sul', 3),
('Jaula Aquática', 10),
('Jaula Aérea', 8);
*/

SELECT * 
FROM dinossauro
WHERE nome = 'Rex'; /*O campo especie nao existe*/

SELECT d.nome /*especificar de qual tabela a gente esta buscando o nome*/
FROM dinossauro d
JOIN dinossauro p ON d.predador = p.id;

INSERT INTO parque (nome, localizacao, capacidade_maxima, data_abertura) VALUES
('Jurassic Park Nublar', 'Ilha Nublar', 5000, '1993-06-11'),
('Jurassic World', 'Ilha Nublar', 20000, '2015-06-12'),
('Site B', 'Ilha Sorna', 3000, '1997-05-23');

/*adaptacao de algumas foreingkeys*/
INSERT INTO jaula VALUES
(1,'Jaula Norte', 1),
(1,'Jaula Sul', 2),
(1,'Jaula Aquática', 3),
(2,'Jaula Aérea', 1);

UPDATE jaula
SET fk_parque = 2 /*mudanca para fk_parque*/
WHERE idJaula = 1;

SELECT * 
FROM dinossauro
WHERE peso > 25; /*peso escrito em string*/

UPDATE jaula
SET fk_parque = 2
WHERE idJaula = 1; /*correcao do nome*/

SELECT * 
FROM dinossauro
WHERE nome = 'Rex'; /*nome fora das aspas*/

SELECT d.nome, p.nome
FROM dinossauro d
JOIN dinossauro p ON d.id = p.predador; /*Mudanca da ordem do autorrelacionamento*/

SELECT d.nome, p.nome
FROM dinossauro d
JOIN dinossauro p ON d.id = p.id;

/*
SELECT * 
FROM dinossauro
ORDER BY velocidade; --> a velocidade é um elemento inexistente
*/

SELECT d.nome, p.nome
FROM dinossauro d
JOIN dinossauro p ON d.id = p.id;


SELECT * 
FROM dinossauro
WHERE tipo = 'Marinho'; /*Remoção do AND*/

SELECT *
FROM dinossauro
WHERE carnivoro = 'sim' OR carnivoro = 'nao'; /*adicao do 'carnivoro ='   */

/*
SELECT dinossauro.nome, predador.nome
FROM dinossauro                                        ----------> esse select já foi feito
JOIN dinossauro ON dinossauro.predador = dinossauro.id;
*/

ALTER TABLE dinossauros
ADD especie VARCHAR(50); /*adicao de ;*/

ALTER TABLE dinossauro
ADD cor varchar(45); /*adicao do tipo da coluna*/

/*
ALTER TABLE dinossauro
ADD nome VARCHAR(45);  -----------> Falta da quantidade de caracteres do varchar e essa coluna já existe na tabela
*/


INSERT INTO jaula (idJaula, localizacao, fk_parque) VALUES (3, 'Jaula Oeste', 1); /*------------> Os valores 'nome' e 'capacidade' não existem nessa, 'idJaula' foi adicionado e 'fk_parque' também*/

/*
ALTER TABLE dinossauro
ADD especie VARCHAR(50) NOT NULL; --------> ja existe uma coluna chamada especie
*/

ALTER TABLE dinossauro MODIFY nome VARCHAR(50) NOT NULL;

UPDATE dinossauro
SET carnivoro = 'sim' where id = 1; /*falta where*/

SELECT d.nome, p.nome
FROM dinossauro d
JOIN dinossauro p ON d.predador;

UPDATE dinossauro
SET nome = 'Rex' /*a coluna nao pode ser nula*/
WHERE id = 1;


UPDATE dinossauro
SET especie = 'Tyrannosaurus Rex' 
WHERE id = 1;

UPDATE dinossauro
SET nome = 'Rex'	 /*faltou aspas*/
WHERE id = 2;

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, especie) VALUES (7, 'Rex', 'Terrestre', 8000.00 ,4.2 ,'sim', 'todas' ); /*id ou especie nao podem ser nulos*/

select * from dinossauro;

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, ano_descoberta, especie) VALUES
(default,'Blue','Terrestre',150.00,1.8,'sim',1924,'raptor');/*id nao pode ser null*/

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, ano_descoberta, especie) VALUES 
(default, 'Mosa', 'Terrestre', 14000.00, 10.5, 'sim', 1829, 'tirano'); /*nao existe o tipo aquatico*//*id nao pode ser null*/

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, ano_descoberta, especie) VALUES
(default,'Trike','Terrestre',6000.00,3,'talvez',1889, 'tudo'); /*id nao pode ser null*/

/*
INSERT INTO jaula (nome, capacidade) VALUES
('Jaula Perigosa', -5); 				------------------> capacidade nao pode ser negativa, e o campo capacidade nao existe
*/

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, ano_descoberta, especie) VALUES
(default, 'Rex', 'Terrestre', 8000.00, 4.2, 'sim', 1902, 'tudo'); /*id nao pode ser nulo*//*o nome deve estar entre aspas simples*//*e deve ter a especie*/

/*
SELECT d.nome, j.nome
FROM dinossauro d				---------> a tabela 'jaula' nao possui conexao com a tabela 'dinossauro'
JOIN jaula j ON d.id_jaula = 'Jaula Norte';
*/

/*
SELECT d.nome, j.nome
FROM dinossauro d			---------> a tabela 'jaula' nao possui conexao com a tabela 'dinossauro'
JOIN jaula j ON j.id = d.id;
*/

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, ano_descoberta, especie) VALUES
(default, 'Rex' ,'Terrestre',8000.00,4.2,'sim',1902, 'tudo'); /*id nao pode ser nulo*//* o 'nome' esta numa posição diferente*//*deve conter especie*/

SELECT d.nome, p.nome
FROM dinossauro d
LEFT JOIN dinossauro p ON d.predador = p.id
WHERE p.nome = 'Rex';

/*
SELECT d.nome AS dinossauro, j.localizacao AS jaula
FROM dinossauro d 										----------> a tabela jaula nao tem ligação com a tabela dinossauro
JOIN jaula j ON d.idjaula = j.id;
*/

INSERT INTO dinossauro (nome, tipo, especie)
VALUES ('Rex','Terrestre','Tyrannosaurus');

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, ano_descoberta, especie) VALUES
(default,'rex','Terrestre',8000.00,4.2,'sim',1902, 'tudo'); /*id nao pode ser nulo*//*precisa de especie*/

/*
SELECT d.nome, j.nome
FROM dinossauro as d ----------------------> falta de as e a tabela dinossauro nao tem conexao com a tabela jaula
JOIN jaula as j ON d.id = j.id;
*/

/*
SELECT d.nome, j.nome
FROM dinossauro d ----------------------> a tabela dinossauro nao tem conexao com a tabela jaula
JOIN jaula j ON dinossauro.id_jaula = j.id;
*/

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, ano_descoberta, especie) VALUES
(default,'Rex','Terrestre',8000.00,4.2,'sim',1902,'tudo');/*nem nome nem id pode ser null*//*tem que ter especie*/

/*
SELECT d.nome, j.nome
FROM dinossauro d ----------------------> a tabela dinossauro nao tem conexao com a tabela jaula
JOIN jaula j ON d.id_jaula = j.id;
*/

INSERT INTO dinossauro (id, nome, tipo, peso, altura, carnivoro, ano_descoberta, especie) VALUES
(default,'Ptera','aereo', 25.00 ,1.2,'nao',1784, 'tudo'); /*falta uma virgula*/

/*
SELECT d.nome, j.nome, j.capacidade
FROM dinossauro d ----------------------> a tabela dinossauro nao tem conexao com a tabela jaula
LEFT JOIN jaula j ON d.id_jaula = j.id
WHERE j.capacidade < 3;
*/
-- Preciso de um SELECT que traga todos, os dinossauros do parque, mas não sei como fazer.... 