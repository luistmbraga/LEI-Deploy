--Folha5

import Data.Char

--1

divMode :: Int -> Int -> (Int,Int)
divMode x y = (dive x y, mode x y)

dive :: Int -> Int -> Int
dive x y = if (x >= y) then 1 + (dive (x-y) y) else 0

mode :: Int -> Int -> Int
mode x y = if ( x >= y) then (mode (x-y) y) else x

diveMode :: Int -> Int -> ( Int , Int )
diveMode x y = if ( x >= y) then (1 + a, b) else (0,x)
				where (a,b) = (diveMode (x-y) y)
				
--2

splitAte :: Int -> [Int] -> ([Int],[Int])
splitAte n l = (taken n l, dropn n l)

taken :: Int -> [Int] -> [Int]
taken n (x:xs) = if (n > 0) then x : (taken (n-1) xs) else []

dropn :: Int -> [Int] -> [Int]
dropn 0 l = l
dropn _ [] = []
dropn n (x:xs) = (dropn (n-1) xs )

aSplitAt :: Int -> [Int] -> ([Int],[Int])
aSplitAt _ [] = ([],[])
aSplitAt 0 l = ([], l)
aSplitAt n (x:xs) = (x : b, c)
	where (b,c) = (aSplitAt (n-1) xs)

--3

zipwithe :: (a-> b-> c) -> [a] -> [b] -> [c]
zipwithe x (y:ys) (z:zs) = x y z : (zipwithe x ys zs)
zipwithe _ _ _ = []

takewhile1 :: (a -> Bool) -> [a] -> [a]
takewhile1 _ [] = []
takewhile1 x (y:ys) = if (x y) then y : (takewhile1 x ys ) else []

dropewhile :: (a -> Bool) -> [a] -> [a]
dropewhile _ [] = []
dropewhile x (y:ys) = if (x y) then dropewhile x ys else y: ys

spane :: (a -> Bool) -> [a] -> ([a],[a])
spane _ [] = ([],[])
spane f (y:ys) = if (f y) then (y:a, b) else ([], (y:ys))
	where (a,b) = (spane f ys)

--4

agrupa :: String -> [(Char, Int)]
agrupa [] = []
agrupa (h:t) = (h, 1 + length x) : (agrupa y)
	where (x,y) = (spane (==h) t)

--5

toDigits :: Int -> [Int]
toDigits 0 = []
toDigits x = if (x < 10) then [x] else b: (toDigits a)
	where (a,b) = divMod x 10

--6
--a

fromDigits :: [Int] -> Int
fromDigits [x] = x
fromDigits l = sum (zipwithe (*) l [10^x | x <- [0..]])

--c
fromDigitsR l = foldr f 0 l
	where f a b = a + 10*b

--7a

intStr :: Int -> String
intStr x = map intToDigit (reverse (toDigits x))

--b

strInt :: String -> Int
strInt x = foldr f 0 (reverse (map digitToInt x))
	where f a b = a + b*10


--8


indicativo :: String -> [String] -> [String]
indicativo ind telefs = filter (concorda ind) telefs

concorda :: String -> String -> Bool
concorda [] _ = True
concorda (x:xs) (y:ys) = (x==y) && (concorda xs ys)
concorda (x:xs) [] = False

indic :: String -> [String] -> [String]
indic _ [] = []
indic s (h:t) = if (concorda s h) then h : (indic s t) else indic s t

