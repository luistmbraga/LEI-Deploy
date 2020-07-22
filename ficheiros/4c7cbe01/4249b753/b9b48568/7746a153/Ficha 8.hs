
-- Pergunta 1:
data BTree a = Empty
	     | Node a (BTree a) (BTree a)
	     deriving Show

-- Al�nea a)
altura :: (BTree a) -> Int
altura Empty = 0
altura (Node x e d) = 1+max(altura e) (altura d)

-- Al�nea b)
contaNodos :: (BTree a) -> Int
contaNodos Empty = 0
contaNodos (Node x e d) = 1+contaNodos e+contaNodos d

-- Al�nea c)
folhas :: (BTree a) -> Int
folhas Empty = 0
folhas (Node x Empty Empty) = 1
folhas (Node x e d) = folhas e+folhas d

-- ou:
-- folhas :: Eq => BTree a -> Int
-- folhas Empty = 0
-- folhas (Nodo _ e d) = if e==Empty && d==Empty then 1
					      -- else folhas e+folhas d

-- Al�nea d)
prune :: Int -> (BTree a) -> (BTree a)
prune x Empty = Empty
prune 0 _ = Empty
prune x (Node y e d) = let esq = prune (x-1) e
			   dir = prune (x-1) d
		       in (Node y esq dir)

-- Al�nea e)
path :: [Bool] -> (BTree a) -> [a]
path (x:xs) (Node y e d) | x==True = y (if x then (path xs d) else (path xs e))
path _ _ = []

-- Al�nea f)
mirror :: (BTree a) -> BTree a
mirror Empty = Empty
mirror (Node x e d) = Node x (mirror d) (mirror e)

-- Al�nea g)
zipWithBT :: (a -> b -> c) -> (BTree a) -> (BTree b) -> BTree c

-- Al�nea h)
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
type Turma = BTree Aluno			-- �rvore bin�ria de procura (ordenada por n�mero)

-- Al�nea a)
inscNum :: Numero -> Turma -> Bool
inscNum _ Vazia = False
inscNum x ((Node n,_,_,_) e d) | x==n = True
			       | x<n = inscNum x e
			       | otherwise = inscNum x d

-- Al�nea b)
inscNome :: Nome -> Turma -> Bool
inscNome x Vazia = False
inscNome x ((Node _,a_,_) e d) | x==a = True
			       | otherwise = (inscNome x e) || (inscNome x d)

-- Al�nea c)
trabEst :: Turma -> [(Numero,Nome)]
trabEst Vazia = Vazia
trabEst ((Node n,a,r,_) e d) | r==TE = (trabEst e) ++ ((n,a):trabEst d)
			     | otherwise = (trabEst e) ++ (trabEst d)

-- Al�nea d)
nota :: Numero -> Turma -> Maybe Classificacao

-- Al�nea e)
percFaltas :: Turma -> Float

-- Al�nea f)
mediaAprov :: Turma -> Float

-- Al�nea g)
aprovAv :: Turma -> Float

