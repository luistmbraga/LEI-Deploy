
-- 2) b) Considere agora que armazenamos a informação sobre uma turma como uma árvore binária de
--       procura ordenada por número de aluno, de acordo com a seguinte estrutura de dados:

type Aluno = (Numero,Nome,Classificacao)
type Numero = Int
type Nome = String
data Classificacao = Aprov Int | Rep | Faltou
data Turma = Vazia | Nodo Aluno Turma Turma

-- aprovAv :: Turma -> Float, que calcula o rácio de alunos aprovados por avaliados.
-- Implemente esta função, fazendo apenas uma travessia da árvore.

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

