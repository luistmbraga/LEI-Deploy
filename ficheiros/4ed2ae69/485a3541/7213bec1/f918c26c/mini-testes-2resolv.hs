--1

type MSet a = [(a, Int)]

--a

insere :: Eq a => a -> MSet a -> MSet a
insere a [] = [(a, 1)]
insere a ((x, y):xs) = if a == x then (x, y + 1):xs
                                 else (x, y):(insere a xs)

--b
moda :: MSet a -> [a]
moda xs = map fst $ filter ((==maxim).snd) xs
    where maxim = maximum $ map snd xs

--2
--a

type Radar     = [(Hora, Matricula, VelAutor, VelCond)]
type Hora      = (Int,Int)
type Matricula = String
type VelAutor  = Float              --velocidade autorizada
type VelCond   = Float            --velocidade condutor

radarCorrecto :: Radar -> Bool
radarCorrecto [] = True
radarCorrecto ((_, _, velA, velC):xs) = velC > velA && radarCorrecto xs

--b

velocidadeAcumulada :: Radar -> Float 
velocidadeAcumulada [] = 0
velocidadeAcumulada ((_, _, velA, velC):xs) = velC - velA + velocidadeAcumulada xs

--c

hora2mins :: Hora -> Int
hora2mins (x, y) = x*60 + y

maiorTempoSemInfracoes :: Radar -> Int
maiorTempoSemInfracoes [(h1, _, _, _),(h2, _, _, _)] = hora2mins h2 - hora2mins h1 
maiorTempoSemInfracoes ((h1, _, _, _):y@(h2, _, _, _):xs) = max (hora2mins h2 - hora2mins h1) (maiorTempoSemInfracoes (y:xs))

--3

