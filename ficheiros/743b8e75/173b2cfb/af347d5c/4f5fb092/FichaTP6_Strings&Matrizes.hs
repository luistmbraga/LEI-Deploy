-- @author Pirata
-- @version 2015.11

module FichaTP6 where

import Data.Char

-- Ex1 - função toDigits que, dado um número (na base 10), calcula a lista dos seus dígitos na ordem inversa.
toDigits :: Int -> [Int]
toDigits 0 = []
toDigits x = (mod x 10) : (toDigits (div x 10))

-- Ex2 - função inversa da anterior fromDigits.
-- a) com auxilio da função zipWith.
fromDigits' :: [Int] -> Int
fromDigits' ints = sum (zipWith (\x y -> x * (10^y)) ints [0,1..])

-- b) com recursividade directa.
fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits (h:ts) = h + 10 * (fromDigits ts)

-- c) usando a função foldr.
fromDigits'' :: [Int] -> Int
fromDigits'' l = foldr (\x y -> x + (y * 10)) 0 l

-- Ex3 - usando as funções anteriores, e as funções predefinidas intToDigit e digitToInt, em Data.Char.
-- a) função intStr que converte um inteiro numa String.
intStr :: Int -> String
intStr ints = map intToDigit (reverse (toDigits ints))

-- b) função strInt que, inversa a anterior, converte a representação de um inteiro (na base 10) nesse inteiro.
strInt :: String -> Int
strInt str = fromDigits (reverse (map digitToInt str))

-- Ex4 -  função agrupa que, dada uma String junta num par (x,n) as n ocorrências consecutivas de um carácter x.
agrupa :: String -> [(Char,Int)]
agrupa [] = []
agrupa str = let (a,b) = span ((head str) == ) str in (head a, length a) : agrupa b

-- Ex5 - função subLists que calcula todas as sublistas de uma determinada lista.
subList :: [a] -> [[a]]
subList [] = [[]]
subList (h:ts) = (map (\xs -> h:xs) (subList ts)) ++ (subList ts)

-- Ex6 - Matrizes
type Mat a = [[a]]

-- matriz de teste
m1 :: Mat Int
m1 = [[1,2,3],[0,4,5],[0,0,6]]

-- a) função dimOk que testa se uma matriz está bem construída.
dimOk :: Mat a -> Bool
dimOk [] = False
dimOk (h:ts) = dAux (length h) ts where
	dAux x [] = if (x > 0) then True else False
	dAux x (h:ts) = if (x == (length h)) then dAux x ts else False

-- b) dimMat que calcula a dimensão de uma matriz.
dimMat :: Mat a -> (Int,Int)
--  supondo dimOk m == True
dimMat m | dimOk m = (length m, length (head m))

-- c) função addMat que adiciona duas matrizes.
addMat :: (Num a) => Mat a -> Mat a -> Mat a
-- ambas matrizes têm as dimensões iguais;
addMat [] [] = []
addMat xs ys = zipWith (zipWith (+)) xs ys

-- d) função transpose, que calcula a transposta de uma Matriz.
transpose :: Mat a -> Mat a
transpose [] = []
transpose mat = if (length (head mat) > 1) then (map head mat) : (transpose (map tail mat)) else [(map head mat)]

-- e) função multMat que calcula o produto de duas matrizes.
multMat :: (Num a) => Mat a -> Mat a -> Mat a
-- supondo que snd (dimMat m1) == fst (dimMat m2)
multMat [] _ = []
multMat m1 m2 = (map (\x -> (sum (zipWith (*) (head m1) x))) (transpose m2)) : (multMat (tail m1) m2)

-- f) função zipWMat que, à semelhança do que acontece com zipWith, combina duas matrizes.
-- Use esta função para definir uma função que soma duas matrizes.
zipWMat :: (a -> b -> c) -> Mat a -> Mat b -> Mat c
zipWMat f mA mB = zipWith (zipWith f) mA mB

-- addMat mat1 mat2 = zipWMat (+) mat1 mat2

-- g) função triSup que testa se uma matriz é triangular superior.
triSup :: (Eq a,Num a) => Mat a -> Bool
triSup [] = False
triSup mat = tAux 0 mat where
	tAux x [] = True
	tAux x (h:ts) = if ((length (fst (span (0 ==) h))) >= x) then tAux (x + 1) ts else False

-- h) função rotateLeft que roda uma matriz 90º para a esquerda.
rotateLeft :: Mat a -> Mat a
rotataLeft [] = []
rotateLeft m = if (length (head m)) > 1 then (rotateLeft (map (drop 1) m)) ++ [map head m] else [map head m]
