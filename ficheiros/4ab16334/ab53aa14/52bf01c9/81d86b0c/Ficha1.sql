--1
SELECT NM FROM MEDICOS WHERE (sysdate-AX) > 10*365;

--2
SELECT MEDICOS.NM, ESPECIALIDADES.DE FROM MEDICOS, ESPECIALIDADES
                                     WHERE MEDICOS.E = ESPECIALIDADES.E;
                                     
--3
SELECT pacientes.np, pacientes.mp FROM pacientes, cod_postal
              WHERE  pacientes.cp = cod_postal.cp AND cod_postal.l = 'BRAGA';
              
--4
SELECT nm FROM medicos
          WHERE e = 'OFT';
          
--5
SELECT medicos.nm, idade(medicos.dn) AS idade FROM medicos
                                              WHERE 2012 - EXTRACT(YEAR FROM AX) > 40
                                              AND e = 'CG';
                                              
--6
SELECT DISTINCT medicos.nm FROM medicos, consultas, pacientes, cod_postal
                           WHERE medicos.e = 'OFT'
                           AND medicos.m = consultas.m
                           AND pacientes.p = consultas.p
                           AND pacientes.cp = cod_postal.cp
                           AND cod_postal.l = 'BRAGA';
                  
--7
SELECT DISTINCT medicos.nm, idade(medicos.ax) AS servico FROM medicos, consultas, pacientes
                                                         WHERE idade(medicos.dn) > 50
                                                         AND idade(pacientes.dn) < 20
                                                         AND medicos.m = consultas.m
                                                         AND pacientes.p = consultas.p
                                                         AND EXTRACT(HOUR FROM consultas.dh) >= 12;
                                                
--8
SELECT pacientes.np AS nome, idade(pacientes.dn) AS idade FROM pacientes
                                                          WHERE idade(pacientes.dn) > 10                                                          
                                                          AND NOT EXISTS (SELECT * FROM medicos, consultas
                                                                                   WHERE pacientes.p = consultas.p
                                                                                   AND medicos.m = consultas.m
                                                                                   AND medicos.e = 'OFT');

--9
SELECT especialidades.de AS especialidades FROM especialidades, consultas, medicos
                                           WHERE consultas.m = medicos.m
                                           AND medicos.e = especialidades.e
                                           AND EXTRACT(YEAR FROM consultas.dh) = 2008
                                           AND EXTRACT(MONTH FROM consultas.dh) = 1;
                                           
--10
SELECT nm AS nome FROM medicos
                  WHERE idade(dn) > 30 OR idade(ax) < 5;
                  
--11
SELECT nm AS nome, idade(dn) AS idade FROM medicos
                                      WHERE e = 'CG'
                                      AND NOT EXISTS (SELECT * FROM consultas
                                                               WHERE medicos.m = consultas.m
                                                               AND EXTRACT(YEAR FROM consultas.dh) = 2008
                                                               AND EXTRACT(MONTH FROM consultas.dh) = 1);
                                                                 
--12
SELECT np AS nome, idade(dn) AS idade FROM pacientes
                                      WHERE NOT EXISTS(SELECT * FROM medicos
                                                                WHERE m NOT IN (SELECT m FROM consultas
                                                                                         WHERE consultas.p = pacientes.p));

--13
SELECT DE FROM especialidades
          WHERE NOT EXISTS (SELECT * FROM consultas, medicos
                                     WHERE consultas.m = medicos.m
                                     AND especialidades.e = medicos.e
                                     AND ((to_char(consultas.dh, 'YYYYMM') = '200801') OR (to_char(consultas.dh, 'YYYYMM') = '200803')));

--14
SELECT nm AS nome FROM medicos
                  WHERE NOT EXISTS(SELECT * FROM consultas, pacientes, cod_postal
                                            WHERE medicos.m = consultas.m
                                            AND pacientes.p = consultas.p
                                            AND pacientes.cp = cod_postal.cp
                                            AND cod_postal.l = 'BRAGA');

--15
SELECT np AS nome, idade(dn) AS idade FROM pacientes
                                      WHERE p NOT IN (SELECT p FROM consultas
                                                           WHERE m IN (SELECT m FROM medicos
                                                                                   WHERE e <> 'CG'))
                                      AND EXISTS (SELECT * FROM consultas
                                                           WHERE consultas.p = pacientes.p);
                                                                                                                            