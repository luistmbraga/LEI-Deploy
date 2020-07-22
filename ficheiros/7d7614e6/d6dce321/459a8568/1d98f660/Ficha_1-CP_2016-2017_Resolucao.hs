--
-- Ficha 01 de Calculo de Programas.
-- Este ficheiro não compila assim completo, pois baseia-se em explicações e em funções pré-definidas no Prelude.
-- 
-- @author (Pirata) 
-- @version (2017.02)
--

-> Ex 1
(f . g) x = f (g x)
- a) 
f x = 2 * x; g x = x + 1;
(f . g) x = 2 * (x + 1) = 2 * x + 2

f = succ; g x = 2 * x;
(f . g) x = succ (2 * x) = 2 * x + 1

f = succ; g = length;
(f . g) x = succ (length x) = (length x) + 1

g(x,y) = x + y; f = succ . (2*);
(f . g) x = (f . g) (x1,x2) = succ . (2*) (x1 + x2) = 2 * x1 + 2 * x2 + 1

Alineas b) e c) no caderno/aulas teóricas pelos esquemas.

-> Ex 2
data Listas a = [] | Elem x (Lista a) - pequena explicação do data type das listas em Haskell.
	As funções (f) com listas como argumentos tem 3 linhas principais a que devem responder:
> f [] = aplicar a função sobre a lista vazia
> f [x] = aplicar a função sobre uma lista com apenas um elemento
> f (y ++ z) = aplicar a função a uma lista em que essa lista está dividida "aleatoriamente" ao meio. Pode ir desde (head:ts) até (hs++[last]).
length :: [a] -> Int
length [] = 0
-- length [x] = 1
-- length (y ++ z) = (length y) + (length z) <=>
-- length ([head]++tail) = (length [head]) + (length tail) <=>
length (h:ts) = 1 + length ts -- como o caso do length [x] pode ser representado obtendo o mesmo resultado com esta alinea, podes-se ocultar a linha do codigo para a lista com um unico elemento.

	Seguindo o mesmo método de antes:
reverse :: [a] -> [a]
reverse [] = []
-- reverse [x] = [x]
-- reverse (x ++ y) = (reverse y) ++ (reverse x) <=> reverse ([x] ++ y) = (reverse y) ++ (reverse [x]) <=>
reverse (x:y) = (reverse y) ++ [x]
-- OU
-- reverse (x ++ y) = (reverse y) ++ (reverse x) <=> reverse (x ++ [y]) = (reverse [y]) ++ (reverse x) <=>
reverse (x ++ [y]) = y : (reverse x)

-> Ex 3
data Maybe a = Nothing | Just a

catMaybes :: [Maybe a] -> [a]
	Usa-se de novo as "regras" ditas acima
catMaybes [] = []
catMaybes [x] = ....
catMaybes (x ++ y) = (catMaybes x) ++ (catMaybes y) <=> catMaybes ([x] ++ y) = (catMaybes [x]) ++ (catMaybes y)
	Mas estamos presos para a parte sobre o que fazer para o elemento individual.
	Isto acontece porque os tipos de dados como o Maybe teem duas ou mais variantes, neste caso, o Nothing e o Just x e é com isso que temos de variar.
	Logo:
> O catMaybes [x] passa a ter dois casos:
catMaybes (Nothing) = []
catMaybes (Just x) = [x]
> O catMaybes ([x] ++ y) passa a ter dois casos também:
catMaybes (Nothing : y) = catMaybes y
catMaybes (Just x) = x : (catMaybes y)
	Como mais uma vez o caso do elemento unico é representado nas ultimas linhas para listas pode-se comentar/drop as linhas para listas com 1 só elemento.

-> Ex 4
uncurry :: (a -> b -> c) -> (a,b) -> c -- aplica uma função que recebe dois argumentos a um par de argumentos.
uncurry f (a,b) = f a b

curry :: ((a,b) -> c) -> a -> b -> c -- oposto da uncurry, aplica uma função que recebe um par de argumentos a dois argumentos.
curry f a b = f (a,b)

