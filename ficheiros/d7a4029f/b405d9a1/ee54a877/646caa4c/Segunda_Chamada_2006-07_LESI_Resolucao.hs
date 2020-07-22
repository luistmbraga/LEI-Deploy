module Exame2 where

import List

-- Parte I

-- 1 a)

type Jornada = [Jogo]
type Jogo = ((Equipa, Golos), (Equipa, Golos))
type Equipa = String
type Golos = Int

pontos :: Jornada -> [(Equipa,Int)]
pontos [] = []
pontos (((x,y),(a,b)):xs) | y == b = (x,1):((a,1):pontos xs)
                          | y > b = (x,3):((a,0):pontos xs)
                          | otherwise = (x,0):((a,3):pontos xs)


-- 1 b)

golosMarcados :: Jornada -> Int
golosMarcados j = sum (map soma j)


soma :: Jogo -> Int
soma ((x,y),(a,b)) = y+b

golosMarcados' :: Jornada -> Int
golosMarcados' [] = 0
golosMarcados' (((x,y),(a,b)):xs) = (y+b)+(golosMarcados' xs)

-- 2


auxV :: (a -> Bool) -> [a] -> [a]
auxV f [] = []
auxV f (x:xs) | f x = x:(auxV f xs)
              | otherwise = auxV f xs

auxF :: (a -> Bool) -> [a] -> [a]
auxF f [] = []
auxF f (x:xs) | f x == False = x:(auxF f xs)
              | otherwise = auxF f xs

filtragem :: (a -> Bool) -> [a] -> ([a],[a])
filtragem f l = (auxV f l, auxF f l)


--3


data ArvBin a = Vazia | Nodo a (ArvBin a) (ArvBin a)

folhas :: ArvBin a -> Int
folhas Vazia = 0
folhas (Nodo x Vazia Vazia ) = 1
folhas (Nodo x e d) = folhas e + folhas d

-- 4


ocorr :: String -> [String] -> [Int]
ocorr s l = aux s l 1


aux :: String -> [String] -> Int -> [Int]
aux _ [] _ = []
aux s (x:xs) ac | s == x = ac:(aux s xs (ac+1))
                | otherwise = aux s xs (ac+1)


-- 5


type ListaCompras = [(Produto, Quantidade)]
type Produto = (Nome, PrecoKg)
type Nome = String
type PrecoKg = Float
type Quantidade = Float

verificaStock :: ListaCompras -> ListaCompras -> String
verificaStock [] _ = "True"
verificaStock ((x,y):xs) ((a,b):as) | y > b = "False"
                                    | otherwise = verificaStock xs as


-- Parte II


-- 1

merge :: (Ord a) => [a] -> [a] -> [a]
merge [] [] = []
merge a b = sort x
           where x = a++b


-- 2


minsep :: (Ord a) => [a] -> (a, [a], [a])
--minsep [] = (0,[],[])
minsep (x:xx) = aux2 (x,[],[]) xx

--aux2 :: (a, [a], [a]) -> [a] -> (a, [a], [a])
aux2 (min,l1,l2) [] = (min,l1,l2) 
aux2 (min,l1,l2) (x:xx) | min < x  = if ((length l1) <= (length l2)) 
                                     then aux2 (min,(x:l1),l2) xx
                                     else aux2 (min,l1,(x:l2)) xx
                        | otherwise = if ((length l1) <= (length l2)) 
                                      then aux2 (x,(min:l1),l2) xx
                                      else aux2 (x,l1,(min:l2)) xx



-- 4


data Btree a = Empty | Node (a, Btree a, Btree a)
	deriving (Eq,Show)

arv = Node (1,Empty,Empty)


list2btree :: (Ord a) => [a] -> Btree a
list2btree [] = Empty
list2btree l = let (y,e,d) = minsep l
               in Node (y, list2btree e, list2btree d)

btree2list :: (Ord a) => Btree a -> [a]
btree2list Empty = []
btree2list a = let x = junta a
               in sort x

junta :: Btree a -> [a]
junta (Node (x, e, d)) = x:(junta e++junta d)  


-- 5 


hsort :: (Ord a) => [a] -> [a]
hsort [] = []
hsort l = merge l []



