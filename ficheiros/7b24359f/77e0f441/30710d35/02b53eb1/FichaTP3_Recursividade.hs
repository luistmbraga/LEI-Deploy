-- @autor Pirata
-- @version 10.2015

module FichaTP3 where

-- Ex1 - Interpretações da avaliação do Haskell.
-- a)
p :: Int -> Bool
p 0 = True
p 1 = False
p x | x > 1 = p (x - 2)
-- Esta função é uma maneira recursiva de verificar se um determinado valor é par ou não.

-- @ghci> p 5
-- @ghci> False
-- p 5 -> Como 5 > 1, vai calcular p 3
-- p 3 -> Como 3 > 1, vai calcular p 1
-- p 1 -> p 1 é False.

-- b)
f l = g [] l
g l [] = l
g l (h:t) = g (h:l) t
-- Função que devolve o mesmo que a função reverse.

-- @ghci> f "otrec"
-- @ghci> "certo"
-- f "otrec" -> Passa a ser chamada a função g [] "otrec"
-- g [] "otrec" -> g "o" "trec" -> g "to" "rec" -> g "rto" "ec" -> g "erto" "c" -> g "certo" []
-- g "certo" [] -> como a segunda lista vazia, devolve a primeira -> "certo"

-- c)
fun (x:y:t) = fun t
fun [x] = []
fun [] = []
-- Função que devolve sempre a lista vazia depois de a correr de dois em dois elementos.

-- @ghci> fun [1,2,3,4,5]
-- @ghci> []
-- fun [1,2,3,4,5] -> Como tem mais de 2 elementos, passa a calcular o fun t
-- fun [3,4,5] -> O mesmo que antes
-- fun [5] -> Como só tem um elemento, devolve a lista vazia [].

-- Ex2

-- a) calcula a lista das segundas componentes dos pares.
segundos :: [(a,b)] -> [b]
segundos [] = []
segundos ((x,y):ts) = y : (segundos ts)

-- b) testa se um elemento aparece na lista como primeira componente de algum dos pares.
nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros _ [] = False
nosPrimeiros x (h:ts) = if ((fst h) == x) then True else nosPrimeiros x ts

-- c) calcula a menor primeira componente.
minFst :: (Ord a) => [(a,b)] -> a
minFst list = mfAux list (fst (head list)) where
	mfAux [] w = w
	mfAux ((x,y):ts) w = if (x < w) then mfAux ts x else mfAux ts w

-- d) calcula a segunda componente associada a menor primeira componente.
sndMinFst :: (Ord a) => [(a,b)] -> b
sndMinFst list = smfAux list (head list) where
	smfAux [] (x,y) = y
	smfAux ((w,z):ts) (x,y) = if (w < x) then smfAux ts (w,z) else smfAux ts (x,y)

-- e) soma uma lista de triplos componente a componente.
sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos [] = (0,0,0)
sumTriplos ((x,y,z):ts) = (\(x,y,z) (xs,ys,zs) -> (x + xs,y + ys,z + zs)) (x,y,z) (sumTriplos ts)
-- ou: sumTriplos ((x,y,z):ts) = somaTriplo (x,y,z) (sumTriplos ts) where somaTriplo (x,y,z) (xs,ys,zs) = (x + xs,y + ys,z + zs)

-- f) calcula o maximo valor que da a soma dos triplos da lista.
maxTriplo :: (Ord a, Num a) => [(a,a,a)] -> a
maxTriplo ((x,y,z):ts) = mTAux ts (x + y + z) where
	mTAux [] big = big
	mTAux ((x,y,z):ts) big = if ((x + y + z) > big) then mTAux ts (x + y + z) else mTAux ts big

-- Ex3 - Supõe NÃO NEGATIVOS

-- a) multiplicar números inteiros.
(><) :: Int -> Int -> Int
(><) x y = if (x > y) then mAux x y 0 else mAux y x 0 where
	mAux _ 0 res = res
	mAux x y res = mAux x (y - 1) (res + x)

