-- @author Pirata
-- @version 2015.12

module FichaTP8 where

-- Ex 1 - Árvores Binárias
data BTree a = Empty
			 | Node a (BTree a) (BTree a)
	deriving Show

-- a) função que calcula a altura da árvore.
altura :: (BTree a) -> Int
altura Empty = 0
altura (Node _ lnode rnode) = 1 + (max (altura lnode) (altura rnode))

-- b) função que calcula o número de nodos da árvore.
contaNodos :: (BTree a) -> Int
contaNodos Empty = 0
contaNodos (Node _ lnode rnode) = 1 + (contaNodos lnode) + (contaNodos rnode)

-- c) função que calcula o número de folhas da árvore.
folhas :: (BTree a) -> Int
folhas Empty = 0
folhas (Node _ Empty Empty) = 1
folhas (Node _ lnode rnode) = (folhas lnode) + (folhas rnode)

-- d) função que remove da árvore todos os elementos a partir de uma determinada profundidade.
prune :: Int -> (BTree a) -> (BTree a)
prune _ Empty = Empty
prune 0 arvbin = arvbin
prune x (Node a lnode rnode) = Node a (prune (x - 1) lnode) (prune (x - 1) rnode)

-- e) função que dado um caminho em Booleanos e uma árvore, devolve a lista com a informação dos nodos por onde esse caminho passa.
path :: [Bool] -> (BTree a) -> [a]
path _ Empty = []
path [] (Node d _ _) = [d]
path (x:xs) (Node d lnode rnode) = if x then (d : (path xs rnode)) else (d : (path xs lnode))

-- f) função que devolve a árvore simétrica.
mirror :: (BTree a) -> (BTree a)
mirror Empty = Empty
mirror (Node x lnode rnode) = Node x (mirror rnode) (mirror lnode)

-- g) função que generaliza a função zipWith para árvores binárias.
zipWithBT :: (a -> b -> c) -> (BTree a) -> (BTree b) -> (BTree c)
zipWithBT f (Node x xleft xright) (Node y yleft yright) = Node (f x y) (zipWithBT f xleft yleft) (zipWithBT f xright yright)
zipWithBT _ _ _ = Empty

-- h) função que generaliza a função unzip para árvores binárias.
unzipBT :: (BTree (a,b,c)) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (x,y,z) lnode rnode) = (Node x al ar, Node y bl br, Node z cl cr) where
	(al, bl, cl) = unzipBT lnode
	(ar, br, cr) = unzipBT rnode

-- Ex 2 - Árvores Binárias de Procura
-- a) função que calcula o menor valor de uma árvore binária de procura não vazia.
minimo :: (Ord a) => (BTree a) -> a
minimo (Node x Empty _) = x
minimo (Node _ lnode _) = minimo lnode

-- b) função que remove o menor valor de uma árvore binária de procura não vazia.
semMinimo :: (Ord a) => (BTree a) -> (BTree a)
semMinimo Empty = Empty
semMinimo (Node x Empty rnode) = rnode
semMinimo (Node x lnode rnode) = Node x (semMinimo lnode) rnode

-- c) função que, numa consulta, faz o mesmo que as duas funções anteriores.
minSmin :: (Ord a) => (BTree a) -> (a,BTree a)
minSmin (Node x Empty rnode) = (x, rnode)
minSmin (Node x lnode rnode) = let (a,b) = minSmin lnode in (a, Node x b rnode)

-- Ex 3 - Turma de Alunos
type Aluno = (Numero,Nome,Regime,Classificacao)

type Numero = Int

type Nome = String

data Regime = ORD | TE | MEL
	deriving Show

data Classificacao = Aprov Int | Rep | Faltou
	deriving Show

type Turma = BTree Aluno -- árvore binária de procura (ordenada por número)

-- a) função que verifica se um aluno, com um dado número, está inscrito.
inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum num (Node (number, _, _, _) lnode rnode) = if (num == number) then True else if (num < number) then inscNum num lnode else inscNum num rnode

-- b) função que verifica de um aluno, com um dado nome, está inscrito.
inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome nome (Node (_, name, _, _) lnode rnode) = if (nome == name) then True else (inscNome nome lnode) || (inscNome nome rnode)

-- c) função que lista o número e nome dos alunos trabalhadores-estudantes.
trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (number, name, TE, _) lnode rnode) = (trabEst lnode) ++ [(number, name)] ++ (trabEst rnode)
trabEst (Node (_, _, _, _) lnode rnode) = (trabEst lnode) ++ (trabEst rnode)

-- d) função que calcula a classificação de um aluno. Retorna Nothing se não estiver inscrito.
nota :: Numero -> Turma -> Maybe Classificacao
nota num Empty = Nothing
nota num (Node (number, _, _, classif) lnode rnode) = if (num == number) then Just classif else
													if (num < number) then nota num lnode else nota num rnode

-- e) função que calcula a percebtagem de alunos que faltam a avaliação.
percFaltas :: Turma -> Float
percFaltas t = ((pFAux t) / (fromIntegral (contaNodos t))) * 100 where
	pFAux Empty = 0
	pFAux (Node (_, _, _, Faltou) lnode rnode) = 1 + (pFAux lnode) + (pFAux rnode)
	pFAux (Node (_, _, _, _) lnode rnode) = (pFAux lnode) + (pFAux rnode)

-- f) função que calcula a média das notas dos alunos que passaram.
mediaAprov :: Turma -> Float
mediaAprov t = let (a,b) = mAAux t in (fromIntegral (sum a)) / b where
	mAAux Empty = ([],0)
	mAAux (Node (_, _, _, Aprov x) lnode rnode) = ((x : al) ++ ar, 1 + bl + br) where
		(al,bl) = mAAux lnode
		(ar,br) = mAAux rnode
	mAAux (Node _ lnode rnode) = (al ++ ar, bl + br) where
		(al,bl) = mAAux lnode
		(ar,br) = mAAux rnode

-- g) função que calcula o rácio dos alunos aprovados por avaliados. Fazendo apenas uma travessia.
aprovAv :: Turma -> Float
aprovAv t = let (a,b) = aAAux t in a / b where
	aAAux Empty = (0,0)
	aAAux (Node (_, _, _, Aprov x) lnode rnode) = (1 + al + ar, 1 + bl + br) where
		(al,bl) = aAAux lnode
		(ar,br) = aAAux rnode
	aAAux (Node (_, _, _, Rep) lnode rnode) = (0 + al + ar, 1 + bl + br) where
		(al,bl) = aAAux lnode
		(ar,br) = aAAux rnode
	aAAux (Node _ lnode rnode) = (0 + al + ar, 0 + bl + br) where
		(al,bl) = aAAux lnode
		(ar,br) = aAAux rnode
