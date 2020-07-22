module FichaTP2 where

import Data.Char


-- Ex 1
-- a)
funA :: [Float] -> Float
funA [] = 0
funA (y:ys) = y^2 + (funA ys)

-- funA [2,3,5,1]
-- 2^2 + (funA [3,5,1])
-- 4 + (3^2 + (funA [5,1]))
-- 4 + (9 + (5^2 + (funA [1])))
-- 4 + (9 + (25 + (1^2 + (funA []))))
-- 4 + (9 + (25 + (1 + 0)))
-- 4 + (9 + (25 + 1))
-- 4 + (9 + 26)
-- 4 + 35
-- 39

-- b)
funB :: [Int] -> [Int]
funB [] = []
funB (h:t) = if (mod h 2) == 0 then h : (funB t)
							   else (funB t)

-- funB [8,5,12]
-- 8 : (funB [5,12])
-- 8 : (funB [12])
-- 8 : (12 : (funB []))
-- 8 : (12 : [])
-- 8 : [12]
-- [8,12]


-- Ex 2
-- a) recebe uma lista e produz a lista em que cada elemento ́e o dobro do valor correspondente na lista de entrada.
dobros :: [Float] -> [Float]
dobros [] = []
dobros (h:ts) = (2 * h) : dobros ts

-- b) calcula o número de vezes que um caracter ocorre numa string.
numOcorre :: Char -> String -> Int
numOcorre _ [] = 0
numOcorre c (h:ts) = if (c == h) then 1 + numOcorre c ts else numOcorre c ts

-- c) testa se uma lista só tem elementos positivos.
positivos :: [Int] -> Bool
positivos [] = True
positivos (h:ts) = if (h > 0) then positivos ts else False
-- positivos (h:t) = (h > 0) && positivos t

-- d) retira todos os elementos negativos de uma lista de inteiros.
soPos :: [Int] -> [Int]
soPos [] = []
soPos (h:ts) = if (h >= 0) then h : soPos ts else soPos ts

-- e) soma todos os números negativos da lista de entrada.
somaNeg :: [Int] -> Int
somaNeg [] = 0
somaNeg (h:ts) = if (h < 0) then h + somaNeg ts else somaNeg ts

-- f) devolve os últimos três elementos de uma lista.
--Se a lista de entrada tiver menos de três elementos, devolve a própria lista.
tresUlt :: [a] -> [a]
tresUlt [] = []
tresUlt [a] = [a]
tresUlt [a,b] = [a,b]
tresUlt [a,b,c] = [a,b,c]
tresUlt (h:ts) = tresUlt ts
-- tresUlt list = if (length list < 4) then list else tresUlt (tail list)
-- tresUlt list = drop ((length list) - 3) list

-- g) recebe uma lista de pares e devolve a lista com as primeiras componentes desses pares.
primeiros :: [(a,b)] -> [a]
primeiros [] = []
primeiros ((x,y):ts) = x : primeiros ts


-- Ex 3
-- So para o ASCII de 0-127

-- a) verifica se é um caracter em minusculas.
isLower' :: Char -> Bool
isLower' c = (c >= 'a') && (c <= 'z')

-- b) verifica se o caracter é um digito.
isDigit' :: Char -> Bool
isDigit' c = (c >= '0') && (c <= '9')

-- c) verifica se o caracter pertence ao alphabeto.
isAlpha' :: Char -> Bool
isAlpha' c = ((c >= 'a') && (c <= 'z')) || ((c >= 'A') && (c <= 'Z'))

-- d) se o caracter dado é minuscúla, devolve esse caracter em maiúscula.
toUpper' :: Char -> Char
toUpper' c = if ((c >= 'a') && (c <= 'z')) then chr ((ord c) - 32) else c

-- e) passa um inteiro (entre 0 e 9) para caracter.
intToDigit' :: Int -> Char
intToDigit' x | ((x >= 0) && (x <= 9)) = chr ((ord '0') + x)

-- f) recebe um caracter e devolve o inteiro correspondente ao seu valor inteiro.
digitToInt' :: Char -> Int
digitToInt' c | ((c >= '0') && (c <= '9')) = (ord c) - (ord '0')


-- Ex 4

-- a) recebe uma string como argumento e testa se o seu primeiro caracter é uma letra maiúscula.
primMai :: String -> Bool
primMai st = isUpper (head st)

-- b) recebe uma string como argumento e testa se o seu segundo caracter é uma letra minúscula.
segMin :: String -> Bool
segMin st = isLower (head (tail st))


-- Ex 5

-- a) recebe uma lista de caracteres, e selecciona dessa lista os caracteres que são algarismos.
soDigitos :: [Char] -> [Char]
soDigitos [] = []
soDigitos (h:ts) = if (isDigit h) then h : soDigitos ts else soDigitos ts

-- b) recebe uma lista de caracteres, e conta quantos desses caracteres são letras minúsculas.
minusculas :: [Char] -> Int
minusculas [] = 0
minusculas (h:ts) = if (isLower h) then 1 + (minusculas ts) else minusculas ts

-- c) recebe uma string e devolve uma lista com os algarismos que occorem nessa string, pela mesma ordem.
nums :: String -> [Int]
nums [] = []
nums (h:ts) = if (isDigit h) then (digitToInt h) : nums ts else nums ts

-- Author: Pirata