-- b) divisão e resto da divisão inteira de dois números.
div' :: Int -> Int -> Int
div' x y = if (x < y) then 0 else 1 + (div (x - y) y)
-- No caso de possibilitar números negativos, seria algo estilo o seguinte:
--div x y | (x < 0) && (y < 0) = if (x < y) then 1 + (div (x - y) y) else 0
--		| (x < 0) && (y > 0) = if ((-x) > y) then (-1) + (div (x + y) y) else 0
--		| (x >= 0) && (y < 0) = if (x > (-y)) then (-1) + (div (x + y) y) else 0
--		| (x >= 0) && (y > 0) = if (x > y) then 1 + (div (x - y) y) else 0

mod' :: Int -> Int -> Int
mod' x y = if (x < y) then x else mod (x-y) y

-- c) calcula um valor elevado a potência.
power :: Int -> Int -> Int
power x 1 = x
power x y = x * (power x (y-1))

-- Ex4
type Hora = (Int,Int)
type Etapa = (Hora,Hora)
type Viagem = [Etapa]

-- Funções da Ficha 1 --
-- a) testar se um par de inteiros representa uma hora do dia válida.
horaValida :: Hora -> Bool
horaValida (h,m) = (h >= 0) && (h < 24) && (m >= 0) && (m < 60)

-- b) testar se uma hora é ou não depois de outra (comparação). (Compara que a primeira hora escrita é anterior à outra).
horaDepois :: Hora -> Hora -> Bool
horaDepois (a,b) (x,y) = (a < x) || ((a == x) && (b < y))

-- c) converter um valor em horas (par de inteiros) para minutos (inteiro).
hora2Mins :: Hora -> Int
hora2Mins (h,m) = (h * 60) + m

-- d) converter um valor em minutos para horas.
mins2Hora :: Int -> Hora
mins2Hora m = (div m 60, mod m 60)

-- e) calcular a diferença entre duas horas (cujo resultado deve ser o número de minutos).
diferHoras :: Hora -> Hora -> Int
diferHoras a b = if(horaDepois a b) then (hora2Mins b) - (hora2Mins a) else (hora2Mins a) - (hora2Mins b)

-- f) adicionar um determinado número de minutos a uma dada hora.
adicionaMinutos :: Hora -> Int -> Hora
adicionaMinutos hora mins = mins2Hora ((hora2Mins hora) + mins)

-- end --

-- a) Testar se uma etapa está bem construída.
etapaValida :: Etapa -> Bool
etapaValida (x,y) = (horaValida x) && (horaValida y) && (horaDepois x y)

-- b) Testa se uma viagem está bem construída.
viagemValida :: Viagem -> Bool
viagemValida [] = True
viagemValida [x] = etapaValida x
viagemValida ((x,xs):(y,ys):ts) = if ((etapaValida (x,xs)) && (horaDepois xs y)) then viagemValida ((y,ys):ts) else False

-- c) Calcular as horas de chegada e de partida de uma dada viagem.
chegadaPartidaViagem :: Viagem -> (Hora,Hora)
chegadaPartidaViagem list = cPVAux list (head list) where
	cPVAux [] x = x
	cPVAux ((x,y):ts) (st,end) = cPVAux ts (st,y)

-- d) Dada uma viagem válida, calcular o tempo total de viagem efectiva.
tempoEmViagem :: Viagem -> Hora
tempoEmViagem [] = (0,0)
tempoEmViagem ((x,y):ts) = adicionaMinutos (tempoEmViagem ts) (diferHoras x y)

-- e) calcular o tempo total de espera.
tempoEmEspera :: Viagem -> Hora
tempoEmEspera [] = (0,0)
tempoEmEspera [x] = (0,0)
tempoEmEspera ((x,xs):(y,ys):ts) = adicionaMinutos (tempoEmEspera ((y,ys):ts)) (diferHoras xs y)

-- f) calcular o tempo total da viagem. (tempoEmViagem + tempoEmEspera)
-- Mas só para ser diferente:
tempoTotalViagem :: Viagem -> Hora
tempoTotalViagem vg = let (horaComeco,horaFim) = chegadaPartidaViagem vg 
						in mins2Hora (diferHoras horaComeco horaFim)
