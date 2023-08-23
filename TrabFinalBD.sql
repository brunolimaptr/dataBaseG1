-- criação do banco de dados

-- criação dos usuários

create user administrator password '123';
create user empregado password '1010';
create user cliente password '2020';

create database tecnohub;


-- garante tudo para o admin

grant all
on database tecnohub
to administrator;

-- tecnohub, uma loja de periféricos eletrônicos para todos os gostos!

-- criação das tabelas

create table endereco(
	end_cd_id serial primary key not null,
	end_tx_rua varchar(45) not null,
	end_tx_bairro varchar(45) not null,
	end_tx_numero varchar(45) not null,
	end_tx_cidade varchar(45) not null,
	end_tx_estado varchar(45) not null
);

create table usuario(
	usu_cd_id serial primary key not null,
	usu_tx_nome varchar(45) not null,
	usu_tx_nome_usuario varchar(45) not null,
	usu_tx_email varchar(45) not null,
	usu_tx_CPF varchar(45) not null,
	usu_dt_data_Nascimento date not null,
	end_int_id int not null,
	foreign key (end_int_id) references endereco (end_cd_id)
);

create table pedido(
	ped_cd_id serial primary key not null,
	ped_dt_data_pedido timestamp not null,
	usu_int_id int not null,
	foreign key (usu_int_id) references usuario(usu_cd_id)
);

create table categoria(
	cat_cd_id serial primary key not null,
	cat_tx_nome varchar(45) not null,
	cat_tx_descricao varchar(45) not null
);

create table funcionario(
	func_cd_id serial primary key not null,
	func_tx_nome varchar(45) not null,
	fun_tx_cpf varchar(45) not null
);

create table produto(
	prod_cd_id serial primary key not null,
	prod_tx_nome varchar(45) not null,
	prod_tx_descricao varchar(45) not null,
	prod_int_estoque int not null,
	prod_dt_data_fabricacao date not null,
	prod_nm_valor float not null,
	cat_int_id int not null,
	func_int_id int not null,
	foreign key (cat_int_id) references categoria(cat_cd_id),
	foreign key (func_int_id) references funcionario(func_cd_id)
);

create table pedido_produto(
	pedPro_cd_id serial primary key not null,
	prod_int_id int not null,
	ped_int_id int not null,
	foreign key (prod_int_id) references produto(prod_cd_id),
	foreign key (ped_int_id) references pedido(ped_cd_id)
);

--Index do produto criado pra mostrar as informações mais rápido

create index prod1_index on produto(prod_tx_nome, prod_int_estoque, prod_cd_id);

create index prod2_index on produto(prod_nm_valor, prod_dt_data_fabricacao);

--Index do usuário

create index usu1_index on usuario(usu_cd_id, usu_tx_nome, usu_tx_cpf, usu_dt_data_nascimento);

create index usu2_index on usuario(usu_tx_nome_usuario, usu_tx_email, end_int_id);

--Index do pedido

create index ped1_index on pedido(ped_cd_id, ped_dt_data_pedido, usu_int_id);

/* empregado pode ver os produtos, atualizar eles, inserir mais produtos, 
   e referenciar eles à categoria. Ele pode ver as categorias e também mudar as informações dele mesmo
   Além de poder gerar a nota fiscal.
 */

grant select, update, insert, references
on produto
to empregado;

grant select
on categoria
to empregado;

grant update, select
on funcionario
to empregado;

grant select, insert
on nota_fiscal
to empregado;

-- o cliente pode ver os produtos e categorias

grant select 
on produto
to cliente;

grant select 
on categoria
to cliente;

-- o cliente pode ver o próprio login, atualizar ele, e também excluir ele

grant select (usu_tx_nome,usu_tx_nome_usuario,usu_tx_email,usu_tx_cpf), update (usu_tx_nome,usu_tx_nome_usuario,usu_tx_email,usu_tx_cpf)
on usuario
to cliente;

grant delete
on usuario
to cliente;

/* o cliente pode ver o pedido, atualizar, excluir e também inserir mais coisas no pedido. 
   Além de ver a nota fiscal */

grant select, update, delete, insert
on pedido
to cliente;

