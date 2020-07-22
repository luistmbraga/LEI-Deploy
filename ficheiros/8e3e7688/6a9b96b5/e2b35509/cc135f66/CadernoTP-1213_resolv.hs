import Data.Char
import Data.Function
import Data.List

--1

perimetro :: Float -> Float
perimetro r = 2 * pi * r

dist :: (Float, Float) -> (Float, Float) -> Float
dist (x1, y1) (x2, y2) = sqrt( (x2 - x1)^2 + (y2 - y1)^2 )

primUlt :: [a] -> [a]
primUlt xs = [head xs, last xs]

multiplo :: Int -> Int -> Bool
multiplo m n = mod m n == 0 --Na comparação usa-se ==

truncaImpar :: [a] -> [a]
truncaImpar xs = if multiplo (length xs) 2 then xs
                                           else tail xs
--se for par(multiplo de 2) devolve a lista, se não devolve a cauda

max2 :: Int -> Int -> Int
max2 x y = if x >= y then x else y

max3 :: Int -> Int -> Int -> Int
max3 x y z = max x (max y z)

--2

desiTriangular :: Float -> Float -> Float -> Bool
desiTriangular a b c = (a + b) > c && (b + c) > a && (c + a) > b

--3

type Ponto = (Float, Float) --Ponto é agora sinónimo de um par de floats.
--a
comprimentosLadosTriang :: Ponto -> Ponto -> Ponto -> (Float, Float, Float)
comprimentosLadosTriang p1 p2 p3 = (dist p1 p2, dist p2 p3, dist p3 p1)

--b
perimetroTriang :: Ponto -> Ponto -> Ponto -> Float
perimetroTriang p1 p2 p3 = dist p1 p2 + dist p2 p3 + dist p3 p1

--c
receberVertices :: Ponto -> Ponto -> [Ponto]
receberVertices (x1, y1) (x2, y2) = [(x1, y1), (x2, y1), (x2, y2), (x1, y2)]

--4
nRaizes :: Float -> Float -> Float -> Int
nRaizes a b c = if b^2 - 4*a*c > 0 then 2
                                   else if b^2 - 4*a*c < 0 then 0
                                                           else 1

--5
raizesQuadraticas :: Float -> Float -> Float -> [Float]
raizesQuadraticas a b c = if nRaizes a b c == 0 then []
                                                else if nRaizes a b c == 1 then [-b / (2 * a)]
                                                                           else [(-b + sqrt(b^2 - 4 * a * c)) / (2 * a), (-b - sqrt(b^2 - 4 * a * c)) / (2 * a)]

--6
nRaizes' :: (Float, Float, Float) -> Int
nRaizes' (a, b, c) = if b^2 - 4*a*c > 0 then 2
                                   else if b^2 - 4*a*c < 0 then 0
                                                           else 1

raizesQuadraticas' :: (Float, Float, Float) -> [Float]
raizesQuadraticas' (a, b, c) = if nRaizes a b c == 0 then []
                                                else if nRaizes a b c == 1 then [-b / (2 * a)]
                                                                           else [(-b + sqrt(b^2 - 4 * a * c)) / (2 * a), (-b - sqrt(b^2 - 4 * a * c)) / (2 * a)]

--7
--a
isLower' :: Char -> Bool
isLower' c = ord c >= ord 'a' && ord c <= ord 'z'

--b
isDigit' :: Char -> Bool
isDigit' c = ord c >= ord '0' && ord c <= ord '9'

--c Esta função é para ver se o argumento é uma letra. Maiúscula ou minúscula.
isUpper' :: Char -> Bool --Vamos primeiro fazer uma função que verifica se é maiuscula para facilitar isAlpha
isUpper' c = ord c >= ord 'A' && ord c <= ord 'Z'


isAlpha' :: Char -> Bool -- || significa 'ou'.
isAlpha' c = isUpper' c || isLower' c

--d
toUpper' :: Char -> Char
toUpper' c = chr(ord c - (ord 'a' - ord 'A'))

--e
intToDigit' :: Int -> Char
intToDigit' i = chr(i + ord '0')

--f
digitToInt' :: Char -> Int
digitToInt' d = ord d - ord '0'

--8

type Hora = (Int, Int)

--a
horaValida :: Hora -> Bool
horaValida (h, m) = h >= 0 && h < 24 && m >= 0 && m < 60

--b
horaConsequente :: Hora -> Hora -> Bool
horaConsequente (h1, m1) (h2, m2) = h1 > h2 || (h1 == h2 && m1 > m2)

