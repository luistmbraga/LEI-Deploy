--1
create table generos
(genero number primary key,
nome varchar2(50));

create table personagens
(personagem number primary key,
nome varchar2(100));

create table nacionalidades
(nacionalidade number primary key,
nome varchar2(50));

create table editoras
(editora number primary key,
nome varchar2(100),
nacionalidade number,
foreign key (nacionalidade) references nacionalidades(nacionalidade));

create table autores
(autor number primary key,
nome varchar2(100),
data_nascimento date,
data_morte date,
nacionalidade number,
foreign key(nacionalidade) references nacionalidades(nacionalidade));

create table livros
(livro number primary key,
titulo varchar2(100),
resumo varchar2(500),
preco number(6,2),
ano number(4),
genero number,
autor number,
editora number,
foreign key (genero) references generos(genero),
foreign key (autor) references autores(autor),
foreign key (editora) references editoras(editora));

create table personagens_livro
(livro number,
personagem number,
primary key(livro,personagem),
foreign key(livro) references livros(livro),
foreign key(personagem) references personagens(personagem));

--2
--generos
insert into generos
values(1, 'Comedia');
insert into generos
values(2, 'Drama');
insert into generos
values(3, 'romance');

--nacionalidades
insert into nacionalidades
values(1, 'Portugues');
insert into nacionalidades
values(2, 'Inglês');
insert into nacionalidades
values(3, 'Alemão');
insert into nacionalidades
values(4, 'frances');

--personagens
insert into personagens
values(1, 'Harry Potter');
insert into personagens
values(2, 'Ron Weasley');
insert into personagens
values(3, 'Eragon');
insert into personagens
values(4, 'Saphira');

--editoras
insert into editoras
values(1, 'Presenca', 1);
insert into editoras
values(2, 'ASA', 1);
insert into editoras
values(3, 'Pataya', 2);

--autores
insert into autores
values(1, 'Celestino',to_date('28/02/1979','dd/mm/yyyy'), null, 1);
insert into autores
values(2, 'Zé Baderous',to_date('17/04/1940','dd/mm/yyyy'), null, 2);
insert into autores
values(3, 'Derpina Bahaus',to_date('6/12/1987','dd/mm/yyyy'), to_date('12/05/2012','dd/mm/yyyy'), 3);


--livros
insert into livros
values(1,'As trancas do careca', 'Uma estória de encantar serpentes', 15.50, 2000, 1, 1, 2);
insert into livros
values(2,'Batatas a murro', 'Legados de um quintal vesgo', 19.50, 1997, 3, 2, 1);
insert into livros
values(3,'Nightfall', 'Cenas manhosas', 16, 2003, 2, 1, 2);
insert into livros
values(4,'Romanhol', 'Coisas bonitas', 10, 2005, 3, 2, 2);


--personagens-livro
insert into personagens_livro
values(1,1);
insert into personagens_livro
values(1,2);
insert into personagens_livro
values(2,3);
insert into personagens_livro
values(2,4);

-------Parte 2---------
--1
select titulo from livros,autores where livros.autor = autores.autor and autores.nacionalidade = '1';

--2
select aut.nome from autores aut, livros l where l.autor = aut.autor and aut.data_morte is null
                                                                     and l.ano in (select min(ano) from livros);
                                                                     
--3
select e1.nome from editoras e1 minus 
                                select e2.nome from editoras e2, livros l1 
                                               where e2.editora not in (select editora from livros l2
                                                                                       where l2.genero = l1.genero);
                                                                                      
--4
create or replace view livros_por_autor as 
(select aut.nome as nome, l.ano as ano, count(*) AS nlivros from autores aut, livros l 
                                                            where l.autor = aut.autor group by aut.nome, l.ano);

select aut.nome, lpa.ano, lpa.nlivros from autores aut, livros_por_autor lpa 
                                      where lpa.nome = aut.nome and nlivros = (select max(nlivros) from livros_por_autor);

--5
select titulo from livros l where l.resumo is null;

--6
create or replace view persona_por_livro as 
(select personagem, count(*) as referencias from personagens_livro group by personagem);

select p.nome from personagens p, persona_por_livro ppl where ppl.personagem = p.personagem 
                                                        and ppl.referencias in (select max(referencias) from persona_por_livro);  

--7
select distinct aut.nome from autores aut, livros l where aut.autor = l.autor and l.genero = (select max(genero) from livros);

--8
select aut.nome from autores aut where aut.data_morte is null 
                                 and idade(aut.data_nascimento) = (select max(idade(data_nascimento)) from autores);

--9
create or replace view media_precos as
(select g.nome, avg(l.preco) as media from generos g, livros l where l.genero = g.genero group by g.nome);

select g.nome from generos g, media_precos where media_precos.nome = g.nome and media_precos.media = (select max(media_precos.media) from media_precos);

--10
create or replace view livros_por_editora as
(select e.nome, count(l.livro) as nlivros, l.ano as ano from editoras e, livros l where l.editora = e.editora group by nome, ano);

select lpe.nome, lpe.ano from livros_por_editora lpe where nlivros = (select max(nlivros) from livros_por_editora);

--11
select p.nome from personagens p join personagens_livro pl on p.personagem = pl.personagem 
where 

--12