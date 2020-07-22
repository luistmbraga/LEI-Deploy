
soma::Int->Int->Int
soma x y = x+y


{-
compara:: Int->Int->Int
compara x y = if x>y then x else y

 -}         

compara:: Int->Int->Int->Int
compara x y z= if x>y && x>z then x else if y>z then y else z

compara2 x y z  | x>y && x>z = x
		| y>z = y 
		| otherwise = z 

somatorio:: [Int]->Int
somatorio [] = 0
somatorio (x:xs) = x + (somatorio xs)

produtorio:: [Int]->Int
produtorio [] = 1
produtorio (x:xs) = x * (produtorio xs)

tabuada::Int->[Int]
tabuada n = [n*y| y<-[1..10]]

testar:: Int->Int->Int->Bool
testar x y z    | x==y && x==z = True
                | otherwise = False 
                
testar2 x y z = (x==y) && (y==z)                
                
factorial:: Int->Int
factorial x |x==0 =1
            |otherwise = x*factorial (x-1)
            
factorial3 0 = 1
factorial3 x = x*factorial3 (x-1)


