module Ficha8 where

data BTree a = Empty | Node a (BTree a) (BTree a)
		deriving Show

sumNodos :: (BTree Int) -> Int
sumNodos Empty = 0
sumNodos (Node n e d) = n + (sumNodos e) + (sumNodos d)

--1
--a

altura ::	(BTree a) -> Int
altura Empty = 0
altura (Node n e d) = 1 + (max (altura e) (altura d))

--b
contaNodos :: (BTree a) -> Int
contaNodos Empty = 0
contaNodos (Node n e d) = 1 + (contaNodos e) + (contaNodos d)

--c
folhas :: (BTree a) -> Int 
folhas Empty = 0
folhas (Node n Empty Empty) = 1
folhas (Node n e d) = (folhas e) + (folhas d)

--d
prune :: Int -> (BTree a) -> BTree a
prune 0 _  = Empty
prune _ Empty = Empty
prune x (Node n e d) = Node n (prune (x-1) e)(prune (x-1) d)

--e
path :: [Bool] -> (BTree a) -> [a]
path [] _ = []
path _ Empty = []
path (h:t) (Node n e d) = if (h == True) then n : (path t d) else n : (path t e) 

--f
mirror :: (BTree a) -> BTree a
mirror Empty = Empty
mirror (Node n e d) = Node n (mirror d)(mirror e)

--g
zipWhitBT :: (a -> b-> c) -> (BTree a) -> (BTree b) -> BTree c
zipWhitBT f (Node n1 e1 d1) (Node n2 e2 d2) = Node (f n1 n2) (zipWhitBT f e1 e2) (zipWhitBT f d1 d2)
zipWhitBT _ _ _ = Empty

--h
unzipBT :: (BTree (a,b,c)) -> (BTree a, BTree b, BTree c)
unzipBT (Node (a,b,c) e d) = (Node a q z, Node b w x, Node c r v) where (q,w,r) = unzipBT e ; (z,x,v) = unzipBT d 
unzipBT Empty = (Empty,Empty,Empty)

--2
type Aluno = (Numero, Nome, Regime, Classificacao)
type Numero = Int
type Nome = String

data Regime = ORD | TE | MEL deriving Show
		

data Classificacao = Aprov Int
				   | Rep
				   | Faltou
				deriving Show

type Turma = BTree Aluno 

--a
inscNum :: Numero -> Turma -> Bool
inscNum x Empty = False
inscNum x (Node a@(num,no,reg,clas) e d) = (x == num) || (inscNum num e) || (inscNum num d)

--b
insNome :: Nome -> Turma -> Bool
insNome l Empty = False
insNome l (Node (_,no,_,_) e d) = (l == no) || (insNome no e) || (insNome no d)

--c
trabEst :: Turma -> [(Numero,Nome)]
trabEst (Node (num,no,TE,clas) e d) = (num,no) : (trabEst e) ++ (trabEst d) 
trabEst (Node (num,no,reg,clas) e d) = (trabEst e) ++ (trabEst d)

--d
nota :: Numero -> Turma -> Maybe Classificacao
nota n l@(Node (num,no,reg,clas) e d) | inscNum n l == False = Nothing
									  | (n == num) = Just clas
									  | (n < num) = nota n l
									  | (n > num) = nota n l
									
--e
percFaltas :: Turma -> Float
percFaltas l@(Node (num,no,reg,clas) e d) = ((fromIntegral (sFaltas l)) / (fromIntegral (contaNodos l))) * 100
					where sFaltas l@(Node (num,no,reg,Faltou) e d) = 1 + sFaltas e + sFaltas d
			
--f
mediaAprov :: Turma -> Float
mediaAprov l@(Node (num,no,reg,clas) e d) = ((fromIntegral (sAprov l)) / (fromIntegral (contaNodos l)))
					where sAprov l@(Node (num,no,reg,Aprov c) e d) = c + sAprov e + sAprov d
		
--e
--aprovaAV :: Turma -> Float

