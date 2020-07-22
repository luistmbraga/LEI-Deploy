
module Enunciado_miniteste2 where

-- 1 - Suponhamos que a GNR está a pensar implementar um sistema de radares, nos seus veículos, que permita detectar infrações de condutores.

type Radar=[(Hora,Matricula,VelAutor,VelCond)]
type Hora=(Int,Int)
type Matricula=String
type VelAutor=Int      -- Velocidade autorizada
type VelCond=Float     -- Velocidade do condutor

-- a) Defina uma função que, dada uma matrícula, devolva o total de excesso de velocidade de um condutor face à velocidade autorizada. (Nota: O mesmo condutor pode cometer mais do que uma infração.)

-- b) Defina uma função que, dado o primeiro componente de uma hora, devolva o nº de infrações que ocorreu nesse período de tempo. 

-- c) A GNR pretende que as infrações fiquem registadas no radar por ordem crescente de horas. Defina uma função que, dado um Radar, verifique se este está a cumprir as condições impostas.

-- Nota: Para resolver o mini-teste pode recorrer às funções sobre horas definidas nas aulas (hora2min::Hora->Int e horaMaior::Hora->Bool).

