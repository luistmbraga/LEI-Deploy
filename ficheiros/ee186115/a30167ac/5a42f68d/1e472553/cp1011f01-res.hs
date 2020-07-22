a .* 0 = 0
a .* 1 = a
a .* (b+1) = a*b + a

length' []  = 0
length' (x:xs) = 1 + (length' xs)

reverse' [] = []
reverse' (x:xs) = (reverse' xs) ++ [x]

catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (Nothing:xs)  = catMaybes xs
catMaybes (Just x:xs)   = x : catMaybes xs  

split' a [] = ([],[])
split' a (x:xs) = let (b,c) = split' a xs
					in if (x <= a) then (x:b, c)
					else (b,x:c)