grant select, update, delete, insert
on pedido_produto
to cliente;

grant select 
on nota_fiscal
to cliente;

-- insert da tabela endereco

insert into endereco(end_tx_rua, end_tx_bairro, end_tx_numero, end_tx_cidade, end_tx_estado)
values 
	('Autumn Leaf','Plaza','29','Long Beach','California'),
	('Stephen','Street','071','San Jose','Columbia'),
	('Gale','Plaza','396','Pasadena','Coimbra'),
	('Washington','Crossing','1779','Algarvia','Ilha de São Miguel'),
	('Stone Corner','Circle','53242','Lamarosa','Ilha do Pico');

select * from endereco;

--Alteração do tipo para texto para caber mais caracteres

alter table categoria 
alter column cat_tx_descricao type text;

--Insert da tabela categoria
insert into categoria (cat_tx_nome, cat_tx_descricao)
values
('Monitores', 'Nesta categoria temos uma variedade de monitores para computadores'),
('Mouses', 'Nesta categoria temos todos os tipos de mouse'),
('Teclados', 'Nesta categoria temos desde teclados gamer para computadores, até teclados que podem ser usados em celulares'),
('CPU', 'Nesta categoria temos desde de CPU gamer, até as mais simples'),
('GPU', 'As GPUs são as peças responsáveis pelo processamento de imagem nos nossos computadores. Nesta categoria temos GPU de diferentes capacidades gráficas');

select * from categoria;

delete from categoria where cat_cd_id = 6;

select * from usuario;

INSERT INTO USUARIO  (USU_TX_NOME, USU_TX_NOME_USUARIO, USU_TX_EMAIL, USU_TX_CPF, USU_DT_DATA_NASCIMENTO, END_INT_ID)
VALUES('Roze Simonnot','Roze', 'rozesimonnot@yahoo.com', '12365478965', '1975-12-25',1),
('Ferdinanda Narducci','Ferdinanda', 'ferdinandanarducci@yahoo.com', '15478965482', '1987-05-20', 2),
('Aloysia Di Napoli','Aloysia','aloysianapoli@yahoo.com', '25031247802', '1875-09-05', 3),
('Angelica Duthy', 'Angelica','angelicaduthy@gmail.com', '00254896314', '1991-03-09',4),
('Filip Bayston','Filip', 'filipbayston@hotmail.com','54112569874', '1975-6-22',5);

insert into PEDIDO (ped_dt_data_pedido, usu_int_id)
values('21-08-2023 17:53:00',1),
('18-02-2023 17:00:00',2),
('01-01-2023 09:00:00',3),
('23-03-2023 10:03:00',4),
('12-07-2023 14:36:00',5)
;

select * from pedido;

delete from pedido where ped_cd_id = 11;

-- Insert tabela do funcionário

alter table funcionario 
rename column fun_tx_cpf to func_tx_cpf;

insert into funcionario (func_tx_nome, func_tx_cpf)
values ('Junior','01234567899' ),
('Sthefany','22233344456'),
('Luiz', '55566677789'),
('Josi','11122233345'),
('Sophia','77788899911');

select func_tx_cpf
from funcionario;

alter table PRODUTO 
alter column prod_tx_descricao type text;