--c
horaParaMinutos :: Hora -> Int
horaParaMinutos (h, m) = h * 60 + m

--d
minutosParaHoras :: Int -> Hora
minutosParaHoras m = (div m 60, mod m 60) :: Hora


--e
deltaHoras :: Hora -> Hora -> Int
deltaHoras h1 h2 = abs(horaParaMinutos h1 - horaParaMinutos h2)

--f
adicionarMinutos :: Hora -> Int -> Hora
adicionarMinutos h m = minutosParaHoras(horaParaMinutos h + m)

--9
opp :: (Int, (Int, Int)) -> Int
opp (1, (x, y)) = x + y
opp (2, (x, y)) = x - y
opp (z, (x, y)) = 0

--10
--a
dobros :: [Float] -> [Float]
dobros [] = []
dobros (x:xs) = 2 * x : dobros xs

--b
ocorre :: Char -> String -> Int
ocorre x "" = 0
ocorre x (c:cs) = if x == c then 1 + ocorre x cs else ocorre x cs

--c
pmaior :: Int -> [Int] -> Int
pmaior x [] = x
pmaior a (x:xs) = if x > a then x else pmaior a xs

--d Fazemos uma função auxiliar, para nos facilitar a escrita desta função
existe :: Int -> [Int] -> Bool
existe a [] = False
existe a (x:xs) = if a == x then True else existe a xs

repetidos :: [Int] -> Bool
repetidos [] = False
repetidos (x:xs) = if existe x xs then True else repetidos xs

--e
nums :: String -> [Int]
nums "" = []
nums (c:cs) = if isDigit c then digitToInt c : nums cs else nums cs

--f
tresUlt :: [a] -> [a]
tresUlt [] = []
tresUlt [a] = [a]
tresUlt [a, b] = [a, b]
tresUlt [a, b, c] = [a, b, c]
tresUlt (x:xs) = tresUlt (tail xs)

--g
posImpares :: [a] -> [a]
posImpares [] = []
posImpares [a] = [a]
posImpares (x:xs) = x : posImpares(tail xs)

--h

ordena :: [Int] -> [Int]
ordena [] = []  
ordena (x:xs) =   
    let menoresQueX = ordena [a | a <- xs, a <= x]  
        maioresQueX = ordena [a | a <- xs, a > x]  
    in  menoresQueX ++ [x] ++ maioresQueX 

--a
(><) :: Int -> Int -> Int
(><) x 0 = 0
(><) x y = x + (><) x (y - 1) 

--b

div' :: Int -> Int -> Int
div' m n
    | m < n = 0
    | m >= n = 1 + div' (m - n) n

mod' :: Int -> Int -> Int
mod' m n = m - (n * div' m n)

--c

power :: Int -> Int -> Int 
power x 0 = 1
power x n = x * power x (n - 1)

--d
uns :: Int -> Int
uns 0 = 0
uns 1 = 1
uns n
    |odd n = 1 + uns (div n 2)
    |even n = uns (div n 2)


--e

primo :: Int -> Bool
primo n = ePrimo n (n - 1)

ePrimo :: Int -> Int -> Bool
ePrimo n 1 = True
ePrimo n x = mod n x /= 0 && ePrimo n (x - 1)

--12

--a
primeiros :: [(a, b)] -> [a]
primeiros [] = []
primeiros ((a, b):xs) = a : primeiros xs

--b
nosPrimeiros :: (Eq a) => a -> [(a, b)] -> Bool
nosPrimeiros e [] = False
nosPrimeiros e ((a, b):xs) = e == a || nosPrimeiros e xs

--c
minFst :: (Ord a) => [(a, b)] -> a
minFst [(a, b)] = a 
minFst ((a, b):xs) = min a (minFst xs)

--d
sndMinFst :: (Ord a) => [(a, b)] -> b
sndMinFst xs = snd (sndMinFstAssist xs)

sndMinFstAssist :: (Ord a) => [(a, b)] -> (a, b)
sndMinFstAssist [x] = x
sndMinFstAssist (t@(a, b):xs) = if min a (fst minXs) == a then (a, b)
                                                          else minXs
    where minXs = sndMinFstAssist xs

--13
type Aluno = (Numero, Nome, ParteI, ParteII)
type Numero = Int
type Nome = String
type ParteI = Float
type ParteII = Float
type Turma = [Aluno]

