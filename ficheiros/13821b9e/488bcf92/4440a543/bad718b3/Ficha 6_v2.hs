--Ficha 6

soma l = foldr (+) 0 l

produto l = foldr (*) 1 l

tamanho l = foldr f 0 l
	where f a b = 1 + b

--1

ePrimo :: Integer -> Bool
ePrimo x = length [y|y <- [2 .. div x 2], mod x y == 0] == 0

--2

primos :: Integer -> [Integer]
primos x = filter ePrimo [2.. x]

--3
{-
crivo :: [Integer] -> [Integer]
crivo [] = []
crivo (x:xs) = let f n = (mod n x) /= 0
	 				in	x:(crivo filter f xs)
-}

--4

ou l = foldr (||) False l


e l = foldr (&&) True l

--5

conta :: Eq a => a -> [a] -> Int
conta x l = length (filter (x==) l)