INSERT INTO produto (CAT_INT_ID ,FUNC_INT_ID , PROD_TX_NOME, PROD_TX_DESCRICAO , PROD_INT_ESTOQUE , PROD_DT_DATA_FABRICACAO, PROD_NM_VALOR)
VALUES
(1, 5, 'Monitor 19.5 LED Ergonômico',' Widescreen, 2ms, 75Hz, hd +, hdmi, vesa, hq Pro 195HQA', 25, '2020-05-15', '450.50'),
(1, 2, 'Monitor AOC 21.5', 'Full HD LED Widescreen HDMI 22B1HM5',10, '2022-08-20' , '500.00'),
(2, 3, 'AW320M', 'MOUSE GAMER COM FIO ALIENWARE', 25, '2023-01-01', '100.00'),
(2, 4, 'Logitech M90','Cinza. Design Ambidestro e Facilidade Plug and Play.',25, '2022-10-06', '80.00'),
(3, 1, 'Logitech G213','Prodigy com Iluminação RGB Nítida Controles de Mída Dedicados', 20, '2022-10-10', '399.00'),
(3, 5, 'Teclado mingzhe sem fio BT','teclado dobrável portátil ultra fino teclado BT com touchpad para Windows/Android/iOS cinza', 10, '2022-10-15', '138.00'),
(4, 3, 'PC HOME OFFICE INTEL CORE I5',' 3.2GHZ - 16GB - SSD 480GB', 15, '2022-07-01', '1500.00'),
(4, 4, 'intel core i5-13600k','Processor 24M  5.10 GHz quick reference specifications features technologies', 25, '2022-09-02', '2000.00'),
(5, 1, 'Nvidia Pcyes GeForce 200 Series','Placa de vídeo Nvidia Pcyes GeForce 200 Series G210 PA210G6401D3LP 1GB', 35, '2020-12-25', '200.00'),
(5, 1, 'GeForce RTX® 4090','ASUS Placa gráfica ROG Strix', 5, '2020-02-26', '18000.00');


SELECT * FROM PRODUTO P 

-- insert do pedido_produto

insert into pedido_produto(ped_int_id, prod_int_id)
values
(1,2),
(1,1),
(2,4),
(2,5),
(3,3),
(3,10),
(4,9),
(4,6),
(5,7),
(5,8);

select * from pedido_produto;


-- criação da view nota_fiscal

create view nota_fiscal as
select
	u.usu_tx_nome,
	u.usu_tx_cpf,
	p.ped_dt_data_pedido,
	p2.prod_tx_nome,
	p2.prod_nm_valor,
	f.func_tx_nome
from usuario u
inner join pedido p on
	u.usu_cd_id = p.usu_int_id
inner join pedido_produto pp on
	p.ped_cd_id = pp.ped_int_id 
inner join produto p2 on
	pp.prod_int_id = p2.prod_cd_id 
inner join funcionario f on
	p2.func_int_id = f.func_cd_id;

select * from nota_fiscal;

-- Inner join para descobri os usuários que compraram qualquer produto.

select usu_cd_id,usu_tx_nome, usu_tx_nome_usuario, prod_tx_nome 
from usuario u 
inner join pedido p
on u.usu_cd_id = p.usu_int_id
inner join pedido_produto pp 
on p.usu_int_id = pp.ped_int_id
inner join produto p2
on p2.prod_cd_id =pp.prod_int_id
where 
prod_tx_nome = :prod;


-- Deletar o pedido porque o usuario resolveu cancelar a compra. 

delete
from
	pedido_produto
where
	pedpro_cd_id = 8;


-- Alterar o pedido porque o usuario resolveu trocar o produto.

update
	pedido_produto
set
	prod_int_id = 1
where
	pedpro_cd_id = 7;



select * from pedido_produto;

-- Mostrando tabelas de itens que nao foram comprados.

SELECT 
p.PROD_CD_ID,
p.PROD_TX_NOME,
p.PROD_NM_VALOR,
pp.PROD_INT_ID 
FROM PRODUTO P 
LEFT JOIN PEDIDO_PRODUTO PP 
ON p.PROD_CD_ID = pp.PROD_INT_ID
ORDER BY p.PROD_CD_ID asc;

-- O cliente tem pouco dinheiro, mas precisa de um produto de cada categoria.
-- Por isso pediu uma busca pelo produto mais barato de cada categoria

-- Select distinct imprime o primeiro valor, como no order by já foi colocado em ordem decrescente, 
-- ele pega o menor valor.
select distinct on (c.cat_tx_nome)
	c.cat_tx_nome as "Categoria",
	p.prod_tx_nome as "Produto", 
	min(p.prod_nm_valor) as "Mais barato"
from
	produto p
inner join categoria c on
	c.cat_cd_id = p.cat_int_id
group by
	c.cat_tx_nome, p.prod_tx_nome
--Dentro de cada categoria, este comando mostra o produto mais barato
	order by 
	c.cat_tx_nome, min(p.prod_nm_valor);
	
