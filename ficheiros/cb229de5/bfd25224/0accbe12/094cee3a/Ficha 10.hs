
-- Pergunta 1:
import System.Random
randomIO :: Random a => IO a
randomRIO :: Random a => (a,a) -> IO

-- Alínea a)
bingo :: IO ()
bingo = do putStrLn "Prima enter para obter um número"
      = bingoCT 0 []

bingoCT :: Int -> [Int] -> IO ()
bingoCT n t | n==90 = return ()
	    | n<90 = do getchar
		     x <- getNewNum t
		     bingoCT (n+1)(x:t)

getNewNum :: [Int] -> IO Int
getNewNum t = do n <- randomRIO (1,90)
		 if n 'elem' t then getNewNum t
			       else return n

-- Alínea b)

-- Pergunta 2:
data Aposta = Ap [Int] (Int,Int)

-- Alínea a)

-- Função pré-definida:
-- all :: (a -> Bool) -> [a] -> Bool
-- all p [] = True
-- all p (x:xs) = if p x then all p:xs
--			 else False

valida :: Aposta -> Bool
valida (Ap l (a,b)) = (all (\x->x>=1 && x<=50) l) && semRep l && (length l)==5 && a/=b && (elem a [1..12]) && (b>=1) && (b<=12)

semRep :: Eq => [a] -> Bool
semRep [] = True
semRep (x:xs) = if (elem x xs) then False
			       else semRep xs

-- Alínea b)
comuns :: Aposta -> Aposta -> (Int,Int)
comuns (Ap l (a,b)) (Ap nums (e1,e2)) = (calc l nums,calc [a,b][e1,e2])

calc :: [Int] -> [Int] -> Int
calc []l = 0
calc (x:xs) l = if x 'elem' l then 1+calc xs l
			      else calc xs l

-- Alínea c)
-- i)
instance Eq Aposta where
	a==b = (comuns a b)==(5,2)

--ii)
premio :: Aposta -> Aposta -> Maybe Int
premio a b = case (comuns a b) of
		  (5,2) -> Just 1
		  (5,1) -> Just 2
		  (5,0) -> Just 3
		  (4,2) -> Just 4
		  (4,1) -> Just 5
		  (4,0) -> Just 6
		  (3,2) -> Just 7
		  (2,2) -> Just 8
		  (3,1) -> Just 9
		  (3,0) -> Just 10
		  (1,2) -> Just 11
		  (2,1) -> Just 12
		  (2,0) -> Just 13
		   _	-> Nothing

-- Alínea d)
-- i)
data Aposta = Ap [Int](Int,Int)
	deriving Read

leAposta :: IO Aposta
leAposta = do putStr "Insira a aposta no formato (Ap [n,n,n,n,n](e,e))"
	   l <- get
	   ap <- (madIO l) :: Aposta
	   if (valida ap) then return ap
			  else do putString "Aposta inválida"
				  leAposta

-- ii)
joga :: Aposta -> IO ()
joga ch = do ap <- leAposta
	     case (premio ap ch) of
		  (Just n) -> putStr "O seu prémio é " ++ (show n)
		  Nothing  -> putStr "Sem prémio"

-- Alínea e)
geraChave :: IO Aposta
geraChave = do nums <- geraNum 5 []
	       est <- geraEstrelas
	       return (Ap num estr)

geraNum :: Int -> [Int] -> IO [Int]
geraNum 0 l = return l
geraNum n l = do x <- randomRIO (1,50)
	         if (x 'elem' l) then gearNum n l
				 else geraNum (n-1)(x:l)

geraEstrelas :: IO (int,Int)
geraEstrelas = do e1 <- randomRIO (1,12)
		  e2 <- randomRIO (1,12)
		  if e1==e2 then geraEstrelas
			    else return (e1,e2)

-- Alínea f)
main :: IO ()
main = do ch <- geraChave
	  ciclo ch

ciclo :: Aposta -> IO ()
ciclo ch = do 5 <- menu
	      case 5 of
		   ('1':_) -> do joga ch
				 ciclo ch
		   ('2':_) -> do ch' <-geraChave
				 ciclo ch
		   ('0':_) -> return ()
		      _    -> ciclo ch

menu :: IO String
menu = do { putStrLn menutxt
	  ; putStr "Opcao: "
	  ; c <- getLine
	  ; return c
	  }
     where menutxt = unlines ["",
			      "Apostar ........... 1",
			      "Gerar nova chave .. 2",
			      "",
			      "Sair .............. 0"]

