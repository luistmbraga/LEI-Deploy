-- F I C H A  4

-- 1)

Maybe a ∼= Either a ()
Either () () ∼= Bool
(a, Either b c) ∼= Either (a,b) (a,c) 
a -> b -> c ∼= (a,b) -> c

-- fazer funcoes de conversao

-- Maybe a ∼= Either a ()

to :: Maybe a -> Either a ()
to (Just x) = Left x
to Nothing = Right ()

from :: Either a () -> Maybe a
from Left x = Just x
from Right () = Nothing

∀x, to(from x) = x
<=> {-Ind-Either-}
∀y,z to (from(Left y)) = Left y && to(from(Right z)) = Right z
<=> {-Ind-()-}
∀y to(from(Left y)) = Left y && to(from(Right())) = Right()
<=>{-Def-from-}
∀y to (Just y) = Left y && to Nothing = Right()

-- (a, Either b c) ∼= Either (a, b) (a, c)
to :: (a,Either b c) -> Either (a,b)(a,c)
to (x,Left y) = Left(x,y) -- y do tipo b
to (x, Right y) = Right(x,y) -- y do tipo c

from :: Either (a,b)(a,c) -> (a,Either b)
from (Left(x,y)) = (x,Left y)
from (Right(x,y)) = (x,Right y)

-- a -> b -> c ∼= (a,b) -> c
curry :: ((a,b)->c)
curry f = \x -> \y -> f(x,y)

uncurry :: (a->b->c) -> ((a,b)->c)
uncurry f = \(x,y) -> f x y
uncurry f (x,y) = f x y

-- a primeira prova é provar que o reverse de rev rev não faz nada

--exemplo
Either Int Char
> Left 1
> Right 'a'

--demonstre isomorfismo --sai no teste !!!!!
1º definir funcao conversao de a para b
2º definir funcao conversao de b para a
3º provar que sao inversos. fazer from e depois to dá a mesma coisa e fazer to e depois from dá a mesma coisa
4º chegar a uma igualdade do genero a = a

-- 2)

∀l :: [a] . rev (rev l) = l

<=> {-Ind-list-}
rev(rev[]) = [] && ∀h,t.rev(rev t) = t => rev(rev(h:t)) = h:t
<=>Def-rev
rev(rev[]) = [] && rev(rev t ++ [h]) = h:t
<=> ver lema auxiliar
rev(rev[]) = [] && rev[h] ++ rev(rev t) = h:t
<=>Def-rev, hipotese induçao
rev(rev[]) = [] && [h] ++ t

--NOTA lema auxiliar
rev(l ++ m) = rev m ++ rev l

rev(rev[])
<=> Def-rev
rev([]) = []
<=> Def-rev
[] = []

∀l,m :: [a].length (l + m ) = length l + length m
(1) ∀m . length([]++m) = length[] + length m ...
<=> Def-++
∀m . length m = length [] + length m
<=>Def-length
∀m . length m = 0 + length m
<=> 0 elemento neutro da soma
∀m . length m = length m

(2) ∀h,t,m . length((h:t) ++ m) = length (h:t) + length m
<=> Def-++,Def-length
∀h,t,m . length (h:(t++m)) = 1 + length t + length m
<=> Def-length
∀h,t,m . 1 + length(t++m) = 1 + length t + length m
<=> hipotese inducao
∀h,t,m . 1 + length t + length m = 1 + length t + length m

-- 3)

data Nat = Zero | Succ Nat
deriving (Show, Eq)
instance Num Nat where 
	m + Zero = m
	m + (Succ n) = Succ (m + n) 
	m * Zero = Zero 
	m * (Succ n) = m + m * n
-- exemplo
>3
>>Succ(Succ(Succ Zero))

∀n :: Nat . P n
<=>
(1) P Zero 1 (2) ∀ x :: Nat . P x => P(Succ x)

m + zero = m
m + Succ x = Succ (m + x)

-- b)

∀m,n :: Nat . m + n = n + m
∀l,m,n :: Nat . l + (m + n ) = (l + m ) + n 
∀m,n :: Nat . m ∗ n = n ∗ m
∀l,m,n :: Nat . l ∗ (m ∗ n ) = (l ∗ m ) * n
∀l,m,n :: Nat . l ∗ (m + n ) = l ∗ m + l * n

∀m,n :: Nat . m + n = n + m
<=> Ind-Nat
(1)Zero + m = m + Zero
<=> Def - +
Zero + m = m
<=>Ind-Nat

1.(1)Zero + Zero = Zero
<=> Def - +
Zero = Zero

1.(2)
Zero + m = m => Zero + Succ m = Succ m
<=> Def - +
Succ (Zero + m) = Succ m
<=> H.I
Succ m = Succ m

Succ n + m = Succ (n+m)
<=> Ind - Nat
(1) Succ n + Zero = Succ(n + Zero)
(2) Succ n + m = Succ(n+m) => Succ n + Succ m = Succ (n + Succ m)
							  Succ(Succ n + m) = Succ (Succ(n+m))
							  H.I
							  Succ(Succ(n+m)) = Succ(Succ(n+m))

n + m = m + n => Succ n + m = m + Succ n
<=> Def - +
				 Succ n + m = Succ (m + n)
<=> ??? lema auxiliar
				 Succ(n + m) = Succ (m + n)
<=> H.I
				 Succ(n + m) = Succ (m + n)

-- 4)

data Tree a = Empty | Node (Tree a) a (Tree a)

size :: Tree a -> Integer
size Empty = 0
size (Node l x r) = 1 + size l + size r

mirror :: Tree a -> Tree a
mirror Empty = Empty
mirror (Node l x r) = Node (mirror r) x (mirror l)

inorder :: Tree a -> [a]
inorder Empty = [ ]
inorder (Node l x r) = inorder l ++ [x] ++ inorder r

-- b)
∀ t :: Tree a . size (mirror t) = size t
<=> Ind-Tree
(1)size(mirror Empty) = Size Empty
size mirror = mirror
size Empty = Empty

(2)size(mirror l) = size l && size(mirror r) = size r => size(mirror(Node l x r)) = size(Node l x r)

size(mirror(Node l x r)) = size(Node l x r)
<=> Def - mirror
size(Node (mirror r) x (mirror l)) = size(Node l x r)
<=> Def - size
1 + size (mirror r) + size (mirror l) = 1 + size l + size r
H.I
1 + size r + size l = 1 + size l + size r
<=> A soma é comutativa
1 + size l + size r = 1 + size l + size r