--a
notasValidas :: [Aluno] -> Bool
notasValidas [] = True
notasValidas ((_, _, n1, n2):xs) = (n1 >= 0 && n1 <= 12 && n2 >= 0 && n2 <= 8) && notasValidas xs

numeroAlunos :: [Aluno] -> [Int]
numeroAlunos [] = []
numeroAlunos ((n, _, _, _):xs) = n : numeroAlunos xs

numerosUnicos :: [Aluno] -> Bool
numerosUnicos xs = not (repetidos (numeroAlunos xs))

turmaValida :: [Aluno] -> Bool
turmaValida xs = notasValidas xs && numerosUnicos xs

--b
notaFinal :: Aluno -> Float
notaFinal (_, _, n1, n2) = n1 + n2

alunoAprovado :: Aluno -> Bool
alunoAprovado (_, _, n1, n2) = n1 >= 8 && (n1 + n2) >= 9.5

alunosAprovados :: [Aluno] -> [Aluno]
alunosAprovados [] = []
alunosAprovados (aluno:alunos) = if alunoAprovado aluno then aluno : alunosAprovados alunos
                                                        else alunosAprovados alunos

--c
notasFinais :: [Aluno] -> [Float]
notasFinais [] = []
notasFinais (aluno:alunos) = if alunoAprovado aluno then notaFinal aluno : notasFinais alunos
                                                    else notasFinais alunos

--d
mediaTurma :: [Aluno] -> Float
mediaTurma alunos = sum (notasFinais alunos) / fromIntegral (length alunos)

--e
notaMaxima :: [Aluno] -> Float
notaMaxima alunos = maximum (notasFinais alunos)

nomeDeAluno :: Aluno -> String
nomeDeAluno (_, nome, _, _) = nome

notaMaisAlta :: [Aluno] -> String
notaMaisAlta turma@(aluno:alunos) = if notaFinal aluno == notaMaxima turma then nomeDeAluno aluno
                                                                           else notaMaisAlta alunos

--14
type Etapa = (Hora, Hora)
type Viagem = [Etapa]

--a

etapaValida :: Etapa -> Bool
etapaValida (h1, h2) = horaValida h1 && horaValida h2 && horaConsequente h2 h1

--b

viagemValida :: Viagem -> Bool
viagemValida [] = True
viagemValida (x@(h1, h2):y@(h3, h4):xs) = etapaValida x && horaConsequente h3 h2 && viagemValida (y:xs)

--c

horasPartidaChegada :: Viagem -> (Hora, Hora)
horasPartidaChegada xs = (fst (head xs), snd (last xs))

--d

tempoViagemEfectiva :: Viagem -> Int
tempoViagemEfectiva [] = 0
tempoViagemEfectiva (x:xs) = deltaHoras (fst x) (snd x) + tempoViagemEfectiva xs 

--e

tempoDeEspera :: Viagem -> Int
tempoDeEspera [] = 0
tempoDeEspera (x@(h1, h2):y@(h3, h4):xs) = deltaHoras h2 h3 + tempoDeEspera (y:xs) 

--f

tempoTotalViagem :: Viagem -> Int
tempoTotalViagem xs = let horas = horasPartidaChegada xs
                      in deltaHoras (fst horas) (snd horas)

--15

type Rectangulo = (Ponto, Float, Float)
type Triangulo = (Ponto, Ponto, Ponto)
type Poligonal = [Ponto]

distancia :: Ponto -> Ponto -> Float
distancia (a,b) (c,d) = sqrt (((c-a)^2) + ((b-d)^2))
--16

type Stock = [(Producto,Preco,Quantidade)]
type Producto = String
type Preco = Float
type Quantidade = Float

--i

quantos :: Stock -> Int
quantos [] = 0
quantos ((a, b, c):xs) = 1 + quantos xs

--ii

emStock :: Producto -> Stock -> Quantidade
emStock p [] = 0
emStock p1 ((p2, d, q):xs) = if p1 == p2 then q
                                         else emStock p1 xs
--iii
consulta :: Producto -> Stock -> (Preco, Quantidade)
consulta p1 [] = (0, 0)
consulta p1 ((p2, d, q):xs) = if p1 == p2 then (d, q)
                                          else consulta p1 xs

--iv
tabPrecos :: Stock -> [(Producto, Preco)]
tabPrecos [] = []
tabPrecos ((p, d, q):xs) = (p, q) : tabPrecos xs

--v
valorTotal :: Stock -> Float
valorTotal [] = 0
valorTotal ((p, d, q):xs) = d*q + valorTotal xs