type Inscritos = [(Num', Nome, Curso, Ano)]
type Num' = Integer
type Nome = String
type Curso = String
type Ano = Integer

--a
aluCA :: (Curso, Ano) -> Inscritos -> Int
aluCA t@(c1, a1) ((_, _, c2, a2) : xs) = if c1 == c2 && a1 == a2 then 1 + aluCA t xs
                            							         else aluCA t xs

--b
quantos :: Curso -> [Num'] -> Inscritos -> Int
quantos _ _ [] = 0
quantos c1 l i@((n, _, c2, _):xs) = if c1 == c2 && elem n l then 1 + quantos c1 l i
                                                            else quantos c1 l i

--c
doAno :: Ano -> Inscritos -> [(Num', Nome, Curso)]
doAno _ [] = []
doAno a1 ((n, nm, c, a2):xs) = if a1 == a2 then (n, nm, c) : doAno a1 xs
                                           else              doAno a1 xs


--4

--a
elimina:: Eq a => a -> MSet a -> MSet a
elimina a [] = []
elimina a ((x, 1):xs) = if a == x then xs else elimina a xs
elimina a ((x, y):xs) = if a == x then (x, y - 1):xs
                                  else (x, y):(elimina a xs)

--b

ordena :: MSet a -> MSet a
ordena [x] = [x]
ordena (x:xs) = insertPorOcorr x (ordena xs)

insertPorOcorr :: (a, Int) -> MSet a -> MSet a
insertPorOcorr x [] = [x]
insertPorOcorr x@(a, b) (y@(c, d):xs) = if b < d then x:y:xs
                                                 else y:(insertPorOcorr x xs)

type PlayList = [(Titulo, Interprete, Duracao)]
type Titulo = String
type Interprete = String
type Duracao = Int

--a

total :: PlayList -> Int
total [] = 0
total ((_, _, t):xs) = t + total xs

temMusicas :: [Interprete] -> PlayList -> Bool
temMusicas [] _ = True
temMusicas (x:xs) pl = elem x interpretes && temMusicas xs pl
    where interpretes = map (\(_, i, _) -> i) pl

maior :: PlayList -> (Titulo, Duracao)
maior [(t, i, d)] = (t, d)
maior ((t, i, d):xs) = if d > snd (result) then (t, d)
                                           else result
    where result = maior xs

--a

excessoVelPorMatricula :: Radar -> Matricula -> Float
excessoVelPorMatricula [] _ = 0
excessoVelPorMatricula ((_, m, velA, velC):xs) m2 = if m == m2 then (velC - velA) + excessoVelPorMatricula xs m2
                                                               else excessoVelPorMatricula xs m2

--b

infracoesHora :: Radar -> Int -> Int
infracoesHora [] _ = 0
infracoesHora (((h, _), _, _, _):xs) h2 = if h == h2 then 1 + infracoesHora xs h2
                                                     else     infracoesHora xs h2

--c

horaMaior :: Hora -> Hora -> Bool
horaMaior (h1, m1) (h2, m2) = h1 > h2 || h1 == h2 && m1 > m2

radarCorrect :: Radar -> Bool
radarCorrect [] = True
radarCorrect [x] = True
radarCorrect ((h1, _, _, _):y@(h2, _, _, _):xs) = horaMaior h2 h1 && radarCorrect (y:xs)


--7

type TabAbrev = [(Abreviatura, Palavra)]
type Abreviatura = String
type Palavra = String

--a

existe :: Abreviatura -> TabAbrev -> Bool
existe ab ((a, p):xs) = ab == a || existe ab xs

substitui :: [String] -> TabAbrev -> [String]
substitui xs [] = xs 
substitui xs ((abrev, palav):ys) = substitui (map (replace abrev palav) xs) ys

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace [] _ _ = []
replace find repl s@(x:xs) = if take findS s == find
                    then repl ++ (replace (drop findS s) find repl)
                    else x : (replace (xs) find repl)
    where findS = length find

--c

estaOrdenada :: TabAbrev -> Bool
estaOrdenada [] = True
estaOrdenada [x] = True
estaOrdenada ((a1, _):y@(a2, _):xs) = a1 < a2 && estaOrdenada (y:xs)

--8

--a

--f "otrec" = g [] "otrec" = g ('o':[]) "trec" = 
--g 't':"o" "rec" = g 'r':"to" "ec" = g 'e':"rto" "c"
--g 'c':"erto" "" = "certo"

--b
type Monomio = (Float, Int)
type Polinomio = [Monomio]

--i
coef :: Polinomio -> Int -> Float
coef [] _ = 0
coef ((c, e):xs) grau = if e == grau then c else coef xs grau


--ii
poliOk :: Polinomio -> Bool
poliOk [] = True
poliOk ((c, e):xs) = c /= 0 && not (elem e (map snd xs)) && poliOk xs 

--9

--a

size :: MSet a -> Int
size [] = 0
size ((_, x):xs) = x + size xs

--b

union :: Eq a => MSet a -> MSet a -> MSet a
union (x:xs) ys = union xs (adicionar x ys) 

adicionar :: Eq a => (a, Int) -> MSet a -> MSet a
adicionar t [] = [t]
adicionar (a, b) ((x, y):xs) = if a == x then (x, y + b):xs
                                         else (x, y):(adicionar (a, b) xs)


--10

--a

maisQUmaInfracao :: Radar -> Bool
maisQUmaInfracao xs = existeRepetidos (map (\(_, m, _, _) -> m) xs)


existeRepetidos :: Eq a => [a] -> Bool
existeRepetidos [] = False
existeRepetidos (x:xs) = elem x xs || existeRepetidos xs

--b

infracPorMatri :: Matricula -> Radar -> [(Hora, Float)]
infracPorMatri _ [] = []
infracPorMatri m2 ((h, m, velA, velC):xs) = if m == m2 then (h, velC - velA):infracPorMatri m2 xs
                                                       else infracPorMatri m2 xs

--c

radarCorrecto' :: Radar -> Bool
radarCorrecto' [] = True
radarCorrecto' [x] = True
radarCorrecto' ((h1, _, _, _):y@(h2, _, _, _):xs) = horaMaior h2 h1 && radarCorrecto' (y:xs)

--11

type TabTemp = [(Data, Temp, Temp)] --(data, temperatura mínima, temperatura maxima)
type Data = (Int, Int, Int) --(ano mes dia)
type Temp = Float

--a
medias :: TabTemp -> [(Data, Temp)]
medias [] = []
medias ((d, max, min) : tt) = (d, (max + min)/2) : medias tt

--b
decrescente :: TabTemp -> Bool
decrescente [(d, _, _)] = True 
decrescente ((d1, _, _):y@(d2, _, _):tt) = d1 > d2 && decrescente (y:tt)

--c
conta :: [Data] -> TabTemp -> Int
conta ds [] = 0 
conta ds ((d, _, _):tt) = if elem d ds then 1 + conta ds tt 
			                           else     conta ds tt

--12

--a
naMesmaHora :: Radar -> Bool
naMesmaHora [] = False
naMesmaHora (((h, m), _, _, _):xs) = (not . null) (filter ((==h).(\((h2, _), _, _ , _) -> h2)) xs) || naMesmaHora xs

--b
maiorInfrac :: Radar -> (Hora, Matricula, VelAutor, VelCond)
maiorInfrac [x] = x
maiorInfrac (i1@((h, m), ma, va, vc):xs) = if velMA >= velML then i1 else i2
	where velMA = vc  - va
	      velML = vcL - vaL
	      i2@(_, _, vaL, vcL) = maiorInfrac xs

--c

menorTempoSemInfracoes :: Radar -> Int
menorTempoSemInfracoes [(h1, _, _, _),(h2, _, _, _)] = hora2mins h2 - hora2mins h1 
menorTempoSemInfracoes ((h1, _, _, _):y@(h2, _, _, _):xs) = min (hora2mins h2 - hora2mins h1) (menorTempoSemInfracoes (y:xs))

--13

--a

--f "exif" = g [] "exif" = g ('e':[]) "xif" = 
--g 'x':"e" "fi" = g 'i':"xe" "f" = g 'f':"ixe" ""
--"fixe"

--b
addM :: Polinomio -> Monomio -> Polinomio
addM [] (c, e) = [(c, e)]
addM (m1@(c1, e1):xs) m2@(c2, e2)
	| e1 == e2 && c1 == -c2 = xs
	| e1 == e2              = (c1 + c2, e1):xs
	| otherwise             = m1:(addM xs m2) 

--c

addP :: Polinomio -> Polinomio -> Polinomio
addP []     ys = ys
addP (x:xs) ys = addP xs (addM ys x)

--14

--a

elem' :: Eq a => a -> MSet a -> Bool
elem' x [] = False
elem' x ((e, o):xs) = x == e || elem' x xs

--b

converte :: Eq a => [a] -> MSet a
converte [] = []
converte (x:xs) = insere x (converte xs)

{-
A função insere foi definida acima, no exercício 1(a).

insere :: Eq a => a -> MSet a -> MSet a
insere a [] = [(a, 1)]
insere a ((x, y):xs) = if a == x then (x, y + 1):xs
                                 else (x, y):(insere a xs)
-}
