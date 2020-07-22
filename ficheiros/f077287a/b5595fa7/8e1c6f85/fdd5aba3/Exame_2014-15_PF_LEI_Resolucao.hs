
-- 1)
type TurmaL = [(Numero, Aluno)]
type Aluno = (Nome, Nota)
type Numero = Int
type Nome = String
type Nota = Float

-- a)
taxaAp :: TurmaL -> Float 
taxaAp [] = 0
taxaAp turma = (aux turma / todos turma)

aux :: TurmaL -> Float
aux [] = 0
aux ((nr, (nome, nota)):r) = if (nota >= (9.5)) then 1 + aux r else aux r

todos :: TurmaL -> Float
todos [] = 0
todos ((nr, (nome, nota)):r) = if (notaValida nota) == True then 1 + todos r else todos r

notaValida :: Nota -> Bool
notaValida x = if x >= 0 && x<= 20 then True else False
notaValida _ = False

-- b)
top :: Int -> TurmaL -> [String]
top n [] = []
top n ((nr, (nome, nota)):r) = nomes n (ordena ((nr, (nome, nota)):r))

nomes :: Int -> TurmaL -> [String]
nomes 0 _ = []
nomes x ((nr, (nome, nota)):r) = nome : nomes (x-1) r

ordena :: TurmaL -> TurmaL
ordena [] = []
ordena ((nr, (nome, nota)):r) = aux2 (nr, (nome, nota)) (ordena r) 

aux2 :: (Numero, Aluno) -> TurmaL -> TurmaL
aux2 (nr, (nome, nota)) [] = []
aux2 (nr, (nome, nota)) ((n, (a,c)):r) = if nota > c 
then (nr, (nome, nota)) :((n, (a,c)):r)
else ((n, (a,c)) : (aux2 (nr, (nome, nota)) r))

-- c)
nomeMax :: TurmaL -> Int
nomeMax [] = 0
nomeMax turma = maximum (map ((a, (b,c)) -> length c)) turma

-- d)
listaT :: TurmaL -> IO ()
listaT [] = return ()
listaT ((nr, (nome, nota)):r) = do putStrLn ((show nr) ++ " ")
putStrLn (espacos (nome) (length nome))
if nota >= 9.5 
then putStrLn (show (round nota))
else putStrLn "R"
listaT r

espacos :: String -> Int -> String
espacos s n = s ++ (replicate (n-(length s)) ' ')

-- 2)
data TurmaA = Al (Numero, Aluno)
| Fork (Numero, Numero) TurmaA TurmaA

-- a)
toList :: TurmaA -> TurmaL
toList (Al (nr, aluno)) = [(nr, aluno)]
toList (Fork r e d) = toList e ++ toList d

fromList :: TurmaL -> TurmaA
fromList [x] = Al x
fromList l = Fork (mi, ma) (fromList esq) (fromList dir) where

mi = minimum (map (fst) l)
ma = maximum (map (fst) l)
n = div (length l) 2
esq = take n l
dir = drop n l

-- b)

-- c)
remove :: TurmaA -> Numero -> Maybe TurmaA
remove (Al (x,y)) n = if n == x then Just (Al (x,y)) else Nothing
remove (Fork r e d) n = altera e n

altera :: TurmaA -> Numero -> Maybe TurmaA
altera (Fork r (Al (x,y)) (Al (a,b))) n | x == n = Just (Al (a,b)) 
| x == d = Just (Al (x,y))
| otherwise = Just (Fork r (Al (x,y)) (Al (a,b)))
altera (Fork r e d) n = (Fork r (altera e n) (altera d n))

-- d)
