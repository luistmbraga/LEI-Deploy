module Teste09 where
	
--ParteI
--1
posImpares :: [a] -> [a]
posImpares [] = []
posImpares [x] = [x]
posImpares (x:y:xys) = x:(posImpares xys)

--2
repetidos :: Eq a => [a] -> Bool
repetidos [] = False
repetidos (x:xs) = (elem x xs) || repetidos xs

--3
data Tree a = Empty | Node a (Tree a) (Tree a)

somaNum :: Int -> Tree Int -> Tree Int
somaNum _ Empty = Empty
somaNum n (Node r e d) = Node (r+n) (somaNum n e) (somaNum n d)

--4
multip :: Int -> [(Int,Int,Int)] -> [(Int,Int,Int)]
multip _ [] = []
multip n  ((x,y,z):xyz) | (multiAux n (x,y,z) == True) = (x,y,z):(multip n xyz) 
								| otherwise = (multip n xyz)
								
	
multiAux :: Int -> (Int,Int,Int) -> Bool
multiAux n (x,y,z) = mod (x+y+z) n == 0

--5
type TabAbrev = [(Abreviatura,Palavra)]
type Abreviatura = String
type Palavra = String

--a
daPal :: TabAbrev -> Abreviatura -> Maybe Palavra
daPal [] s = Nothing
daPal ((a,p):ta) s | (a==s) = (Just p)
 						 | otherwise = daPal ta s

--b
transforma :: TabAbrev -> String -> String
transforma t s = unwords (trata t (words s))

trata :: TabAbrev -> [String]-> [String]
trata t [] = []
trata t (s:xs) | (daPal t s) == Nothing = s:trata t xs
					| otherwise = tiraJust (daPal t s) : trata t xs
					
tiraJust :: Maybe Palavra -> Palavra
tiraJust (Just x) = x

--ParteII
--1
participou :: String -> [(String,Int)]
participou [] = []
participou l = let linhas = lines l;
						 falunos = filtrAlunos linhas;
						 listaNum = transformaNUM falunos;
						 listaOrd = isort listaNum
					in lPresencas listaOrd

filtrAlunos :: [String] -> [String]
filtrAlunos [] = []
filtrAlunos (x:xs) | (head x) /= '-' = x:filtrAlunos xs
						  | otherwise = filtrAlunos xs

transformaNUM :: [String] -> [Int]
transformaNUM [] = []
transformaNUM (x:xs) = (read x) : transformaNUM xs

isort [] = []
isort (h:t) = insert h (isort t)
			 where insert x [] = [x] ;
				   insert x (y:ys) = if x < h then x:y:ys else y:(insert x ys)

lPresencas :: [Int] -> [(String,Int)]
lPresencas [] = []
lPresencas (h:t) = (show h,1+length x) : lPresencas y
					where (x,y) = span (==h) t

--2
data AG = Pessoa Nome Pai Mae
        | Desconhecida
    deriving Show

type Pai = AG
type Mae = AG
type Nome = String

--a
nomesMF :: AG -> ([Nome],[Nome])
nomesMF Desconhecida = ([],[])
nomesMF (Pessoa n p m) = let (x,y) = nomesP p;
									  (x1,y1) = nomesM m;
