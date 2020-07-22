import System.Random
import Test.HUnit
import Control.Monad.State.Lazy

-- FICHA 2

--randomIO :: Random a => IO a
--randomRIO :: Random a => (a,a) -> IO a

-- 2)

-- a)
craps:: IO Int
craps = do x <- randomRIO(1,6)
           y <- randomRIO(1,6)
           return(x+y)

-- b)
randomList :: Random a => Int -> IO[a]
randomList 0 = return []
randomList n = do x <- randomIO
                  l <- randomList(n-1)
                  return(x:l)

-- c)
randomPermute :: [a] -> IO[a]
randomPermute [] = return []
randomPermute l = do i <- randomRIO(0,length l - 1)
                     r <- randomPermute (take i l ++ drop(i+1) l)  
                     return ((l!!i:)r)

{--positivo :: IO Int
positivo = do x <- randomIO
           if (x>=0) then return x
              else positivo
--}

positivo2 :: IO Int
positivo2 = do x <- randomIO
               return (abs x)

-- d)
rev :: [a] -> [a]
rev [] = []
rev (h:t) = rev t ++ [h]

frev :: [a] -> [a]
frev l = evalState (aux2 l) []
  where aux2 :: [a] -> State [a] ()
        aux2 [] = return()
        aux2 (h:t) = do s <- get
                        put (h:s)
                        aux2 t

--frev l = foldl (\a h -> h : a) [] l

testa :: Int -> IO()
testa n = do l <- aux n
             runTestTT(TestList l)
aux :: Int -> IO[Int]
aux 0 = return []
aux n = do l <- randomList (n-1)
           t <- aux(n-1)
           return ((frev l::[Int] ~?= rev l) : t)

-- 4)

-- a)
sequence2 :: Monad m => [m a] -> m [a]
sequence2 [] = return []
sequence2 (h:t) = do x <- h
                     l <- sequence2 t
                     return (x:l)

putStr2 :: String -> IO()
putStr2 s = sequence2(map putChar s)
            return()

-- d)
join :: Monad a => m (m a) -> m a
join x = do y <- x
            y