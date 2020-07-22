module Examelesi2 where

--I

class FigFechada a where
  area :: a -> Float
  perimetro :: a -> Float

--1

fun :: (FigFechada a) => [a] -> [a] 
fun figs = filter (\fig -> (area fig) > 100) figs

--2

type Ponto = (Float,Float)
type Lado = Float
data Rectangulo = PP Ponto Ponto
                | PLL Ponto Lado Lado

instance FigFechada Rectangulo where
 area (PLL ponto lado1 lado2) = (lado1)*(lado2)
 area (PP ponto1 ponto2) = ((snd ponto2)-(snd ponto1))*((fst ponto2)-(fst ponto1))
 perimetro (PLL ponto lado1 lado2) = (2*lado1)+(2*lado2)
 perimetro (PP ponto1 ponto2) = (2*((snd ponto2)-(snd ponto1)))+(2*((fst ponto2)-(fst ponto1)))

--3

somaAreas :: [Rectangulo] -> Float
somaAreas x = sum (map area x)

--II

--1

data BTree a = Vazia | Nodo a (BTree a) (BTree a)
   deriving Show

inorder Vazia = []
inorder (Nodo r e d) = (inorder e) ++ (r:(inorder d))

teste :: BTree a -> [a]
teste x = inorder x

--2

menor (Nodo r Vazia _) = r
menor (Nodo _ e _) = menor e

par (Nodo r Vazia d) = (menor (Nodo r Vazia d),Vazia)
par (Nodo r e d) = (menor (Nodo r e d),Nodo r Vazia d) 

--3

remove x Vazia = Vazia
remove x (Nodo r e d) | x==r = e
		      | otherwise = (Nodo (menor d) e (remove x d))  

--III

--1

type Concorrentes = [(Int, String)] -- numero e nome
type Prova = [(Int, Int)] -- num concorente e posicao

junta :: Prova -> Concorrentes -> [(Int,String,Int)]
junta ((x,y):xs) ((a,b):t) = if x==a then ((x,b,y):junta xs t) else junta xs t


--2 junta :: [a] -> [a] -> [a]

--3

--geraConcorrentes :: String -> Concorrentes
--geraProva :: String -> Prova

--lista :: String -> String -> IO (Int,String)
--lista a b = do { return (sort (junta (geraProva b) (geraConcorrentes a)))

--sort :: [a] -> [a]
sort [] = []
sort (h:t) = let x = sort t 
             in insere h x

--insere :: a -> [a] -> [a]
insere x [] = [x]
insere x (y:ys) | x<y = (x:y:ys)
		| otherwise = (y:(insere x ys))


{--programa :: String -> String -> IO (Int,String)
programa = do { putStr "Nome da Prova: "; np <- getLine
	      ; putStr "Nome do Concorrente: "; nc <- getLine
	      ; return (lista np nc)
 	      } 
--}





















