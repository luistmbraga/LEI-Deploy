
-- Pergunta 1:
type Dia = Int
type Mes = Int
type Ano = Int
type Nome = String

data Data = D Dia Mes Ano
   deriving Eq

type TabDN = [(Nome,Data)]

-- Alínea a)
procura :: Nome -> TabDN -> Maybe Data
procura s [] = Nothing
procura s ((n,d):t) = if s==n then (Just d)
			      else procura s t

-- Alínea b)
idade :: Data -> Nome -> TabDN -> Maybe Int
idade d n t = (case procura n t) of
	      Nothing -> Nothing
	      (Just d') -> Just (calc d d')

calc :: Data -> Data -> Int
calc (D d m a) (D d' m' a')
	|a'>=a                  = 0
	|a'<a && m<m'           = a-a'-1
	|a'<a && m>m'           = a-a'
	|a'<a && m==m' && d'<=d = a-a'
	|a'<a && m==m' && d'>d  = a-a'-1

-- Alínea c)
anterior :: Data -> Data -> Bool
anterior (D d1 m1 a1) (D d2 m2 a2) = (a1<a2) || ((a1==a2) && (m1<m2)) || ((a1==a2) && (m1==m2) && (d1>d2))

-- Alínea d)
ordena :: TabDN -> TabDN
ordena [] = []
ordena ((n,d):t) = insert (n,d)(ordena t)

insert :: (Nome,Data) -> TabDN -> TabDN
insert (n,d) [] = [(n,d)]
insert (n,d) ((n',d'):t) = if (anterior d d') then (n,d):(n',d'):t
					      else (n',d'):(insert (n,d) t)

-- ou:
-- quickOrdena :: TabDN -> TabDN
-- quickOrdena [] = []
-- quickOrdena ((n,d):t) = (quickOrdena [(n',d') | (n',d') <- t, anterior d' d] ++ [(n,d)] ++ (quickOrdena [(n',d') | (n',d') <- t, not (anterior d' d)])

-- Alínea e)
porIdade :: Data -> TabDN -> [(Nome,Int)]
porIdade d t = let l = reverse (ordena t)
	       in map f l
   where f :: (Nome,Data) -> (Nome,Int)
	 f (n',d') = (n', calc d d')

-- ou:
-- porIdade :: Data -> TabDN -> [(Nome,Int)]
-- porIdade d t = let l = reverse (ordena t)
--		  in map (\(n',d') -> (n', calc d d'))

-- Pergunta 2:
type TabAbrev = [(Abreviatura,Palavra)]
type Abreviatura = String
type Palavra = String

-- Alínea a)
daPal :: TabAbrev -> Abreviatura -> Maybe Palavra
daPal [] x = Nothing
daPal ((a,p):t) x = if a==x then (Just p)
			    else daPal t x

-- Alínea b)
transforma :: TabAbrev -> String -> String
transforma t s = unwords (trata t (words s))

-- words :: String -> [String]
-- unwords :: [String]-> String

trata :: TabAbrev -> [String] -> [String]
trata [] [] = []
trata _ [] = []
trata [] l = l
trata l (s:st) = (aux ls):(trata l st)

aux :: TabAbrev -> String -> String
aux [] a = a
aux ((x,y):t) a = if (x==a) then y
			    else aux t a

-- Pergunta 3:
data Movimento = Credito Float | Debito Float
data Extracto = Ext Float [(Data,String,Movimento)]

-- Alínea a)
extValor :: Extrato -> Float -> [Movimento]
extValor (Ext n []) _ = []
extValor (Ext n ((d,s,(Credito m)):dsm)) x | m>x = (Credito m):extValor (Ext n dsm) x
					   | otherwise = extValor (Ext n dsm) x
extValor (Ext n ((d,s,(Debito m)):dsm)) x | m>x = (Debito m):extValor (Ext n dsm) x
					  | otherwise = extValor (Ext n dsm) x

-- Alínea b)
filtro :: Extracto -> [String] -> [(Data,Movimento)]
filtro _ [] = []
filtro (Ext _ []) = []
filtro (Ext n ((d,s,m):dsm)) strings | elem s strings = (d,m):filtro (Ext n dsm) strings
				     | otherwise = filtro (Ext n dsm) strings

-- ou:
-- filtro :: Extracto -> [String] -> [(Data,Movimento)]
-- filtro (Ext _ l) l' = [(d,m) | (d,s,m) <- l, s 'elem' l']

-- Alínea c)
creDeb :: Extrato -> (Float,Float)
creDeb (Ext _ []) = (0,0)
creDeb (Ext _ ((_,_,Credito m):t) = let (a,b) = CreDeb (Ext _ t)
				    in (a+m,b)
creDeb (Ext _ ((_,_,Debito m):t) = let (a,b) = CreDeb (Ext _ t)
				   in (a,b+m)

-- ou:
-- creDeb :: Extracto -> (Float,Float)
-- creDeb (Ext _ l) = foldr aux (0,0) l
  -- where aux :: (Data,String,Movimento) -> (Float,Float) -> (Float,Float)
	-- aux (_,_,Credito x) (c,d) = (c+x,d)
	-- aux (_,_,Debito x) (c,d) = (c,d+x)

-- Alínea d)
saldo :: Extrato -> Float
saldo (Ext n []) = n
saldo (Ext n l) = let (c,d) = CreDeb (Ext n l)
		  in n+c-d

-- ou:
-- saldo :: Extracto -> Float
-- saldo (Ext n []) = n
-- saldo (Ext n l) = n+aux (CreDeb (Ext n l))

-- aux :: (Float,Float) -> Float
-- aux (a,b) = a-b

-- ou:
-- saldo :: Extacto -> Float
-- saldo (Ext n xs) = foldr aux n ys
  -- where ys = ExtValor (Ext n xs)

-- aux :: Movimento -> Float -> Float
-- aux (Credito x) n = n+x
-- aux (Debito x) n = n-x

-- ou:
-- saldo :: Extracto -> Float
-- saldo (Ext n l) = foldr aux n l
  -- where aux :: (Data,String,Movimento) -> Float -> Float
	-- aux (_,_,Credito x) s = s+x
	-- aux (_,_,Debito x) s = s-x

