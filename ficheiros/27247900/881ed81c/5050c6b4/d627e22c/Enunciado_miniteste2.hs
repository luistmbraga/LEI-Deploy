
module Enunciado_miniteste2 where

-- 1 - Suponhamos que a GNR est� a pensar implementar um sistema de radares, nos seus ve�culos, que permita detectar infra��es de condutores.

type Radar=[(Hora,Matricula,VelAutor,VelCond)]
type Hora=(Int,Int)
type Matricula=String
type VelAutor=Int      -- Velocidade autorizada
type VelCond=Float     -- Velocidade do condutor

-- a) Defina uma fun��o que, dada uma matr�cula, devolva o total de excesso de velocidade de um condutor face � velocidade autorizada. (Nota: O mesmo condutor pode cometer mais do que uma infra��o.)

-- b) Defina uma fun��o que, dado o primeiro componente de uma hora, devolva o n� de infra��es que ocorreu nesse per�odo de tempo. 

-- c) A GNR pretende que as infra��es fiquem registadas no radar por ordem crescente de horas. Defina uma fun��o que, dado um Radar, verifique se este est� a cumprir as condi��es impostas.

-- Nota: Para resolver o mini-teste pode recorrer �s fun��es sobre horas definidas nas aulas (hora2min::Hora->Int e horaMaior::Hora->Bool).