--vi
inflacao :: Float -> Stock -> Stock 
inflacao x [] = []
inflacao x ((p, d, q):xs) = (p, d + d*x, q) : inflacao x xs 

--vii
omaisBarato :: Stock -> (Producto, Preco)
omaisBarato st@((p, d, q):xs) = if maisBaratoDoStock p st then (p, d)
                                                          else omaisBarato xs
maisBaratoDoStock :: Producto -> Stock -> Bool
maisBaratoDoStock p1 [] = True
maisBaratoDoStock p1 st@((p2, d, q):xs) = fst (consulta p1 st) <= d && maisBaratoDoStock p1 xs

--viii
maisCaros :: Preco -> Stock -> [Producto]
maisCaros d1 [] = []
maisCaros d1 (st@(p, d2, d):xs) = if d2 > d1 then p : maisCaros d xs 
                                             else maisCaros d xs
--b

type ListaCompras = [(Producto, Quantidade)]

--i
verifLista :: ListaCompras -> Stock -> Bool
verifLista [] s = True
verifLista ((p, q):xs) st = emStock p st >= q && verifLista xs st

--ii
falhas :: ListaCompras -> Stock -> ListaCompras
falhas [] s = []
falhas (pq@(p, q):xs) st = if emStock p st >= q then falhas xs st
                                                else pq : falhas xs st
--iii
custoTotal :: ListaCompras -> Stock -> Float
custoTotal [] st = 0
custoTotal ((p, q):xs) st = fst (consulta p st) + custoTotal xs st

--iv
productosMaisBaratos :: Preco -> ListaCompras -> Stock -> ListaCompras
productosMaisBaratos d (pq@(p, q):xs) st = if d > fst (consulta p st) then pq : productosMaisBaratos d xs st 
                                                                      else productosMaisBaratos d xs st

productosMaisCaros :: Preco -> ListaCompras -> Stock -> ListaCompras
productosMaisCaros d (pq@(p, q):xs) st = if d <= fst (consulta p st) then pq : productosMaisCaros d xs st 
                                                                     else productosMaisCaros d xs st


partePreco :: Preco -> ListaCompras -> Stock -> (ListaCompras, ListaCompras)
partePreco d lc st = (productosMaisBaratos d lc st, productosMaisCaros d lc st)

--17
divMod' :: Int -> Int -> (Int, Int)
divMod' m n = (div' m n, mod' m n)

--18

nzpWithCounter :: [Int] -> (Int, Int, Int) -> (Int, Int, Int)
nzpWithCounter [] t = t
nzpWithCounter (x:xs) (n, z, p)
    |x < 0  = nzpWithCounter xs (n + 1, z, p)
    |x == 0 = nzpWithCounter xs (n, z + 1, p)
    |x > 0  = nzpWithCounter xs (n, z, p + 1)

nzp :: [Int] -> (Int, Int, Int)
nzp xs = nzpWithCounter xs (0, 0, 0)

--19

semSep :: String -> (String, Int)
semSep "" = ("", 0)
semSep (c:cs) = if isSpace c then (fst restoString, 1 + snd restoString)
                             else (c : fst restoString, snd restoString)
    where restoString = semSep cs

--20

digitAlpha :: String -> (String, String)
digitAlpha "" = ("", "")
digitAlpha (c:cs) 
    |isAlpha c = (c : fst restoString, snd restoString)
    |isDigit c = (fst restoString, c : snd restoString)
    where restoString = digitAlpha cs

--21
--a

--[x | x <- [1..20], mod x 2 == 0, mod x 3 == 0]
--Isto lê-se "Todos os x de 1 a 20 que são múltiplos de 2 e de 3
--Para ser múltiplo de 2 e de 3 ao mesmo tempo tem de ser múltiplo de 6
--Ou seja, são todos os múltiplos de 6 de 1 a 20. Ou seja: [6, 12, 18]
--Se colarem a expressão na consola do ghci vão ver que está certo

--b

--[x | x <- [y | y <- [1..20], mod y 2 == 0], mod x 3 == 0]
--Isto é equivalente ao exercício anterior, mas o modo de operações é diferente
--Começa primeiro por fazer uma lista por compreensão de todos os nº de 1 a 20 que são múltiplos de 2
--Depois usa lista numa nova lista por compreensão em que todos os nº têm de ser múltiplos de 3

--c

