module Exame0607 where

--Inverte

inverte :: [a] -> [a]
inverte [] = []
inverte (x:xs) = (inverte xs)++[x]

par :: [a] -> (a,a)
par x = (parA x, parA (inverte x))

parA :: [a] -> a
parA (x:xs) = x


--Exercicio 2

separapar :: [(a,a)] -> ([a],[a])
separapar x = (primeiro x,segundo x)


primeiro :: [(a,a)] -> [a]
primeiro [] = []
primeiro (x:xs) = (fst x:(primeiro xs))

segundo :: [(a,a)] -> [a]
segundo [] = []
segundo (x:xs) = (snd x:(segundo xs))


--Exercicio 3

data Btree a = Empty
	     | Node a (Btree a) (Btree a)

altura :: Btree a -> Int
altura Empty = 0
altura (Node x Empty Empty) = 1
altura (Node x e Empty) = 1+altura e
altura (Node x Empty d) = 1+altura d
altura (Node x e d) = if (1+altura e)<=(1+altura d)
		    then 1+altura d
		    else 1+altura e

--Exercicio 4

data Fraccao = Frac Integer Integer
 deriving(Show, Eq)

prodFrac :: [Fraccao] -> Fraccao
prodFrac x = ac (Frac 1 1) x

ac :: Fraccao -> [Fraccao] -> Fraccao
ac x [] = x
ac x (y:ys) = let (Frac a b) = x
	          (Frac c d) = y
	      in ac (Frac (a*c) (b*d)) ys

par1 :: Int -> Bool
par1 n = ((mod n 2)==0)

--Exercicio 5
type ListaCompras = [(Produto,Quantidade)]
type Produto = (Nome,PrecoKg)
type Nome = String
type PrecoKg = Float
type Quantidade = Float

precoItens :: ListaCompras -> [(Nome,Float)]
precoItens [] = []
precoItens (x:xs) = let ((a,b),c) = x
		    in precoAux ((a,b),c):map precoAux xs

precoAux :: (Produto,Quantidade) -> (Nome, Float)
precoAux ((a,b),c) = (a,(b*c))

produtosCaros :: ListaCompras -> PrecoKg -> ListaCompras
produtosCaros lista limite = filter (ecaro limite) lista

ecaro :: Float -> ((Nome, PrecoKg),Quantidade) -> Bool
ecaro w ((x,y),z) | w<=y = True
	 	  | otherwise = False
