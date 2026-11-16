create database if not exists db_loja;
use db_loja;

create table tb_categoria(
	cat_id int primary key auto_increment,
    cat_nome varchar(50)
);

create table tb_fornecedor(
	for_id int primary key auto_increment,
    for_nome varchar(60), 
    for_cidade varchar(50)
);

create table tb_produto(
	prod_id int primary key auto_increment,
    prod_nome varchar(80),
    prod_data_cadrastro date,
    prod_preco decimal(8,2),
    prod_id_categoria int,
    prod_id_fornecedor int,
    
    constraint prod_id_categoria foreign key(prod_id_categoria) references tb_categoria(cat_id),
    constraint prod_id_fornecedor foreign key (prod_id_fornecedor) references tb_fornecedor(for_id)
);

insert into tb_categoria(cat_nome) values
('informatica'),
('eletronicos'),
('papelaria'),
('games');

insert into tb_fornecedor(for_nome,for_cidade) values
('techsul','Porto Alegre'),
('distrimax','Sao Paulo'),
('papel & cia','Campinas'),
('gamehouse','Sao Paulo');



insert into tb_produto(prod_nome,prod_data_cadrastro,prod_preco,prod_id_categoria,prod_id_fornecedor) values
('mouse sem fio','2024-02-10',79.90,1,1),
('teclado mecanico','2023-11-05',249,1,2),
('monitor 24 polegadas','2024-06-20',899,1,2),
('fone bluetooth','2023-08-14',159.90,2,2),
('caixa de som portatil','2022-12-01',199,2,1),
('carregador usb-c','2024-03-18',59.90,2,1),
('caderno 10 materias','2023-01-25',32.50,3,3),
('caneta gel(kit6)','2024-01-08',24.90,3,3),
('mochila escolar','2023-07-30',149,3,3),
('controle sem fio','2024-05-02',349.90,4,4),
('jogo de corrida','2022-10-15',199.90,4,4),
('headset gamer','2024-09-12',289,4,2);

select prod_nome,prod_preco from tb_produto where prod_id_fornecedor=3; 
select * from  tb_fornecedor where for_cidade <> 'Sao Paulo';
select prod_nome, prod_preco from tb_produto where prod_preco>200;
select prod_nome, prod_preco from tb_produto where prod_id_categoria =2 and prod_preco<100;
select prod_nome, prod_id_categoria , prod_id_fornecedor from tb_produto where prod_id_categoria =1 or prod_id_fornecedor =4;
select prod_nome, prod_preco from tb_produto where not prod_preco>100;

select distinct cat.cat_nome, cat.cat_id, pro.* from tb_categoria cat, tb_produto pro 
where prod_id_categoria in(1,4);  

select * from tb_fornecedor where not for_cidade in("Sao Paulo","Campinas");

select prod_nome Produto, prod_preco Preço from tb_produto where prod_preco between 50 and 200;

select prod_nome, prod_data_cadrastro from tb_produto where prod_data_cadrastro between "2024/01/01" and "2024/12/31";

select prod_nome,prod_preco from tb_produto where prod_preco not between 30 and 300;

select prod_nome, prod_preco from tb_produto where prod_id_categoria in(select cat_id from tb_categoria where cat_nome="games");  

select pro.prod_nome, pro.prod_preco, cat.cat_nome from tb_produto pro, tb_categoria cat where cat.cat_id=pro.prod_id_categoria;

select pr.prod_nome, ca.cat_nome, fo.for_nome
from tb_produto pr, tb_categoria ca, tb_fornecedor fo where fo.for_cidade="Sao Paulo" and pr.prod_id_categoria=ca.cat_id and pr.prod_id_fornecedor=fo.for_id
; 
select count(*) from tb_produto where prod_id_fornecedor =  (select for_id
from tb_fornecedor where for_nome="distrimax");

