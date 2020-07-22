module Examelesi3 where

--I

data HORA = A Int Int Part

data Part = AM | PM
  deriving (Eq,Show)

instance Eq HORA where
 hora1 == hora2 = A 00 00 AM == A 12 00 PM
 
{--instance Enum HORA where
 fromEnum = 
 toEnum x = let d = mod x (60*24)
	        h = div d 60
		m = mod d 60
	    in A h m AM
--}

--II

type Pol = [(Float,Integer)]

{--simp :: Pol -> Pol
simp [] = []
simp ((x,y),(a,b):t) = if (y==b) then (x+a,b):simp t
			   else simp t
--}

--III

data Tabela a b = Vazia | Nodo (a,b) (Tabela a b) (Tabela a b)

--1

nova :: Tabela a b
nova = Vazia

remove :: Ord a => a -> Tabela a b -> Tabela a b
remove _ Vazia = Vazia
remove x (Nodo (c,_) e Vazia) | x == c = e
remove x (Nodo (c,_) Vazia d) | x == c = d
remove x (Nodo (c,v) e d) | x < c = Nodo (c,v) (remove x e) d
                          | x > c = Nodo (c,v) e (remove x d)
                          | x == c = let (y,z) = minTab d
                                     in Nodo (y,z) e (remove y d)

minTab :: Tabela a b -> (a,b)
minTab (Nodo (c,v) Vazia _) = (c,v)
minTab (Nodo _ e _) = minTab e

--2

procura :: (Ord a) => a -> Tabela a b -> Maybe b
procura x Vazia = Nothing
procura x (Nodo (c,v) e d) | x>c = procura x d
			   | x<c = procura x e
			   | otherwise = Just v

--3

actualiza :: (Ord a) => (a,b) -> Tabela a b -> Tabela a b
actualiza (a,b) Vazia = Vazia
actualiza (a,b) (Nodo (c,v) e d) | a>c = actualiza (a,b) d
				 | a<c = actualiza (a,b) e
				 | otherwise = Nodo (a,b) e d
