--[(x,y) | x <- [0..20], y <- [0..20], x+y == 30]
--Todos os pares x, y (estando x e y entre 0 e 20) em que a soma destes seja igual a 30
--Por exemplo (10, 20), (15, 15)
--Se puserem no ghci este é o resultado: 
--[(10,20),(11,19),(12,18),(13,17),(14,16),(15,15),(16,14),(17,13),(18,12),(19,11),(20,10)]

--d

--[sum [y | y <- [1..x], odd y] | x <- [1..10]]
--A soma de todos os impares até x, sendo x um valor entre 1 e 10.
--Por exemplo quando x é 1, a soma de impares vai ser 1, logo o 1º valor vai ser 1
--Mas quando x é 8, a soma de impares vai ser 1+3+5+7=16
--Depois de fazer isso para todos os nº ou colocarem no ghci:
--[1,1,4,4,9,9,16,16,25,25]

--22

--a
--Podemos ver que todos os elementos da lista são expoentes de 2, logo
expDois = [2^x | x <- [0..10]]

--b
--Pares de números de 1 a 5 em que a soma seja igual a 6
somaSeis = [(x, y) | x <- [1..5], y <- [1..5], x + y == 6]

--c
--Lista de listas dos números positivos consecutivos até 1 a 5
nConsecutivos = [[y | y <- [1..x]] | x <- [1..5]]

--d
--Lista de lista de 1's em que estas vao aumentando de tamanho 1 a 1
umConsecutivos = [[1 | y <- [1..x]] | x <- [1..5]]

--e
--Factoriais consecutivos de fact 1 a fact 6
factoriaisConsecutivos = [product [y | y <- [1..x]] | x <- [1..6]]

--23
--a

zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y) : zipWith' f xs ys

takeWhile' :: (a->Bool) -> [a] -> [a]
takeWhile' f [] = []
takeWhile' f (x:xs) = if f x then x : takeWhile' f xs
                             else []

dropWhile' :: (a->Bool) -> [a] -> [a]
dropWhile' f [] = []
dropWhile' f (x:xs) = if f x then dropWhile' f xs
                             else (x:xs)
--24

agroupa :: String -> [(Char, Int)]
agroupa [] = []
agroupa l@(x:xs) = (x, length (takeWhile' (==x) l)): agroupa (dropWhile' (==x) xs) 

indicativo :: String -> [String] -> [String]
indicativo ind [] = []
indicativo ind (x:xs) = if eIndicativo ind x then x : indicativo ind xs
                                             else indicativo ind xs
    where eIndicativo :: String -> String -> Bool
          eIndicativo [] _ = True
          eIndicativo (x:xs) (y:ys) = x == y && eIndicativo xs ys

--26
toDigits :: Int -> [Int]
toDigits x = if x > 10 then mod x 10 : toDigits (div x 10) 
                       else [x]

--27
--a
fromDigits :: [Int] -> Int
fromDigits xs = sum (zipWith (*) xs (map (10^) [0..]))

--b
fromDigits' :: [Int] -> Int
fromDigits' [] = 0
fromDigits' (x:xs) = x + 10 * fromDigits' xs

--c
fromDigits'' :: [Int] -> Int
fromDigits'' xs = foldr aux 0 xs
    where aux h r = h + 10 * r

--28
--a
intStr :: Int -> String
intStr x = reverse (map intToDigit (toDigits x))

--b
strInt :: String -> Int
strInt xs = fromDigits (reverse ((map digitToInt xs)))

--29
subLists :: [a] -> [[a]]
subLists [] = [[]]
subLists (x:xs) = [x:sublist | sublist <- subLists xs] ++ subLists xs

--30
type Mat a = [[a]]

--a 

dimOK :: Mat a -> Bool
dimOK xs = allEqual (map length xs) 
    where allEqual (x:xs) = foldl (&&) True (map (==x) xs)

--b
dimMat :: Mat a -> (Int, Int)
dimMat (x:xs) = (length xs, length x)

--c
addMat :: (Num a) => Mat a -> Mat a -> Mat a
addMat [] [] = [] 
addMat (x:xs) (y:ys) = zipWith (+) x y : addMat xs ys 

--d
transpose' :: Mat a -> Mat a
transpose' [] = []
transpose' xs = map head xs : (transpose' $ map tail xs)

--e
multMat :: (Num a) => Mat a -> Mat a -> Mat a
multMat [] _ = []
multMat (x:xs) ys = map sum (map (zipWith (*) x) (transpose ys)) : multMat xs ys

--31

