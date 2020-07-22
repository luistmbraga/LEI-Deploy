module Ficha7 where

type Dia = Int 
type Mes = Int 
type Ano = Int 
type Nome = String

data Data = D Dia Mes Ano 
		deriving Eq

type TabDN = [(Nome,Data)]

--1
--a
procura :: Nome -> TabDN -> Maybe Data
procura no [] = Nothing
procura no ((na,dt):ndts) = if (no == na) then (Just dt) else (procura no ndts)

--b
idade :: Data -> Nome -> TabDN -> Maybe Int
idade da no [] = Nothing
idade da no ((na,dt):ndts)	| (no == na) = let a = calcdif da dt in if a>=0 then Just a else Nothing 
							| otherwise = (idade da no ndts)					
				
calcdif :: Data ->  Data -> Int
calcdif (D x y z) (D a b c) = z - c

--c
anterior ::	Data -> Data -> Bool
anterior (D x y z) (D a b c) = (z < c) || ((z == c) && (y < b)) || ((z == c) && (y == b) && (x < a))

anteriore :: Data -> Data -> Bool
anteriore (D x y z) (D a b c) = ((x * 10000) + (y * 100) + z) < ((a * 10000) + (b * 100) + c) 

--d
ordena ::	TabDN -> TabDN
ordena (x:xs) = ordAux x (ordena xs)

ordAux :: (Nome,Data) -> TabDN -> TabDN
ordAux (no,D x y z) [] = [(no,D x y z)]
ordAux (no,(D x y z)) ((nome,(D a b c)): ndts) = if ((z < c) || ((z == c) && (y < b)) || ((z == c) && (y == b) && (x < a))) then (no,D x y z):(nome,D a b c):ndts else (nome,D a b c) : (ordAux (no,D x y z) ndts)

--e

porIdade :: Data -> TabDN -> [(Nome,Int)]
porIdade d l = alteraIdade d (ordena l)

alteraIdade :: Data -> TabDN -> [(Nome,Int)]
alteraIdade _ [] = []
alteraIdade d ((no,dt):t) = (no,(calcdif d dt)) : (alteraIdade d t)


--2

type TabAbrev = [(Abreviatura, Palavra)]
type Abreviatura = String
type Palavra = String

--a
daPal :: TabAbrev -> Abreviatura -> Maybe Palavra
daPal [] a = Nothing
daPal ((avt,plv):aps) a = if (a == avt) then (Just plv) else (daPal aps a)

--b

transforma :: TabAbrev -> String -> String
transforma t s = unwords (trata t (words s))

trata :: TabAbrev -> [String] -> [String]
trata l (h:t)	| (daPal l h) == Nothing = h: trata l t
				| otherwise = catM (daPal l h): trata l t
trata l [] = []				 

catM :: Maybe Palavra -> Palavra
catM (Just x) = x

--3

data Movimento = Credito Float | Debito Float
data Extrato = Ext Float [(Data, String, Movimento)]

--a
extValor :: Extrato -> Float -> [Movimento]
extValor (Ext a l) v = processa v l

processa :: Float -> [(Data, String, Movimento)] -> [Movimento]
processa x ((d,s, Credito c): dsm) = if (c >= x) then (Credito c) : (processa x dsm) else processa x dsm
processa x ((d,s, Debito c): dsm) = if (c >= x) then (Debito c) : (processa x dsm) else processa x dsm

--b
filtro :: Extrato -> [String] -> [(Data,Movimento)]
filtro (Ext a l) s = filtras s l

filtras :: [String] -> [(Data, String, Movimento)] -> [(Data, Movimento)]
filtras (h:t) ((dt,st,mov): dsm) = if (h == st) then (dt, mov) : (filtras (h:t) dsm) else filtras (h:t) dsm

--d
saldo :: Extrato -> Float
saldo (Ext s []) = s
saldo (Ext s ((_,_,Credito c):dtm)) = c + saldo (Ext s dtm)
saldo (Ext s ((_,_,Debito c):dtm)) = saldo (Ext s dtm) - c