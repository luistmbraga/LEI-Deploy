module Ficha9 where

--1
data Frac = F Integer Integer

--a
normaliza :: Frac -> Frac
normaliza (F n d) = F (div n x) (div d x)
			 where x = gcd n d
			
--b
instance Eq Frac where
	x == y = (n1 == n2 && d2 == d2)
				where F n1 d1 = normaliza x ;
						F n2 d2 = normaliza y

--c
instance Ord Frac where
	(F n1 d1) < (F n2 d2) = (n1 * d2) < (n2 * d1)

--d
instance Show Frac where
	show f = (show n) ++ "/" ++ (show d)
	 where F n d = normaliza f

--e
instance Num Frac where
	(F n1 d1) + (F n2 d2) = F (n1 * d2 + d1 * n2) (d1 * d2)
	(F n1 d1) - (F n2 d2) = F (n1 * d2 - d1 * n2) (d1 * d2)
	(F n1 d1) * (F n2 d2) = F (n1 * d2) (d1 * n2)
	abs (F n d) = F (abs n) (abs d)
	negate (F n d) = F (negate n) d
	fromInteger n = F n 1
	signum (F n d) =  F (signum n) (signum d)

--2
data ExpInt = Const Int
          	| Simetrico ExpInt
          	| Mais ExpInt ExpInt
          	| Menos ExpInt ExpInt
          	| Mult ExpInt ExpInt
		

--a
calcula :: ExpInt -> Int
calcula (Const x) = x
calcula (Simetrico x) =  - (negate (calcula x))
calcula (Mais x y) = (calcula x) + (calcula y)
calcula (Menos x y) = (calcula x) - (calcula y)
calcula (Mult x y) = (calcula x) * (calcula y)

--b
instance Show ExpInt where
	show (Const x) = (show x) ++ ""
	show (Simetrico x) = "~" ++ (show x)
	show (Mais x y) = "(" ++ (show x) ++ " + " ++ (show y) ++ ")" 
	show (Menos x y) = "(" ++ (show x) ++ " - " ++ (show y) ++ ")"
	show (Mult x y) = "(" ++ (show x) ++ " * " ++ (show y) ++ ")" 

--c
posfix :: ExpInt -> String
posfix (Const x) = (show x) ++ " "
posfix (Simetrico x) = (posfix x) ++ " +/-"
posfix (Mais x y) = (posfix x) ++ (posfix y) ++ " + " 
posfix (Menos x y) =  (posfix x) ++ (posfix y) ++ " - " 
posfix (Mult x y) = (posfix x) ++ (posfix y) ++ " * " 

--d
instance Eq ExpInt where
	x == y = (calcula x) == (calcula y)
	
--e
instance Num ExpInt where
	(+) = Mais
	(-) = Menos
	(*) = Mult
	negate = Simetrico
	abs x = Const (abs (calcula x))
	fromInteger x = Const (fromInteger x)
	signum x = Const (signum (calcula x))
	
--4
type Dia = Int
type Mes = Int
type Ano = Int

data Data = D Dia Mes Ano

data Movimento = Credito Float | Debito Float
data Extracto = Ext Float [(Data, String, Movimento)]

--a
instance Eq Data where
	(D d1 m1 a1) == (D d2 m2 a2) = (a1*100 + m1*100 + d1) == (a2*100 + m2*100 + d2)

instance Ord Data where
	(D d1 m1 a1) < (D d2 m2 a2) = (a1*100 + m1*100 + d1) < (a2*100 + m2*100 + d2)

--b
instance Show Data where
	show (D d m a) = (show a) ++ "/" ++ (show m) ++ "/" ++ (show d) 
