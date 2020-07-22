module Rec2009 where 


participou :: String -> [(String, Int)]
participou [] = []
participou l = let linel = lines l ;
				   filta = filtraalunos linel ;
				   listaNUM = transformaNUM filta ;
				   listaord = isort listaNUM
				    in tratapresen listaord				


filtraalunos :: [String] -> [String]
filtraalunos [] = []
filtraalunos (h:t) |(head h) /= '-' = h:filtraalunos t
				   |otherwise = filtraalunos t
				   
				   
transformaNUM :: [String] -> [Int]
transformaNUM [] = []
transformaNUM (h:t) = (read h):transformaNUM t 

isort [] = []
isort (h:t) = insert h (isort t)
			 where insert x [] = [x] ;
				   insert x (y:ys) = if x < h then x:y:ys else y:(insert x ys) 

tratapresen :: [Int] -> [(String,Int)]
tratapresen [] = []
tratapresen (h:t) = (show h,1+length x):tratapresen y 
					where (x,y) = span (==h) t
					
					
--2

data AG = Pessoa Nome Pai Mae
		 | Desconhecida
	  deriving Show
type Pai = AG
type Mae = AG
type Nome = String
					
					
nomesMF :: AG -> ([Nome],[Nome])
nomesMF Desconhecida = ([],[])
nomesMF (Pessoa n p m) = let (x,y) = nomesP p ;
                             (x1,y1) = nomesM m
                          in  (x++x1,y++y1) 					


nomesP :: AG -> ([Nome],[Nome])
nomesP Desconhecida =  ([],[])
nomesP (Pessoa n p m) = let (x,y) = nomesP p ;
                            (h,t)=  nomesM m in
                             (n:(x++h),y++t)
                        

nomesM :: AG -> ([Nome],[Nome])
nomesM Desconhecida =  ([],[])
nomesM (Pessoa n p m) = let (x,y) = nomesP p ;
                            (h,t)=  nomesM m in
                             (x++h,n:(y++t))
                             

avos :: Nome -> AG -> [Nome]
avos n a = let subarv = gerasubArv n a in nomeavos subarv 2
        

gerasubArv :: Nome -> AG -> AG
gerasubArv _ Desconhecida = Desconhecida
gerasubArv i (Pessoa n p m) = let f = gerasubArv i p ;
							      g = gerasubArv i m
							      in if i == n then (Pessoa n p m) else trata f g 
							      
trata :: AG -> AG -> AG
trata n Desconhecida = n
trata Desconhecida n = n 				

nomeavos :: AG -> Int -> [Nome]	
nomeavos Desconhecida n = []									 
nomeavos (Pessoa n p m) 0 = [n]
nomeavos (Pessoa n p m) x = (nomeavos p (x-1))++(nomeavos m (x-1))       

grau :: AG -> Nome -> Maybe Int
grau Desconhecida _ = Nothing
grau a n = let p = grauaux a n 0 in if p == -1 then Nothing else Just p 


grauaux :: AG -> Nome -> Int -> Int
grauaux Desconhecida _ _ = -1
grauaux (Pessoa n p m) i v = let f = grauaux p i (v+1)  ;
							     g = grauaux m i (v+1)
							      in if i == n then v else max f g      



