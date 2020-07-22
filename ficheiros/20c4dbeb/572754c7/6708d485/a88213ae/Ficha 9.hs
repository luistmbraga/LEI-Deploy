
-- Pergunta 1:
data Frac = F Integer Integer

-- Alínea a)
normaliza :: Frac -> Frac
normaliza (F n d) | n>=0 && d>0 = F (n 'div' (mdc n d)) (d 'div' (mdc n d))
		  | n<0 && d>0 = let x=mdc (-n) d
				 in F (n 'div' x) (d 'div' x)
		  | n>=0 && d<0 = let x=mdc n (-d)
				  in F (-(n 'div' x)) ((-d) 'div' x)
		  | n<0 && d<0 = let x=mdc (-n) (-d)
				 in F ((-n) 'div' x) ((-d) 'div' x)

mdc :: Integer -> Integer -> Integer
mdc x y | x==y = x
	| x>y  = mdc (x-y) y
	| x<y  = mdc x (y-x)

-- Alínea b)
instance Eq Frac where
	f1==f2 = let (F a b)   = normaliza f1
		     (F a' b') = normaliza f2
		 in a==a' && b==b'

-- Alínea c)
instance Ord Frac where
	f1<=f2 = let (F a b)   = normaliza f1
		     (F a' b') = normaliza f2
		 in a*b'<=a'*b

-- Alínea d)
instance Show Frac where
	Show (F a b) = "(" ++ (Show a) ++ "/" ++ (Show b) ++ ")"

-- Alínea e)
instance Num frac where
	(F a b)+(F a' b') = F (a*b'+a'*b) (b*b')
	(F a b)*(F a' b') = F (a*a') (b*b')
	negate (F a b) = F (-a) b
	abs (F a b) | (a>0 && b>0) || (a<0 && b<0) = F a b
		    | otherwise = F (-a) b
	signum (F a b) | (a>0 && b>0)) || (a<0 && b<0) = F 1 1
		       | a==0 && b/=0 = F 0 1
		       | b==0 = enum "..."
		       | otherwise = F (-1) 1
	fromInteger n = F n 1

-- Alínea f)
maiorDobro :: Frac -> [Frac] -> [Frac]
maiorDobro f l = filter (>(2*f)) l

-- ou:
-- maiorDobro :: Frac -> [Frac] -> [Frac]
-- maiorDobro f l = (\f' -> f'>2*f)

-- Pergunta 2:
data ExpInt = Const Int
	| Simetrico ExpInt
	| Mais ExpInt ExpInt
	| Menos ExpInt ExpInt
	| Mult ExpInt ExpInt

-- Alínea a)
calcula :: ExpInt -> Int

-- Alínea b)

-- Alínea c)
posfix :: ExpInt -> String

-- Alínea d)

-- Alínea e)

-- Pergunta 3:
data ExpN = N [Parcela]
type Parcela = [Int]

-- Alínea a)
calcN :: ExpN -> Int

-- Alínea b)
normaliza2 :: ExpInt -> ExpN

-- Alínea c)

-- Pergunta 4:
data Data = D Dia Mes Ano
data Movimento = Credito Float | Debito Float
data Extracto = Ext Float [(Data,String,Movimento)]

-- Alínea a)

-- Alínea b)

-- Alínea c)
ordena :: Extracto -> Extracto

-- Alínea d)

-- Alínea e)
dmaxDebito :: Extracto -> Maybe (Data,Float)
dmaxDebito ((_,Debito,d,m):t) = maxdeb (d,m) (dmaxDebito t)
dmaxDebito (h:t) = dmaxDebito t
dmaxDebito [] = Nothing

maxdeb ::

-- Pergunta 5:
data Exp a = Const a
	   | Simetrico (Exp a)
	   | Mais (Exp a) (Exp a)
	   | Menos (Exp a) (Exp a)
	   | Mult (Exp a) (Exp a)

instance (Num a) => Num (Exp a) where


