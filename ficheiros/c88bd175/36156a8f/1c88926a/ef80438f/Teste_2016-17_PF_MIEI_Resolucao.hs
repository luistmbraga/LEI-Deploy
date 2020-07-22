module Teste where
import Data.List	

type MSet a = [(a,Int)]

--1)a)
cardMSet :: MSet a -> Int
cardMSet [] = 0
cardMSet ((x,y):t)= y+cardMSet t

--1)b)
moda :: MSet a -> [a]
moda [] = []
moda ((x,y):ts) = mAux ts y [x] where
mAux [] _ new = new
mAux ((x,y):ts) hg new = if (hg > y) then mAux ts hg new
else if (hg == y) then mAux ts hg (new ++ [x])
else mAux ts y [x]

--1)c)
converteMSet :: MSet a -> [a] 
converteMSet [] = []
converteMSet ((x,y):ts) = if (y > 0) then x : (converteMSet ((x,(y - 1)):ts)) else []

--1)d)
addNcopies :: Eq a => MSet a -> a -> Int -> MSet a
addNcopies [] _ _ = []
addNcopies ((x,y):(xs,ys):(h,t):ts) z n | h==z && (t+n)>ys && (t+n)>y = ((h,(t+n)):(xs,ys):(x,y):ts)
| x==z && (y+n)>ys = ((x,(y+n)):(xs,ys):(h,t):ts) 
| xs==z && (ys+n)>y = ((xs,(ys+n)):(x,y):(h,t): ts ) 
|otherwise = addNcopies ts z n 

data SReais = AA Double Double | FF Double Double
|AF Double Double | FA Double Double
| Uniao SReais SReais 

-- As funções 1)b), 1)c) e 1)d) estão mal, na show não precisa dos parênteses e faltam os outros casos de união,
-- na tira falta os casos em que o elemento está no interior da lista

--2)a) 
instance Show SReais where
show (AA x y) = "("++"]"++ (show x) ++ (show y) ++ "["++ ")" 
show (FF x y) = "("++"[" ++ (show x) ++ (show y) ++ "]" ++ ")"
show (AF x y) = "("++ "["++ (show x) ++ (show y) ++ "]" ++ ")"
show (FA x y) = "[" ++ (show x )++ (show y) ++ "["
show (Uniao (AA x y) (AF xs ys)) = "("++"("++"]"++(show x) ++(show y) ++"["++"U"++"]"++ (show xs) ++ (show ys) ++"]"++ ")" 

--2)b)
pertence' :: Double -> SReais -> Bool 
pertence' z (AA x y) |z<=x = False
| z>=y = False
|otherwise = True 

pertence' z (FF x y) | z==x = True
| z==y = True
| z<x = False 
| z>y = False
|otherwise = True

pertence' z (AF x y ) |z<=x = False
| z> y = False
|otherwise = True

pertence' z (FA x y) |z<x = False
| z==y = True
| z>y = False
|otherwise = True

pertence' z (Uniao (AA x y) (AF xs ys)) | z <= x = False
| z > ys = False
| otherwise = True

--2)c)
tira :: Double -> SReais -> SReais 
tira z (AA x y) | z == x = (AA (x+1) y)
| z== y = (AA x (y-1))
|otherwise = (AA x y)

tira z (FF x y) | z == x = (AA (x+1) y)
| z== y = (AA x (y-1))
|otherwise = (AA x y) 

tira z (AF x y) | z == x = (AA (x+1) y)
| z== y = (AA x (y-1))
|otherwise = (AA x y) 

tira z (FA x y) | z == x = (AA (x+1) y)
| z== y = (AA x (y-1))
|otherwise = (AA x y) 

tira z (Uniao (AA x y) (AA xs ys)) | z==x = Uniao (AA (x+1) y )(AA xs ys)
| z==ys = Uniao (AA x y) (AA xs (ys-1))

data RTree a = R a [RTree a]

--3)a)
percorre :: Int -> RTree a -> [a]
percorre n (R v l) = v: concat (map(percorre(n+1))l)

percorre' :: [Int]->RTree a -> [a]
percorre' [] (R v l)= []
percorre' list (R v l)= v: concat(map(percorre'(list))l)

percorre1 ::[Int]->RTree a -> Maybe [a]
percorre1 [] (R v l)= Nothing
percorre1 list (R v l)= Just (v: concat(map(percorre'(list))l))

rTree1 :: RTree Int
rTree1 = R 1 [R 2 [], R 3 [R 4 [], R 6 []], R 5 [R 10 [], R 11 [R 1 [], R 2 [R 3 [R 2 []]], R 6 []]]]
rTree2 :: RTree Int 
rTree2 = R 1 [R 2 [], R 1 [], R 7 []]

--Outra solução:
percorre n (R x l) = aux n (R x l) [] where
aux [] (R x l) valido = Just (reverse (x:valido))
aux (h:ts) (R x l) valido = if (h <= length l) then aux ts (l !! (h-1)) (x:valido) else Nothing

--3)b)
procura :: Eq a => a -> RTree a -> Maybe [Int]
procura x (R y l) | x==y = Just []
procura x (R y []) | x/=y = Nothing
procura x (R y (h:t)) = case (procura x h) of
Just c -> Just (1:c)
Nothing -> case (procura x (R y t)) of
Nothing -> Nothing
Just [] -> Just []
Just (n:ns) -> Just ((n+1):ns)
