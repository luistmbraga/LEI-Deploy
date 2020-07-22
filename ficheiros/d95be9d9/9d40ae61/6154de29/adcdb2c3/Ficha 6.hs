
-- Pergunta 1:
ePrimo :: Integer -> Bool
ePrimo n | n>0 = (filter (\d -> mod n d == 0) [1..n]) == [1,n]

-- ou:
-- ePrimo n | n>0 = [d | d <- [1..n], mod n d == 0] [1..n] == [1,n]

-- Pergunta 2:
primos :: Integer -> [Integer]
primos n = [x | x <- [1..n], ePrimo x]

-- ou:
-- primos n = filter ePrimo [1..n]

-- Pergunta 3:
crivo :: [Integer] -> [Integer]
crivo (x:xs) = x:crivo (filter (\d -> mod d x /= 0) xs)
crivo [] = []

-- Pergunta 4:
-- Alínea a)
factoriza :: Integer -> [Integer]
factoriza n | n>0 = factPrimos n (primos n)

factPrimos :: Integer -> [Integer]-> [Integer]
factPrimos n (x:xs) | mod n x == 0 = x:factPrimos (div n x) (x:xs)
		    | otherwise	   = factPrimos n xs
factPrimos [] = []

-- Alínea b)
mdcF :: Integer -> Integer -> Integer
mdcF x y = comum (factoriza x) (factoriza y)
   where comum :: [Integer] -> [Integer] -> Integer
	 comum (b:bs) (c:cs) | b=c = b*(comum bs cs)
			     | b<c = comum bs (c:cs)
			     | b>c = comum (b:bs) cs
	 comum _ _ = 1

mmcF :: Integer -> Integer -> Integer
mmcF x y = minComum (factoriza x) (factoriza y)
   where minComum :: [Integer] -> [Integer] -> Integer
	 minComum (b:bs) (c:cs) | b=c = b*(minComum bs cs)
				| b<c = b*minComum bs (c:cs)
				| b>c = b*minComum (b:bs) cs
	 minComum [] l = product l
	 minComum l [] = product l

-- Alínea c)
-- mdc x y = mdc (x+y) y = mdc x (y+x)
-- mmc :: Integer -> Integer -> Integer
-- mmc x y = (x*y) 'div' (mdc x y)

mdc :: Integer -> Integer -> Integer
mdc x y | x==y = x
	| x<y  = mdc x (y-x)
	| x>y  = mdc (x-y) y

-- Pergunta 5:
type Polinomio = [Coeficiente]
type Coeficiente = Float

-- Alínea a)


-- Alínea b)


-- Alínea c)


-- Alínea d)


-- Pergunta 6:
subLists :: [a]-> [[a]]
subLists [] = [[]]
subLists (x:xs) = (map (x:)(subLists xs)) ++ (subLists xs)

