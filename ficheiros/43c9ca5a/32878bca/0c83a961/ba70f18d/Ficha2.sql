--1
SELECT AVG(idade(dn)) AS media FROM medicos 
                               WHERE idade(ax) > 15;
                               
--2
SELECT DISTINCT de, AVG(idade(ax)) FROM medicos, especialidades 
                                   where especialidades.e = medicos.e
                                   GROUP BY de;
                                   
--3
SELECT nm As nome, COUNT(*) AS cnsltas FROM medicos, consultas
                                       WHERE medicos.m = consultas.m
                                       GROUP BY nm;

--4
SELECT DISTINCT de AS esp, AVG(idade(dn)) AS idade FROM especialidades, medicos
                                                   WHERE especialidades.e = medicos.e
                                                   GROUP BY de;

--5
SELECT DISTINCT nm AS medico, SUM(preco) AS valor FROM medicos, consultas
                                                  WHERE medicos.m = consultas.m
                                                  AND EXTRACT(YEAR FROM dh) = 2003
                                                  GROUP BY nm;

--6
SELECT de AS esp, COUNT(*) AS nmedicos FROM especialidades, medicos
                                       WHERE especialidades.e = medicos.e
                                       GROUP BY de;

--7
SELECT de AS esp, COUNT(DISTINCT m1.m) AS nmedicos, MIN(preco) AS minimo, MAX(preco) AS maximo, AVG(preco) AS media FROM especialidades e1, medicos m1, consultas c1
                                                                                                                    WHERE e1.e = m1.e
                                                                                                                    AND m1.m = c1.m
                                                                                                                    GROUP BY de
                                                                                                                    HAVING COUNT(distinct m1.m) < 2;

--8
select nm as nome, sum(preco) as valor from medicos m1, consultas c1
                                       where m1.m = c1.m
                                       and extract(year from dh) = 2007
                                       group by nm
                                       having sum(preco) > (select avg(preco) from consultas c2);