eratosthenesSieve :: Integral a => a -> [a]
eratosthenesSieve n = sieve [2..n] 

    where sieve :: Integral a => [a] -> [a]
          sieve [] = []
          sieve (x:xs) = x : sieve (removeMultiples x xs)
            
          removeMultiples :: Integral a => a -> [a] -> [a]
          removeMultiples x xs = filter (\y -> mod y x /= 0) xs

--32

type MSet a = [(a, Int)]

--a
add :: Ord a => a -> MSet a -> MSet a
add x [] = [(x, 1)]
add x (t@(y, v):ys)
    | x > y = t : add x ys
    | x < y = (x, 1) : t : ys
    | otherwise = (x, 1 + v) : ys

--b
toMSet :: Ord a => [a] -> MSet a
toMSet xs = foldr add [] xs

--c
moda :: MSet a -> a
moda xs = fst $ maximumBy (compare `on` snd) xs

--d


mUnion :: Ord a => MSet a -> MSet a -> MSet a
mUnion xs ys = toMSet $ unpack xs ++ unpack ys 

unpack :: Ord a => MSet a -> [a]
unpack xs = foldl1 (++) $ map (\(k, v) -> replicate v k) xs

mIntersection :: Ord a => MSet a -> MSet a -> MSet a
mIntersection xs ys = filter (\x -> not (elem x xs || elem x ys)) union
   where union = mUnion xs ys

--33

--a
factoriza :: Integer -> [Integer]
factoriza 1 = []
factoriza n = multiple : (factoriza $ div n multiple) 
    where multiple = head $ filter ((==0).(mod n)) $ eratosthenesSieve n 


--b

mdcF :: Integer -> Integer -> Integer
mdcF x y = product (map (\c -> c ^ min (count (fromIntegral c) factX) (count (fromIntegral c) factY)) coefs)
    where factX = factoriza x
          factY = factoriza y
          coefs = map fromIntegral (nub $ factX ++ factY)

mmcF :: Integer -> Integer -> Integer 
mmcF x y = product (map (\c -> c ^ max (count (fromIntegral c) factX) (count (fromIntegral c) factY)) coefs)
    where factX = factoriza x
          factY = factoriza y
          coefs = map fromIntegral (nub $ factX ++ factY)

count x = length . filter (==x)


--c
mdc :: Integer -> Integer -> Integer
mdc x y 
    | x == y = x
    | x > y  = mdc (x - y) y
    | x < y  = mdc x (y - x)

mmc :: Integer -> Integer -> Integer
mmc x y = (x * y) `div` (mdc x y)


--34

type Polinomio = [Coeficiente]
type Coeficiente = Float

--a
valor :: Polinomio -> Float -> Float
valor xs y = sum $ zipWith (*) xs $ map (y^) [0..]

--b
derivada :: Polinomio -> Polinomio
derivada (x:xs) = zipWith (*) xs [1..]

--c
addP :: Polinomio -> Polinomio -> Polinomio
addP xs ys
    | lengthDiff > 0 = zipWith (+) xs (ys ++ repeat 0)
    | otherwise      = zipWith (+) ys (xs ++ repeat 0)
    where lengthDiff = length xs - length ys

--d
multP :: Polinomio -> Polinomio -> Polinomio
multP [] ys = []
multP (x:xs) ys = addP (zipWith (*) (repeat x) ys)
                       (multP xs (0:ys))

--8
--35

type Dia  = Int
type Mes  = Int
type Ano  = Int
--type Nome = String --Já foi definida anteriormente na linha 259

data Data = D Dia Mes Ano
    deriving Show

type TabDN = [(Nome, Data)]

--a
procura :: Nome -> TabDN -> Maybe Data
procura _ [] = Nothing
procura nome ((nomeTab, aniv):xs) = if nome == nomeTab then Just aniv
                                                       else procura nome xs
--b
idade :: Data -> Nome -> TabDN -> Maybe Int
idade dataActual nome tabela = diffDatas (Just dataActual) (procura nome tabela)

diffDatas :: Maybe Data -> Maybe Data -> Maybe Int
diffDatas Nothing _ = Nothing
diffDatas _ Nothing = Nothing
diffDatas (Just (D d1 m1 a1)) (Just (D d2 m2 a2)) = Just (a1 - a2 + if (m1 > m2 || m1 == m2 && d1 >= d2) then 1 else 0)

--c

anterior :: Data -> Data -> Bool
anterior (D d1 m1 a1) (D d2 m2 a2) = a1 < a2 || a1 == a2 && m1 < m2 || a1 == a2 && m1 == m2 && a1 < a2

--d

