create database tecnohub;

create table usuario(
	usu_id serial primary key,
	usu_nome varchar(45),
	usu_nome_usuário varchar(45),
	usu_email varchar(45),
	usu_CPF int,
	usu_data_Nascimento date
);

create table endereco(
	end_id serial primary key,
	end_rua varchar(45),
	end_bairro varchar(45),
	end_numero int,
	end_cidade varchar(45),
	end_estado varchar(45)
);

create table pedido(
	ped_id serial primary key,
	ped_data_pedido timestamp,
	usu_id int,
	foreign key (usu_id) references usuario(usu_id)
);

create table categoria(
	cat_id serial primary key,
	cat_nome varchar(45),
	cat_descricao varchar(45)
);

create table funcionario(
	func_id serial primary key,
	func_nome varchar(45),
	fun_cpf int
);

create table produto(
	prod_id serial primary key,
	prod_nome varchar(45),
	prod_descricao varchar(45),
	prod_estoque int,
	prod_data_fabricacao date,
	prod_valor float,
	cat_id int,
	func_id int,
	foreign key (cat_id) references categoria(cat_id),
	foreign key (func_id) references funcionario(func_id)
);

create table pedido_produto(
	pedPro_id serial primary key,
	prod_id int,
	ped_id int,
	foreign key (prod_id) references produto(prod_id),
	foreign key (ped_id) references pedido(ped_id)
);

/*create view nota_fiscal
	end_id int,
	prod_id int,
	usu_id int,
	foreign key (prod_id) references produto(prod_id),
	foreign key (end_id) references endereco(end_id),
	foreign key (usu_id) references usuario(usu_id);
	*/






