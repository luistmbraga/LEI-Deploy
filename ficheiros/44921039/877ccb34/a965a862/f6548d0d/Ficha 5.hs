
-- Pergunta 1
-- divMod :: Int -> Int -> (Int,Int)
-- divMod x y = (div x y,mod x y)

divMod2 :: Int -> Int -> (Int,Int)
divMod2 x y | x<y = (0,x)
	    | otherwise = let (a,b) = divMod2 (x-y,y)
			  in (1+a,b)

-- Pergunta 2
-- splitAt :: Int -> [a] -> ([a],[a])
-- splitAt n l = (take n l,drop n l)

splitAt2 :: Int -> [a] -> ([a],[a])
splitAt2 _ [] = ([],[])
splitAt2 n l | n<=0 = ([],l)
splitAt2 n (x:xs) = let (l1,l2) = splitAt2 (n-1) xs
		    in (x:l1,l2)

-- Pergunta 3
-- Alínea a)
zipWith2 :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith2 _ _ _ = []
zipWith2 f (x:xs) (y:ys) = (f x y):(zipWith2 f xs ys)

-- Alínea b)
takeWhile2 :: (a -> Bool) -> [a] -> [a]
takeWhile2 f [] = []
takeWhile2 f (x:xs) = if (f x) then x:(takeWhile2 f xs)
			       else []

-- Alínea c)
dropWhile2 :: (a -> Bool) -> [a] -> [a]
dropWhile2 f [] = []
dropWhile2 f (x:xs) = if f(x) then (dropWhile2 f xs)
			      else x:xs

-- Alínea d)
span2 :: (a -> Bool) -> [a] -> ([a],[a])
span2 p [] = ([],[])
span2 p (x:xs) | not (p x) = ([], x:xs)
	       | otherwise = let (a,b) = span2 p xs
			     in (x:a,b)

-- Pergunta 4
agrupa :: Sting -> [(Char),(Int)]
agrupa [] = []
agrupa (x:xs) = let (a,b) = span2 (==x) xs
		in (x, 1+length a):agrupa b

-- Pergunta 5
toDigits2 :: Int -> [Int]
toDigits2 0 = []
toDigits2 n | n>0 = let (q,r) = divMod2 n 10
		    in r:toDigits2 q

-- ou:
-- toDigits2 n | n>0 = snd (divMod n 10):toDigits2 (fst (divMod n 10))
-- toDigits2 0 = []

-- Pergunta 6
-- Alínea a)
fromDigits2 :: [Int] - > Int
fromDigits2 l = sum (zipWith2 (\(c,e) -> c*10^e) l [0,1..])

-- Alínea b)


-- Alínea c)


-- Pergunta 7:
-- Alínea a)


-- Alínea b)


-- Pergunta 8:
indicativo :: Sting -> [String] -> [String]
indicativo ind telefs = filter (concorda ind) telefs
	where concorda :: String -> String -> Bool
	      concorda [] = True
	      concorda (x:xs) (y:ys) = (x==Y) && (concorda xs ys)
	      concorda (x:xs) [] = False

