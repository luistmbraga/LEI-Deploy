
-- Pergunta 1:
-- Alínea a)
dobros :: [Float] -> [Float]
dobros [] = []
dobros (x:xs) = (2*x):(dobros xs)

-- Alínea b)
ocorre :: Char -> String -> Int
ocorre c [] = 0
ocorre c (x:xs) = if x == c then 1+ocorre c xs
			    else ocorre c xs

-- Alínea c)
pmaior :: Int -> [Int] -> Int
pmaior x [] = x
pmaior x (y:ys) | y>x = y
		| otherwise = pmaior x ys

-- Alínea d)
repetidos :: [Int] -> Bool
repetidos [] = False
repetidos (x:xs) = if (elem x xs) = then True
				    else repetidos xs

-- Alínea e)
nums :: String -> [Int]
nums [] = []
nums (x:xs) = if (isDigit x) then digitToInt x:nums xs
			     else nums xs

-- Alínea f)
tresUlt :: [a] -> [a]
tresUlt l = if (length l<=3) then l
			     else tresUlt (tail l)

-- ou:
-- tresUlt [x,y,z] = [x,y,z]
-- tresUlt [x,y] = [x,y]
-- tresUlt [x] = [x]
-- tresUlt [] = []
-- tresUlt (_:t) = tresUlt t

-- Alínea g)
posImpares :: [a] -> [a]
posImpares [] = []
posImpares [x] = [x]
posImpares (x:xs) = x:posImpares (tail xs) -- ou: posImpares (x:y:t) = x:posImpares t)

-- Pergunta 2:
type Aluno = (Numero, Nome, ParteI, ParteII)
type Numero = Int
type Nome = String
type ParteI = Float
type ParteII = Float
type Turma = [Aluno]

-- Alínea a)
validaTurma :: Turma -> Bool
validaTurma t = (semRepetidos t) && (notasValidas t)

semRepetidos :: Turma -> Bool
semRepetidos t = not(repetidos (sel t))
	where sel :: Turma -> [Int]
	      sel [] = []
	      sel ((n,_,_,_):t) = n sel t

notasValidas :: turma -> Bool
notasValidas [] = False
notasValidas ((_,_,p1,p2):t) = if (0<=p1 && p1<=12) && (0<=p2 && p2<=8) then notasValidas t
									else False

-- Alínea b)
aprov :: Turma -> Turma
aprov [] = []
aprov ((n,x,p1,p2):t) = if (p1>=8 && p1+p2>=9.5) then (n,x,p1,p2):aprov t
						 else aprov t

-- Alínea c)
notaFinal :: Turma -> [(Aluno,Float)]
notaFinal []= []
notaFinal a@(n,x,p1,p2):t = if (p1>=8 && p1+p2>=9.5) then (a:p1+p2:notaFinal t)
						     else notaFinal t

-- Alínea d)
media :: Turma -> Float
media [] = 0
media t = somaNotas (notaFinal t)/fromIntegral (lenght (notaFinal t))
   where somaNotas [] = 0
	 somaNotas ((_,n):xs) = n+somaNotas xs

-- Alínea e)
melhorAluno :: Turma -> String
melhorAluno [] = error "Turma vazia"
melhorAluno [(_,x,_,_)] = x
melhorAluno a1@(_,x,p1,p2):a2@(_,x2,p1',p2'):xs | p1+p2>p1'+p2' = melhorAluno (a1:xs)
						| otherwise = melhorAluno (a2:xs)

-- Pergunta 3:
type Hora = (Int,Int)
type Etapa = (Hora,Hora)
type Viagem = [Etapa]

-- Utilizando as funções sobre horas da ficha 2

-- Alínea a)
etapaValida :: Etapa -> Bool
etapaValida (hp,hc) = horaValida hp && horaValida hc && depois hc hp

-- Alínea b)
viagemValida :: Viagem -> Bool
viagemValida ((hp1,hc1):(hp2,hc2):t) = etapaValida (hp1,hc1) && depois (hp1,hc1) && viagemValida ((hp2,hc2):t)
viagemValida [e] = etapaValida e

-- Alínea c)
horaPartida :: Viagem -> Hora
horaPartida v = fst (head v)

horachegada :: Viagem -> Hora
horachegada v = snd (last v)

-- Alínea d)
tempoViagem :: Viagem -> Int
tempoViagem [] = 0
tempoViagem ((hp,hc):xs) = if viagemValida ((hp,hc):xs) then (diferenca (hc,hp)) + (tempoViagem xs)
							else 0

-- Alínea e)
tempoEspera :: Viagem -> Int
tempoEspera [] = 0
tempoEspera ((hp,hc):xs) = if viagemValida ((hp,hc):xs) then (diferenca (snd (last xs),hp)) - tempoViagem ((hp,hc):xs)
							else 0

-- Alínea f)
tempoTotal :: Viagem -> Int
tempoTotal [] = 0
tempoTotal ((hp,hc):xs) = if viagemValida ((hp,hc):xs) then diferenca (snd (last xs),hp)
						       else 0

