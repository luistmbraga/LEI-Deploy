module Ficha10 where

import System.Random
import Random


putStre :: String -> IO ()
putStre [] = return ()
putStre (x:xs)= (putChar x) >> (putStre xs)



pergunta :: String -> IO String
pergunta l = (putStr l) >> (putChar '?') >> getLine

perguntar p = do{_ <- putStr p;
					  _ <- putChar '?';
					  x <- getStr;
					
					 return x
				    }
				
getStr :: IO String
getStr = do{ c <- getChar;
				if (c == '\n') then return " " else do{t <- getStr;
																	return (c:t)
																	}
			   }
--------------------------------------------------------------------------------------

game1 :: Int -> IO ()
game1 n = do putStr "Escolha um Numero: "
				 ; r1 <- getStr
				 ; let r2 = read r1
					in if (r2 == n) then putStrLn "√ - Ganhou"
						else if (r2 < n) then do putStrLn "Pequeno Demais"
														 ; game1 n
						else do putStrLn "Grande Demais"
								  ; game1 n
								
{-game2 :: Int -> Int -> IO ()
game2 i s = do 	p <- randomRIO (i,s)
						; putStrLn "Escolha um Numero entre: "
						; r1 <- getLine
						; let r2 = read r1
							in if (r2 == p) then putStrLn "√ - Ganhou"
								else if (r2 < p) then do putStrLn "Pequeno Demais"
																; game2 i s
								else do putStrLn "Grande Demais"
										  ; game2 i 
-}
------------------------------------------------------------------------
--1
--a
bingo :: IO()
bingo = do bingoaux []    
                
bingoaux :: [Int] -> IO()
bingoaux l = do {if length l == 90 then do {putStrLn "JÁ SAIRAM TODOS OS NUMEROS"
														 ; return ()
														 } 
															else do {n <- randomRIO (1,90) ;
                   								
			    if (elem n l) then bingoaux l else do {putStrLn "Prima Enter" ;
                           								 getChar ;
                           								 putStrLn (show n) ;
                           								 bingoaux (n:l)
                          									}
														 }
				  }
--2
data Aposta = Ap [Int] (Int,Int)

--a
valida :: Aposta -> Bool
valida (Ap t (a,b)) = (length t == 5) && (vaux t (a,b)) 

vaux :: [Int] -> (Int,Int) -> Bool
vaux [] (_,_) = True
vaux (x:xs) (a,b) = (x>= 1 && x<=50) && (not (elem x xs)) && (vaux xs (a,b)) && (a >= 1 && a <=9) && (b >= 1 && b <= 9) && (a /= b)

--b
comuns :: Aposta -> Aposta -> (Int,Int)
comuns (Ap x (a,b)) (Ap y (c,d)) = (comunsAux1 x y, comunsAux2 (a,b) (c,d))

comunsAux1 :: [Int] -> [Int] -> Int 
comunsAux1 _ _ = 0
comunsAux1 (x:xs) l = if (elem x l) then 1 + (comunsAux1 xs l) else comunsAux1 xs l

comunsAux2 :: (Int,Int) -> (Int,Int) -> Int
comunsAux2 (a,b) (c,d) | (a == c) || (a == d) && (b == c) || (b == d) = 2
							  | (a == c) || (a == d) || (b == c) || (b == d) = 1
							  | otherwise = 0
