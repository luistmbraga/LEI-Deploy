-- @autor Pirata
-- @version 2015.v1

module FichaTP5 where

import Data.Char

-- Ex 1 - Forma de representar polinomios.

type Polinomio = [Monomio]
type Monomio = (Float,Int) -- (coeficiente,expoente)

-- polinomios para teste:
p1 :: Polinomio
p1 = [(2,3),(3,4),(5,3),(4,5)]

-- a) função conta que diz quantos monomios de grau n existem no polinómio;
conta :: Int -> Polinomio -> Int
conta _ [] = 0
conta n (h:ts) = if (n == (snd(h))) then 1 + (conta n ts) else 0 + (conta n ts)

-- alternativa com funções ordem superior
conta' :: Int -> Polinomio -> Int
conta' n p = length (filter (\(c,e) -> e == n) p)

-- alternativa com listas por compreensao
conta'' :: Int -> Polinomio -> Int
conta'' n p = length [(c,e) | (c,e) <- p, e == n]

-- ambas as alternativas são menos eficientes, correm duas vezes a lista.
-- uma para filtrar e a segunda para contar.

-- b) função grau que indica o grau de um polinómio;
grau :: Polinomio -> Int
grau [(c,e)] = e
grau ((c,e):(cs,es):ts) = if (es > e) then grau ((cs,es):ts) else grau ((c,e):ts)

-- alternativa usando uma função pré-definida max
grau' :: Polinomio -> Int
grau' [(c,e)] = e
grau' ((c,e):ts) = max e (grau' ts)

-- c) função selgrau que seleciona os monómios de um determinado grau de um polinómio;
selgrau :: Int -> Polinomio -> Polinomio
selgrau g poli = filter (\(c,e) -> e == g) poli

-- d) completar a função deriv que calcula a derivada de um polinómio;
deriv :: Polinomio -> Polinomio
deriv pol = map (\(c,e) -> (c * (fromIntegral e),e - 1)) pol

-- e) função calcula que calcula o valor do polinómio para um determinado valor de x;
calcula :: Float -> Polinomio -> Float
calcula _ [] = 0
calcula x ((c,e):ts) = ((x ^ e) * c) + (calcula x ts)

-- f) função simp que retira de um polinómio os monómios de coeficiente 0, usando uma função superior;
simp :: Polinomio -> Polinomio
simp pol = filter (\(c,e) -> c /= 0) pol

-- g) função mult que calcula o resultado da multiplicação de um monómio por um polinómio;
mult :: Monomio -> Polinomio -> Polinomio
mult _ [] = []
mult (c,e) p = map (\(x,y) -> (x * c,e + y)) p

-- h) função normaliza que dado um polinómio, devolve um polinómio equivalente em que não exista vários monómios com o mesmo grau;
normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza (h:ts) = acresAux h (normaliza ts) where
	acresAux :: Monomio -> Polinomio -> Polinomio
	acresAux (c,e) [] = [(c,e)]
	acresAux (c,e) ((x,y):ts) = if (e == y) then (c + x, e):ts else (x,y) : (acresAux (c,e) ts)

-- i) função soma, que faz a soma de dois polinómios;
soma :: Polinomio -> Polinomio -> Polinomio
soma [] poli = poli
soma (h:ts) poli = soma ts (acresAux h poli) where
	acresAux :: Monomio -> Polinomio -> Polinomio
	acresAux (c,e) [] = [(c,e)]
	acresAux (c,e) ((x,y):ts) = if (e == y) then (c + x, e):ts else (x,y) : (acresAux (c,e) ts)

-- j) função produto que calcula o produto de dois polinómios; não normalizado;
produto :: Polinomio -> Polinomio -> Polinomio
produto [] poli = poli
produto poli [] = poli
produto [x] poli = mult x poli
produto (x:xs) poli = (mult x poli) ++ (produto xs poli)

-- k) função ordena que ordena um polinómio por ordem crescente do grau dos seus monómios;
ordena :: Polinomio -> Polinomio
ordena [] = []
ordena (h:ts) = ordAux h (ordena ts) where
	ordAux m [] = [m]
	ordAux (c,e) ((x,y):ts) = if (e < y) then (c,e):(x,y):ts else (x,y) : (ordAux (c,e) ts)

