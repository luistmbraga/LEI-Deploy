module Exame1 where

-- 1

lista :: [a] -> (a,a)
lista (x:xs) = (x, lst xs)
             where lst :: [a] -> a
                   lst [a] = a
                   lst (a:as) = lst as

-- 2


unzipp :: [(a,b)] -> ([a], [b])
unzipp l = (aux1 l, aux2 l)

aux1 :: [(a,b)] -> [a]
aux1 [] = []
aux1 (a:as) = (fst a):(aux1 as)

aux2 :: [(a,b)] -> [b]
aux2 [] = []
aux2 (a:as) = (snd a):(aux2 as)

-- 3

data BTree a = Empty | Node a (BTree a) (BTree a)

altura :: BTree a -> Int
altura Empty = 0
altura (Node x e d) = 1 + (max (altura e) (altura d))

-- 4


data Fraccao = Frac Integer Integer 
           deriving (Show)

prodFracs :: [Fraccao] -> Fraccao
prodFracs [a] = a  
prodFracs ((Frac x y):xs) = let (Frac i j) = prodFracs xs
                            in Frac (x*i) (y*j)

-- 5 a)


type ListaCompras = [(Produto, Quantidade)]
type PrecoKg = Float
type Nome = String
type Produto = (String, PrecoKg)
type Quantidade = Float

produtosCaros :: ListaCompras -> PrecoKg -> ListaCompras
produtosCaros lista limite = filter (eCaro limite) lista

eCaro :: PrecoKg -> (Produto, Quantidade) -> Bool
eCaro a ((x,y), z) | a > y = True
                   | otherwise = False


-- 5 b)


precoItens :: ListaCompras -> [(Nome, Float)]
precoItens [] = []
precoItens l = map precoItem l

precoItem :: (Produto, Quantidade) -> (Nome, Float)
precoItem ((x,y), b) = (x, y*b)

-- Parte II


-- 1 

type Calendario = [Exame]
data Exame = Ex NomeE Data Tipo
type NomeE = String
data Data = D Ano Mes Dia Periodo 
        deriving (Eq, Show)
type Ano = Int
data Mes = Jan | Fev | Mar | Abr | Mai | Jun | Jul | Ago | Set | Out | Nov | Dez
	deriving (Eq, Enum, Ord, Show)
type Dia = Int
data Periodo = Manha | Tarde 
        deriving (Eq, Enum, Ord, Show)
data Tipo = Primeira | Segunda | Recurso 
        deriving (Eq, Show)

diasMes :: [(Mes, Int)]
diasMes = [(Jan,31), (Fev,28), (Mar,31), (Abr,30), (Mai,31), (Jun,30), (Jul,31), (Ago,31), (Set,30), (Out,31), (Nov,30), (Dez,31)]


instance Ord Data where
  (<=) (D x y z t) (D x1 y1 z1 t1) = ((<=) x x1) && ((<=) y y1) && ((<=) z z1) && ((<=) t t1)  

-- 2


datas :: NomeE -> Calendario -> [Data]
datas s [] = []
datas s ((Ex n d t):xs) | s == n = d:(datas s xs)
                        | otherwise = datas s xs

-- 3

intervalo :: Data -> Data -> Int
intervalo (D _ x y _) (D _ x1 y1 _) = let ex1 = (calcula x diasMes) + y 
                                          ex2 = (calcula x1 diasMes) + y1
                                      in if (ex1 > ex2) then
                                           ex1 - ex2 - 1
                                         else
                                           ex2 - ex1 - 1


calcula :: Mes -> [(Mes, Int)] -> Int
calcula _ [] = 0
calcula s ((x,y):xs) | s==x = y
                     | otherwise = y + (calcula s xs)


-- 4


verifica :: [NomeE] -> Calendario -> [NomeE]
verifica _ [] = []
verifica [] _ = []
verifica (x:xs) y | ((verificaEx x y) == 3) && verificaCh (verificaEx' x y) = x:(verifica xs y)
                  | otherwise = verifica xs y


verificaEx :: NomeE -> Calendario -> Int
verificaEx s [] = 0
verificaEx s ((Ex x _ _):xs) | s==x = 1 + (verificaEx s xs) 
                             | otherwise = verificaEx s xs

verificaEx' :: NomeE -> Calendario -> Calendario
verificaEx' s [] = []
verificaEx' s ((Ex x y z):xs) | s==x = (Ex x y z):(verificaEx' s xs) 
                              | otherwise = verificaEx' s xs

verificaCh :: Calendario -> Bool
verificaCh (((Ex _ (D _ a b _) _):((Ex _ (D _ c d _) _):((Ex _ (D _ e f _) _)):[]))) | (((calcula a diasMes)+b) < ((calcula c diasMes)+d)) && (((calcula c diasMes)+d) < ((calcula e diasMes)+f)) && ((((calcula e diasMes)+f) - ((calcula c diasMes)+d)) >= 7) = True
                                                                                     | otherwise= False

-- Estou a partir do principio de que se o numero de exames for 3, entao a ordem dos exames ja estara correcta (1ª chamada em 1º lugar, 2ª chamada em 2º e recurso em 3º)  

teste = [(Ex "PF" (D 2007 Jan 7 Manha) Primeira), (Ex "PF" (D 2007 Jan 10 Manha) Segunda), (Ex "PF" (D 2007 Jan 17 Manha) Recurso)]
