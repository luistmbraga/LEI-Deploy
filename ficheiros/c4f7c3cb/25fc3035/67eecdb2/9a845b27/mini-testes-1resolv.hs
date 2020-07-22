import Data.Char


--1
--a

nome :: String -> Bool
nome (x:y:xs) = isLower y

--b
type Jogo = (String, Int, String, Int)

equipaComXgolos :: Jogo -> Int -> String
equipaComXgolos (s1, g1, s2, g2) golos
	|golos == g1 = s1
	|golos == g2 = s2
	|otherwise   = ""

--c

jogosComXGolos :: [Jogo] -> Int -> Int
jogosComXGolos xs golos = length (filter (\j -> equipaComXgolos j golos /= "") xs)

--2

type Ponto = (Float, Float) --(Abcissa, Ordenada)
type Rectangulo = (Ponto, Ponto)

quadrado :: Rectangulo -> Bool
quadrado ((x1, y1), (x2, y2)) = abs (x1 - x2) == abs (y1 - y2)

contaQuadrados :: [Rectangulo] -> Int
contaQuadrados xs = length (filter quadrado xs)

--3 
--a
dist :: (Float, Float) -> Float
dist (x, y) = sqrt (x^2 + y^2)

--b


fun :: [Float] -> [Float]
fun [] = []
fun (h:t) = if h>=0 then h : (fun t)
		    else     (fun t)

{-
fun [3,-5,0,-3,2] = 3 : fun [-5, 0, -3, 2] =
3 : fun [0, -3, 2] = 3 : 0 : fun [-3, 2]   =
3 : 0 : fun [2] = 3 : 0 : 2 : fun [] =
3 : 0 : 2 : [] = 3 : 0 : [2] = 3 : [0, 2] =
[3, 0, 2]
-}

--c

somaNeg :: [Int] -> Int
somaNeg xs = sum $ filter (<0) xs

--4

escala :: Float -> Rectangulo -> Rectangulo
escala s ((x1, y1), (x2, y2)) = ((x1, y1), ((s*(x2 - x1)) + x1, s*(y2 - y1) + y1))


escalaTudo :: Float -> [Rectangulo] -> [Rectangulo]
escalaTudo e xs = map (escala e) xs

--5

--a
eMultiplo :: Int -> Int -> Bool
eMultiplo x y = (x `mod` y) == 0

mults :: Int -> Int -> Int -> Bool
mults a b c = eMultiplo a b || eMultiplo a c || eMultiplo b a || eMultiplo b c || eMultiplo c a || eMultiplo c b

--b


fun' :: [Float] -> Float
fun' [] = 1
fun' (x:xs) = x * (fun' xs)

{-
fun' [3,5,2] = 3 * fun' [5,2] =
3 * 5 * fun' [2] = 3 * 5 * 2 * fun' [] =
3 * 5 * 2 * 1 =
30
-}

--c
triplos :: [Int] -> [Int]
triplos xs = map (*3) xs

--6
--a

p :: Int -> Bool
p 0 = True
p 1 = False
p x | x > 1 = p (x - 2)

--p 5 = p 3 = p 1 = False

--b
type Circulo = (Ponto, Float) --(Centro, Raio)


--i
distP :: (Float,Float) -> (Float,Float) -> Float
distP (a,b) (c,d) = sqrt ((a-c)^2 +(b-d)^2)

dentro :: Ponto -> Circulo -> Bool
dentro p (c, r) = distP p c < r

--ii
filtra :: Ponto -> [Circulo] -> Int
filtra p xs = length $ filter (dentro p) xs


--7
--a
somaIgual :: Int -> Int -> Int -> Bool
somaIgual a b c = a == (b + c) || b == (a + c) || c == (a + b)

--b
resJogo :: Jogo -> Char
resJogo (_, g1, _, g2)
	|g1 > g2   = '1'
	|g1 < g2   = '2'
	|otherwise = 'x' --caso seja empate.

--c
jogosGanhosFora :: [Jogo] -> Int
jogosGanhosFora xs = length (filter (\j -> resJogo j == '2') xs) 

--8

--a
supSoma :: Int -> Int -> Int -> Bool
supSoma a b c = (a + b) > c || (a + c) > b || (b + c) > a

--b


fun'' :: [Float] -> Float
fun'' [] = 0
fun'' (y:ys) = y^2 + (fun'' ys)

{-
fun'' [2, 3, 5] = 4 + fun'' [3, 5] = 4 + 9 + fun'' [5] =
4 + 9 + 25 + fun'' [] = 4 + 9 + 25 + 0 = 38

-}

--c

soDigitos :: [Char] -> [Char]
soDigitos xs = filter isDigit xs

--9
area :: Rectangulo -> Float
area ((x1, y1), (x2, y2)) = abs (x1 - x2) * abs (y1 - y2)

--A função a seguir supõe que os rectângulos não se sobrepôem.
areaTotal :: [Rectangulo] -> Float
areaTotal xs = sum $ map area xs

--10
p' :: Int -> Bool
p' 0 = True 
p' 1 = False
p' x | x > 1 = p (x-2)

--p' 5 = p' 3 = p' 1 = False

--b

fora :: Ponto -> Circulo -> Bool
fora p (c, r) = distP p c > r

--ii
filtra' :: Circulo  -> [Ponto] -> Int
filtra' c xs = length $ filter (\p -> fora p c) xs

--11
--a
mult :: Int -> Int -> Int -> Bool
mult n a b = eMultiplo n a && eMultiplo n b

--b
fun''' :: [Int] -> [Int]
fun''' [] = []
fun''' (h:t) = if (mod h 2) == 0 then h : (fun''' t)
           		                 else (fun''' t)

{-
fun [8, 5, 12, 7] = 8 : fun [5, 12, 7] = 8 : fun [12, 7] =
8 : 12 : fun [7] = 8 : 12 : fun [] = 8 : 12 : [] = 8 : [12] =
[8, 12]
-}

minusculas :: [Char] -> Int
minusculas xs = length $ filter isLower xs

--12
--a

nome' :: String -> Bool
nome' = (isUpper.head)

--b
golosEquipa :: Jogo -> String -> Int
golosEquipa (s1, g1, s2, g2) equipa
	|s1 == equipa = g1
	|s2 == equipa = g2
	|otherwise = -1

golos :: [Jogo] -> String -> Int
golos xs equipa = sum $ map (\j -> golosEquipa j equipa) xs

--13  

roda :: Rectangulo -> Rectangulo
roda ((x1, y1), (x2, y2)) = ((x1, y1), (x1 + (y2 - y1), y1 + (x2 - x1)))

rodaTudo :: [Rectangulo] -> [Rectangulo]
rodaTudo = map roda 

--14
--a

maior :: Int -> Int -> Int -> Bool
maior a b c = a > (b + c) || b > (a + c) || c > (a + b)

--b
resJogo' :: Jogo -> String
resJogo' (_, g1, _, g2)
	|g1 > g2   = "Ganhou a equipa da casa"
	|g1 < g2   = "Ganhou a equipa visitante"
	|otherwise = "Foi empate" --caso seja empate.

--c
empates :: [Jogo] -> Int
empates xs = length $ filter (\j -> resJogo' j =="Foi empate") xs
