module Examelesi1 where

--I

type Data = (Int,Int,Int)
type TempMin = Int
type TempMax = Int
type Registo = (Data,TempMin,TempMax)

data Temperaturas = Vazia | Nodo Registo Temperaturas Temperaturas

--1

dia1 :: Temperaturas
dia1 = Nodo ((06,01,06),10,25) Vazia (Nodo ((07,01,06),15,30) Vazia (Nodo ((08,01,06),10,40) Vazia Vazia))

temps :: Temperaturas -> Data -> Maybe (TempMin,TempMax)
temps Vazia a = Nothing 
temps (Nodo (x,y,z) esq dir) a = if (a==x) then Just (y,z)
					   else if (a>x) then temps dir a
							 else temps esq a

--2

maxTemp :: Temperaturas -> TempMax
maxTemp Vazia = error "Give me a tree!"
maxTemp (Nodo (x,y,z) Vazia Vazia) = z
maxTemp (Nodo (x,y,z) esq dir) = max z (maxTemp dir)

--3

instance Show Temperaturas where
 show Vazia = ""
 show (Nodo a esq dir) = show esq++show a++"\n"++show dir

--II

--1

g :: String -> IO (Int)
g s = do { putStrLn s ;
          x <- getLine ;
          return ((read x):: Int)
         }                    

--2

f :: Bool -> IO ()
f a = do { x <- g "numero1"; 
	   y <- g "numero2";
          case a of
           True -> do {putStrLn ("SOMA:"++(show (x+y)));
                    return ()
                   }
           False -> do {putStrLn ("SUBTRACAO:"++(show (x-y)));
                    return ()
                    }

--3

menu :: IO ()
menu = do {putStrLn (unlines ["----------------------",
                            "        MENU          ",
                            "		           ",
                            " 1 - Soma             ",
                            "                      ",
                            " 2 - Subtracao        ",
                            "                      ",
                            "                      ",
                            "----------------------"]);
     	   putStrLn "Opcao: ";
	   x <- getLine;
	   case x of
              "1" -> f True
              "2" -> f False
           }

--III

split :: (a -> Bool) -> [a] -> ([a],[a])
split p l = foldr f ([],[]) l
  where   f x (s,n) = if (p x) then (x:s,n) else (s,x:n)

sep n m = split (\x -> x < n) [0..m]

--crescente l = split (\x -> x >= 0) [0..l]











