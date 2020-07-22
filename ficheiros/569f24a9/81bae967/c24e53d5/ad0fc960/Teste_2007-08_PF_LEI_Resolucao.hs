module Teste_07_08 where

------------PARTE I--------------

---1
parte :: Int -> [Int] -> ([Int],[Int],[Int])
parte _ [] = ([],[],[])
parte n (x:xs) = let (a,b,c) = parte n xs
		 in if n == x then (a,x:b,c)
		    	      else if x < n then (x:a,b,c)
		    			    else (a,b,x:c)

---2
merge :: [Float] -> [Float] -> [Float]
merge [] [] = []
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys) | x <= y = x:(merge xs (y:ys))
		    | otherwise = y:(merge (x:xs) ys) 

---4
type Filme = (Titulo,Realizador,[Actor],Genero,Ano)
type Titulo = String
type Realizador = String
type Actor = String
type Ano = Int
data Genero = Comedia | Drama | Ficcao | Accao | Animacao | Documentario
        deriving Eq
type Filmes = [Filme]


--a) 
doRealizador :: Filmes -> Realizador -> [Titulo]
doRealizador [] _ = []
doRealizador ((a,b,(c:cs),d,e):t) x | x == b = a:(doRealizador t x)
				    | otherwise = doRealizador t x

--b)
doActor :: Filmes -> Actor -> [Titulo]
doActor [] _ = []
doActor ((a,b,l,d,e):t) x = if (elem x l) then a:(doActor t x)
					  else doActor t x


--c) 
consulta :: Filmes -> Genero -> Realizador -> [(Ano, Titulo)]
consulta bd gen rea = map aux (filter (teste gen rea) bd)
         where teste :: Genero -> Realizador -> Filme -> Bool
               teste g r (_,x,_,y,_) = g==y && r==x
               aux :: Filme -> (Ano,Titulo)
               aux (a,b,c,d,e) = (e,a)



-----------------PARTE II---------------------


data Avaliacao = NaoVi | Pontos Int
	deriving Ord
type FilmesAval = [(Filme,[Avaliacao])]


---2
grafico :: Titulo -> FilmesAval -> String
grafico tit (((a,b,c,d,e),(x:xs)):t) | tit == a =  
				     | otherwise = grafico tit t
numAval tit [] = [] 
numAval tit (x:xs) = 

