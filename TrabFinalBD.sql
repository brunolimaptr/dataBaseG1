-- criação do banco de dados

create database tecnohub;

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
	usu_tx_nome_usuário varchar(45) not null,
	usu_tx_email varchar(45) not null,
	usu_tx_CPF varchar(45) not null,
	usu_dt_data_Nascimento date not null,
	end_int_id int not null,
	foreign key (end_int_id) references endereco (end_cd_int)
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

-- insert da tabela endereco

insert into endereco(end_tx_rua, end_tx_bairro, end_tx_numero, end_tx_cidade, end_tx_estado)
values 
	('Autumn Leaf','Plaza','29','Long Beach','California'),
	('Stephen','Street','071','San Jose','Columbia'),
	('Gale','Plaza','396','Pasadena','Coimbra'),
	('Washington','Crossing','1779','Algarvia','Ilha de São Miguel'),
	('Stone Corner','Circle','53242','Lamarosa','Ilha do Pico');

/*create view nota_fiscal
	end_id int,
	prod_id int,
	usu_id int,
	foreign key (prod_id) references produto(prod_id),
	foreign key (end_id) references endereco(end_id),
	foreign key (usu_id) references usuario(usu_id);
	*/