-- l) função equiv que testa se dois polinómios são equivalentes;
equiv :: Polinomio -> Polinomio -> Bool
equiv poli1 poli2 = (ordena (normaliza poli1)) == (ordena (normaliza poli2))
--	compAux [] [] = True
--	compAux [] _ = False
--	compAux _ [] = False
--	compAux ((x,ex):xs) ((y,ey):ys) = (x == y) && (ex == ey) && (compAux xs ys)


-- Penso que de algum modo estas duas próximas funções deveriam ser feitas com alguma função de ordem superior ou assim,
-- mas não me lembrei de nenhuma que fosse melhor que da maneira que as fiz.

-- Ex 2 - função nzp que, dada uma lista de inteiros,
-- conta o número de valores nagativos, o número de zeros e, o número de valores positivos,
-- devolvendo um triplo com essa informação.
-- Certifique-se que a função percorre a lista apenas uma vez.
nzp :: [Int] -> (Int,Int,Int)
nzp [] = (0,0,0)
nzp (h:ts) | h < 0 = (1 + a,0 + b,0 + c)
		   | h == 0 = (0 + a,1 + b,0 + c)
		   | h > 0 = (0 + a,0 + b,1 + c)
	where (a,b,c) = nzp ts

-- Ex 3 - função digitAlpha que, dada uma String, devolve um par de Strings:
-- uma apenas com as letras presentes nessa String,
-- e a outra apenas com os números presentes na String.
-- Implemente de modo a fazer uma única travessia da String.
digitAlpha :: String -> (String,String)
digitAlpha [] = ([],[])
digitAlpha (h:ts) | isAlpha h = (h:a,b)
				  | isDigit h = (a,h:b)
				  | otherwise = (a,b)
	where (a,b) = digitAlpha ts

-- Ex 4 - Listas por compreensão:
-- enumerar o resultado e,
-- definir de outro modo; - existem muitas outras hipóteses além das apresentadas;
-- a) [6,12,18]
l4a = [x | x <- [1..20], mod x 2 == 0, mod x 3 == 0]
l4a' = [x | x <- [2,4..20], mod x 3 == 0]

-- b) [6,12,18]
l4b = [x | x <- [y | y <- [1..20], mod y 2 == 0], mod x 3 == 0]
l4b' = [x | x <- [1..20], mod x 6 == 0]

-- c) [(10,20),(11,19),(12,18),(13,17),(14,16),(15,15),(16,14),(17,13),(18,12),(19,11),(20,10)]
l4c = [(x,y) | x <- [0..20], y <- [0..20], x+y == 30]
l4c' = [(x,y) | x <- [10,20], y <- [20..10], x+y == 30]

-- d) [1,1,4,4,9,9,16,16,25,25]
l4d = [sum [y | y <- [1..x], odd y] | x <- [1..10]]
l4d' = [concat [[x**2] ++ [x**2] | x <- [1..5]]]

-- Ex 5 - Definir por compreensão:

-- a) [1,2,4,8,16,32,64,128,256,512,1024]
l5a = [2^x | x <- [0..10]]

-- b) [(1,5),(2,4),(3,3),(4,2),(5,1)]
l5b = [(x,y) | x <- [1..5], y <- [1..5], x+y == 6]
l5b' = [(x,6-x) | x <- [1..5]]

-- c) [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]
l5c = [[1..x] | x <- [1..5]]

-- d) [[1],[1,1],[1,1,1],[1,1,1,1],[1,1,1,1,1]]
l5d = [[1 | x <- [1..y]] | y <- [1..5]]

-- e) [1,2,6,24,120,720]
l5e = [product [1..x] | x <- [1..6]]
-- or [fact x | x <- [1..6]] if fact was defined.

-- Ex 6 - funções pré-definidas
-- a)
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipwith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)

-- b)
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' f (h:ts) = if (f h) then h : (takeWhile' f ts) else []

-- c)
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' f (h:ts) = if (f h) then dropWhile' f ts else (h:ts)

-- d)
span' :: (a -> Bool) -> [a] -> ([a],[a])
span' _ [] = ([],[])
span' f (h:ts) = if (f h) then (h:a,b) else ([],(h:ts)) where
	(a,b) = span' f ts

span'' :: (a -> Bool) -> [a] -> ([a],[a])
span'' f list = sAux f list [] where
	sAux _ [] new = (new,[])
	sAux f (h:ts) new = if (f h) then sAux f ts (new ++ [h]) else (new,(h:ts))
