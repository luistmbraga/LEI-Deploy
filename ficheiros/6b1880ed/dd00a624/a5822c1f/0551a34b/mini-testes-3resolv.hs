--1

type RegAlcool = [(Nome,Sexo,Idade,NA)]
type Nome = String
type Sexo = Char -- 'M' ou 'F'
type Idade = Int
type NA = Float  --Nivel de Alcool

--a

menores21 :: RegAlcool -> RegAlcool
menores21 = filter (\(_, _, i, _) -> i <= 21)

--b

multa :: RegAlcool -> [(Nome, Idade, Float)]
multa xs = map (\(n, _, i, na) -> (n, i, if na > 0.5 then 100 * na else 0)) xs

--c

mediaIdade :: RegAlcool -> Float 
mediaIdade xs = fromIntegral (sum (map (\(_, _, i, _) -> i) xs)) / fromIntegral (length xs)

--2

--a

func :: Eq a => a -> [a] -> Bool
func _ [] = False
func x (y:ys) = x == y || func x ys

--b

type Matriz a = [[a]]

zero :: (Eq a, Num a) => Matriz a -> Bool
zero xs = and $ map (all (==0)) xs

--3

type Polinomio = [Monomio]
type Monomio = (Float, Int)

--a

conta :: Int -> Polinomio -> Int
conta n p = length $ filter (==n) (map snd p)

--b

selgrau :: Int -> Polinomio -> Polinomio
selgrau n p = filter ((>n).snd) p

--c

deriv :: Polinomio -> Polinomio
deriv p = map (\(c, e) -> (c*(fromIntegral e), e - 1)) p
--No teste pode-se tirar "(fromIntegral e)" e substituir por "e" apenas. O fromIntegral é utilizado porque sendo c um float e e um inteiro, a multiplicação irá dar um erro. Para isso convertemos o e primeiro para float.

--4

type Radar     = [(Hora, Matricula, VelAutor, VelCond)]
type Hora      = (Int, Int) 
type Matricula = String
type VelAutor  = Float  --Utilizamos Float, para não andar com conversões de tipo.
type VelCond   = Float

--a

radarCorrecto :: Radar -> Bool
radarCorrecto xs = null (filter (\(_, _, va, vc) -> vc < va) xs)

--b

resumoDiario :: Radar -> [(Matricula, Float)]
resumoDiario xs = map (\(_, m, va, vc) -> (m, vc - va)) xs

--c

totalExcessoV :: [(Matricula, Int)] -> Int
totalExcessoV xs = sum $ map snd xs

--5

--a

func' :: [[a]] -> [Int]
func' [] = []
func' ([]:xs) = 0 : func' xs
func' (_ :xs) =     func' xs

--b

type MSet a = [(a, Int)]

elem' :: Eq a => a -> MSet a -> Bool
elem' e xs = any (==e) (map fst xs)

--6

--a

criaPares :: a -> [b] -> [(a, b)]
criaPares _ [] = []
criaPares x (y:ys) = (x, y) : criaPares x ys

criaPares' :: a -> [b] -> [(a, b)]
criaPares' a bs = map (acrescenta a) bs
    where acrescenta :: a -> b -> (a, b)
          acrescenta a x = (a, x)

--b

concat' :: [[a]] -> [a]
concat' = foldl (++) []

--7

--a

calcula :: Float -> Polinomio -> Float
calcula v xs = sum $ map (\(c, e) -> c * v^e) xs

--b

simp :: Polinomio -> Polinomio
simp = filter ((/=0).fst)

--c

mult :: Monomio -> Polinomio -> Polinomio
mult (c, e) p = map (\(c1, e1) -> (c * c1, e + e1)) p

--8

--a

mulheres :: RegAlcool -> RegAlcool
mulheres = filter (\(_, s, _, _) -> s == 'F') 

--b

conducao :: RegAlcool -> [(Nome, String)]
conducao = map (\(n, _, _, na) -> (n, if na > 0.5 then "ilegal" else "legal"))

--c

valorMultas :: RegAlcool -> Float
valorMultas xs = sum $ map (\(_, _, _, na) -> if na > 0.5 then na * 100 else 0)xs

--9

--a

func'' :: (Eq a) => [a] -> [a] -> Bool
func'' [] [] = True
func'' [] _  = False
func'' _ []  = False
func'' (x:xs) (y:ys) = x == y && func'' xs ys

--b

quadrada :: Matriz a -> Bool
quadrada xs = all (==length xs) (map length xs)

--10

--a

tolerancia :: Radar -> Radar
tolerancia = filter (\(_, _, va, vc) -> vc > (1.1*va))

--b

infracoes :: Matricula -> Radar -> Radar
infracoes matricula = filter (\(_, m, _, _) -> m == matricula) 

--c

excessoAcumulado :: Radar -> Float
excessoAcumulado xs = sum $ map (\(_, _, va, vc) -> vc - va) xs

--11

type Jornada = [Jogo]
type Jogo = ((Equipa, Golos), (Equipa, Golos)) --Primeira equipa joga em casa
type Equipa = String
type Golos = Int

--a

totalGolos :: Jornada -> Int
totalGolos xs = sum $ (map (\((_, g1), (_, g2)) -> g1 + g2) xs)

--b

numGolos :: Int -> Jornada -> [Jogo]
numGolos x xs = filter (\((_, g1), (_, g2)) -> (g1 + g2) > x) xs

--c

vc :: Jogo -> Bool
vc ((_, g1), (_, g2)) = g1 > g2

casa :: Jogo -> Equipa
casa ((e, _), (_, _)) = e

--12

--a

criaLinhas :: [a] -> [b] -> [[(a, b)]]
criaLinhas [] _ = []
criaLinhas _ [] = []
criaLinhas (x:xs) ys = zip (repeat x) ys : criaLinhas xs ys

crialinhas :: [a] -> [b] -> [[(a, b)]]
crialinhas l1 l2 = map (f l2) l1
    where f :: [b] -> a -> [(a, b)]
          f l x = zip (repeat x) l

--b

-- concat' :: [[a]] -> [a]
-- concat' = foldl (++) []

--definida na 6b)

--13

--a

func''' :: Ord a => a -> [a] -> Int
func''' _ [] = 0
func''' x (y:ys) = if y >= x then 1 + func''' x ys
                             else     func''' x ys

--b

size :: MSet a -> Int
size xs = sum $ map snd xs

--14

--a

pontos :: Jornada -> [(Equipa, Int)]
pontos xs = concat $ map pontosJogo xs
    where pontosJogo :: Jogo -> [(Equipa, Int)]
          pontosJogo ((e1, g1), (e2, g2))
              | g1 > g2   = [(e1, 3), (e2, 0)]
              | g1 < g2   = [(e2, 3), (e1, 0)]
              | otherwise = [(e1, 1), (e2, 1)]

--b

empates :: Jornada -> [Jogo]
empates = filter (\((_, g1), (_, g2)) -> g1 == g2)  

--c

golosMarcados :: Jornada -> Int
golosMarcados j = sum (map soma j)
    where soma :: Jogo -> Int
          soma ((_, g1), (_, g2)) = g1 + g2
