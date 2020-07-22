-- @author Pirata
-- @version 2015.12

module FichaTP9 where

-- Ex 1 - Expressões Inteiras

data ExpInt = Const Int
			| Simetrico ExpInt
			| Mais ExpInt ExpInt
			| Menos ExpInt ExpInt
			| Mult ExpInt ExpInt

-- a) função que dada uma expressão, calcula o seu valor.
calcula :: ExpInt -> Int
calcula (Const n) = n
calcula (Simetrico e) = (calcula e) * (-1)
calcula (Mais a b) = (calcula a) + (calcula b)
calcula (Menos a b) = (calcula a) - (calcula b)
calcula (Mult a b) = (calcula a) * (calcula b)

-- b) função que dada uma ExpInt, devolva a forma correcta de a representar.
-- Ex infixx (Mais (Const 3) (Menos (Const 2) (Const 5))) devolve (3 + (2 - 5))
infixx :: ExpInt -> String
infixx (Const n) = show n
infixx (Simetrico x) = "(-" ++ (infixx x) ++ ")"
infixx (Mais x y) = "(" ++ (infixx x) ++ " + " ++ (infixx y) ++ ")"
infixx (Menos x y) = "(" ++ (infixx x) ++ " - " ++ (infixx y) ++ ")"
infixx (Mult x y) = "(" ++ (infixx x) ++ " x " ++ (infixx y) ++ ")"

-- c) função que dada uma expressão, devolva uma String, neste caso com os valores inteiros primeiro e os simbolos depois.
-- Ex posfix (Mais (Const 3) (Menos (Const 2) (Const 5))) devolve 3 2 5 - +
posfix :: ExpInt -> String
posfix (Const n) = show n
posfix (Simetrico e) = posfix e ++ " n"
posfix (Mais a b) = posfix a ++ " " ++ posfix b ++ "+"
posfix (Menos a b) = posfix a ++ " " ++ posfix b ++ "-"
posfix (Mult a b) = posfix a ++ " " ++ posfix b ++ "+"

-- Ex 2 - Árvores irregulares - Rose Trees
data RTree a = R a [RTree a]
	deriving Show

-- a) função que soma os elementos da árvore.
soma :: (Num a) => (RTree a) -> a
soma (R valor []) = valor
soma (R valor subNodes) = valor + (sum (map soma subNodes))

-- b) função que calcula a altura da árvore.
altura :: (RTree a) -> Int
altura (R _ subNodes) = 1 + (foldl max 0 (map altura subNodes))

-- c) função que remove de uma árvore, todos os elementos a partir de uma determinada profundidade.
prune :: Int -> (RTree a) -> (RTree a)
prune 1 (R v _) = R v []
prune x (R v subNodes) = R v (map (prune (x - 1)) subNodes)

-- d) função que gera a árvore simétrica.
mirror :: (RTree a) -> (RTree a)
mirror (R v subNodes) = R v (map mirror (reverse subNodes))

-- e) função que corresponde a travessia postorder da árvore.
postorder :: (RTree a) -> [a]
postorder (R v subNodes) = foldr (++) [v] (map postorder subNodes)


-- Ex 3 - Árvores
data BTree a = Empty | Node a (BTree a) (BTree a)
	deriving Show

-- a) Leaf Trees.
data LTree a = Tip a | Fork (LTree a) (LTree a)
	deriving Show

-- i) função que soma as folhas de uma árvore.
ltSum :: (Num a) => (LTree a) -> a
ltSum (Tip a) = a
ltSum (Fork x y) = (ltSum x) + (ltSum y)

-- ii) função que lista os elementos de uma árvore, da esquerda para a direita.
listLT :: (LTree a) -> [a]
listLT (Tip a) = [a]
listLT (Fork x y) = (listLT x) ++ (listLT y)

-- iii) função que calcula a altura de uma árvore.
ltHeight :: (LTree a) -> Int
ltHeight (Tip _) = 1
ltHeight (Fork x y) = 1 + (max (ltHeight x) (ltHeight y))

-- b) Full Trees - podem ter dados diferentes nos nodos e nas folhas.
data FTree a b = Leaf b | No a (FTree a b) (FTree a b)
	deriving Show

-- i) função que separa uma árvore com informação nos nodos e nas folhas em duas árvores de tipos diferentes.
splitFTree :: (FTree a b) -> (BTree a, LTree b)
splitFTree (Leaf x) = (Empty,Tip x)
splitFTree (No x l r) = let (l1, l2) = splitFTree l
                            (r1, r2) = splitFTree r
                        in (Node x l1 r1, Fork l2 r2)

-- ii) função que sempre que duas árvores sejam compatíveis as junta numa só.
joinTrees :: (BTree a) -> (LTree b) -> Maybe (FTree a b)
joinTrees Empty (Tip x) = Just (Leaf x)
joinTrees (Node x e d) (Fork e' d') = case (joinTrees e e') of
	Nothing -> Nothing
	Just e1 -> case (joinTrees d d') of
		Nothing -> Nothing
		Just d1 -> Just (No x e1 d1)
joinTrees _ _ = Nothing