flip :: (a -> b -> c) -> b -> a -> c -- troca a ordem dos dois argumentos finais recebidos
flip f b a = f a b

-> Ex 5
data LTree a = Leaf a | Fork (LTree a,LTree a)

	Neste caso, não estamos a trabalhar com listas, mas com um data type diferente, que contém 2 "definições". Também não tem caso NULL por isso sabemos que uma LTree tem semppre no mínimo 1 elemento.
	Neste caso as funções (f) aplicadas a este tipo de dados terão de no mínimo responder a:
> f (Leaf x) = ao caso de ser uma folha com informação
> f (Fork (left,right)) = no caso de ser uma das bifurcações

flatten :: LTree a -> [a]
flatten (Leaf a) = [a]
flatten (Fork (e,d)) = (flatten e) ++ (flatten d)

mirror :: LTree a -> LTree a
mirror (Leaf a) = Leaf a
mirror (Fork (e,d)) = Fork (mirror d,mirror e)

fmap :: (b -> a) -> LTree b -> LTree a
fmap f (Leaf b) = Leaf (f b)
fmap f (Fork (e,d)) = Fork (fmap f e,fmap f d)

-> Ex 6
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f b [] = b -- quando a lista está vazia retorna o valor b.
foldr f b (a:as) = f a (foldr f b as) -- aplica a função f tendo como argumentos o 1º elemento da lista e o resultado do foldr ao resto da lista.

- a)
length :: [a] -> Int
length x = foldr (\a -> (+) 1) 0 x
-- (\a -> (+) 1) é uma função que recebe um a e retorna (1 + ) isto é uma função que vai somar 1 ao que aparecer a seguir.

- b)
f = foldr (:) []
É o mesmo que ter: f x = foldr (:) [] x
temos então que, desdobrando o foldr:
f [] = [] -- para a lista vazia, o foldr retorna a lista vazia.
f (h:ts) = (:) h (f ts) <=> f (h:ts) = h : (f ts) -- para cada elemento da lista o foldr, aplica a função ao primeiro elemento e ao resultado da função no resto da lista.
Ou seja, no fim, esta função apenas corre a lista toda, sem a alterar.

-> Ex 7
concat :: [[a]] -> [a]
concat = foldr (++) []
	De novo, basta desdobrar o foldr:
concat [] = []
concat (h:ts) = (++) h (concat ts) <=> concat (h:ts) = h ++ (concat ts)

-> Ex 8
f :: [Int] -> [Int]
f s = [a + 1 | a <- s, a > 0]
	Listas por compreensão: Esta função soma 1 a todos os valores positivos a uma lista de Ints e descarta os negativos.

f s = foldr (\a -> if (a > 0) then ((:) (a + 1)) else ((++) [] )) [] s

-> Ex 9
m :: (a -> b) -> [a] -> [b]
m f [] = []
m f (h:ts) = (f h) : m f ts
	Em short, esta funçao representa a função map.

- a)
m f x = foldr (\a -> (:) (f a)) [] x

- b)
m f x = foldr ((:) . f) [] x

- c)
m :: (a -> b) -> [a] -> [b]

(\x -> [x]) :: a -> [a]
	
	Sendo assim, combinando os dois: onde em m temos (a -> b) vamos ter (a -> [a]) ou seja a == a e b == [a] logo:

m (\x -> [x]) :: [a] -> [[a]] -- e esta expressão passa todos os elementos da lista [a] para dentro de uma lista individual [[a]]

- d)
let s = m singl "Calculo de Programas" in concat s <=>
m singl "Calculo de Programas" = ["C","a","l","c","u","l","o"," ","d","e"," ","P","r","o","g","r","a","m","a","s"] -- e então
concat ["C","a","l","c","u","l","o"," ","d","e"," ","P","r","o","g","r","a","m","a","s"] = "Calculo de Programas"

concat (singl "Calculo de Programas") = concat ["Calculo de Programas"] = "Calculo de Programas"

	Apura-se que concat e singl são funções que se anulam uma à outra.
	