--Parte 1
--1)

type MSet a = [(a,Int)]

--a)

melem x m = not (null (filter (aux x) m))
   where aux x (y,z) = x == y

-- [('a',3),('b',4),('c',1),('d',5)]

--b)

melem' x ((y,z):t) = (x == y) || (melem' x t)

--c)

mfilter p [] = []
mfilter p ((x,y):t) = if p (x,y) then (x,y):(mfilter p t) else (mfilter p t)

-- mfilter (\(x,y) -> y <= 2) [('a',3),('b',4),('c',1),('d',5)]

--d)

media :: MSet Float -> Float
media m@((x,y):t) = (aux m)/(fromIntegral (length m))
 where aux [] = 0
       aux ((x,y):t) = x*(fromIntegral y) + (aux t)

-- [(1,3),(2,4),(5,1),(10,5)]

--2)

--a)

data From a = Last a | Next (From a)

topair (Last z) = (z,0)
topair (Next a) = (x,y+1) where (x,y) = topair a

--b)

instance Show a => Show (From a) where
    show (Last a) = (show a)
    show (Next z) = '+':(show z)

--Parte 2

--1)

data List a b = Nil | ConsA a (List a b) | ConsB b (List a b)
   deriving Show

--a)

unzipAB :: List a b -> ([a],[b])

unzipAB (Nil) = ([],[])
unzipAB (ConsA a l) = let (xx,yy) = unzipAB (l) in
                                (a:xx,yy)
unzipAB (ConsB b l) = let (xx,yy) = unzipAB (l) in
                                (xx,b:yy)

-- (ConsB 1 (ConsA 2 (ConsB 3 (Nil))))


--b)

sortA :: (Ord a) => List a b -> List a b
sortA x = zipAB (sortAux (unzipAB x))

sortAux (l1,l2) = (qsort l1,l2)

parte _ [] = ([],[])
parte x (y:ys) | y < x  = (y:as,bs)
               | y >= x = (as,y:bs)
      where (as,bs) = parte x ys

qsort [] = []
qsort (x:xs) = let (l1,l2) = parte x xs
               in (qsort l1)++[x]++(qsort l2)

zipAB ([],[]) = Nil
zipAB ([x],[]) = (ConsA x (Nil))
zipAB ([],[y]) = (ConsB y (Nil))

zipAB ([],y:yy) = (ConsB y (zipAB ([],yy)))

zipAB (x:xx,y:yy) = (ConsA x (zipAB (xx,y:yy)))


-- (ConsA 4 (ConsB 5 (ConsA 3 (ConsA 1 (ConsB 1 (ConsA 6 (Nil)))))))


--2)

pair (0,0) = 0
pair (0,y) = (pair (1,y-1)) + 1
pair (x,y) = (pair (x-1,y)) + x + y

-- Muito ineficiente!

--unpair x = ?




















