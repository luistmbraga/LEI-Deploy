
-- Pergunta 1:
data BTree a = Empty
	     | Node a (BTree a) (BTree a)
	     deriving Show

-- Alínea a)
altura :: (BTree a) -> Int
altura Empty = 0
altura (Node x e d) = 1+max(altura e) (altura d)

-- Alínea b)
contaNodos :: (BTree a) -> Int
contaNodos Empty = 0
contaNodos (Node x e d) = 1+contaNodos e+contaNodos d

-- Alínea c)
folhas :: (BTree a) -> Int
folhas Empty = 0
folhas (Node x Empty Empty) = 1
folhas (Node x e d) = folhas e+folhas d

-- ou:
-- folhas :: Eq => BTree a -> Int
-- folhas Empty = 0
-- folhas (Nodo _ e d) = if e==Empty && d==Empty then 1
					      -- else folhas e+folhas d

-- Alínea d)
prune :: Int -> (BTree a) -> (BTree a)
prune x Empty = Empty
prune 0 _ = Empty
prune x (Node y e d) = let esq = prune (x-1) e
			   dir = prune (x-1) d
		       in (Node y esq dir)

-- Alínea e)
path :: [Bool] -> (BTree a) -> [a]
path (x:xs) (Node y e d) | x==True = y (if x then (path xs d) else (path xs e))
path _ _ = []

-- Alínea f)
mirror :: (BTree a) -> BTree a
mirror Empty = Empty
mirror (Node x e d) = Node x (mirror d) (mirror e)

-- Alínea g)
zipWithBT :: (a -> b -> c) -> (BTree a) -> (BTree b) -> BTree c

-- Alínea h)
unzipBT :: (BTree (a,b,c)) -> (BTree a,BTree b,BTree c)

-- Pergunta 2:
type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
		   | Rep
		   | Faltou
	deriving Show
type Turma = BTree Aluno			-- árvore binária de procura (ordenada por número)

-- Alínea a)
inscNum :: Numero -> Turma -> Bool
inscNum _ Vazia = False
inscNum x ((Node n,_,_,_) e d) | x==n = True
			       | x<n = inscNum x e
			       | otherwise = inscNum x d

-- Alínea b)
inscNome :: Nome -> Turma -> Bool
inscNome x Vazia = False
inscNome x ((Node _,a_,_) e d) | x==a = True
			       | otherwise = (inscNome x e) || (inscNome x d)

-- Alínea c)
trabEst :: Turma -> [(Numero,Nome)]
trabEst Vazia = Vazia
trabEst ((Node n,a,r,_) e d) | r==TE = (trabEst e) ++ ((n,a):trabEst d)
			     | otherwise = (trabEst e) ++ (trabEst d)

-- Alínea d)
nota :: Numero -> Turma -> Maybe Classificacao

-- Alínea e)
percFaltas :: Turma -> Float

-- Alínea f)
mediaAprov :: Turma -> Float

-- Alínea g)
aprovAv :: Turma -> Float

