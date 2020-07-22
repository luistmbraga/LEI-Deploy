module Exame1 where
import List
data Frac = F Int Int

--Questão 1

instance Eq Frac where
  (F a b) == (F c d) | a * d == b * c = True
                     | otherwise = False
  x /= y = not (x == y)

instance Ord Frac where
 compare (F a b) (F c d) | a * d > b * c = GT
                          | a * d == b * c = EQ
                          | otherwise = LT

--  o resto fica definido automaticamente

gcd' :: Int -> Int -> Int
gcd' x y = gcdAux x y 1 (max x y)
          where gcdAux x y d n | n == 1 = d
                               | mod x n == 0 && mod y n == 0 = n
                               | otherwise = gcdAux x y d (n-1)


simplifica :: Frac -> Frac
simplifica (F a b) = let divisor = gcd' a b
                     in F (div a divisor) (div b divisor)

--show:

instance Show Frac where
  show (F a b) | b == 1 = show a
               | otherwise = (show a)++"/"++(show b)



--Questão 2

data BTree a = N a (BTree a) (BTree a) | V

arvore = N 1 (N 3 (N 5 V V) (N 4 (N 6 (N 9 V V) (N 8 V V)) (N 7 V V))) (N 2 V V)
cvalido :: BTree a -> [Bool] -> Bool
cvalido V _ = False
cvalido _ [] = True
cvalido (N _ e d) (h:t) | h == True = cvalido d t
                        |otherwise = cvalido e t

selecciona :: BTree a -> [Bool] -> a
selecciona (N x _ _)  [] = x
selecciona (N _ e d)  (bool:t) | bool == True = selecciona d t
                               | otherwise = selecciona e t

procura :: Eq a => BTree a -> a -> Maybe [Bool]
procura V _ = Nothing
procura arv a = procAux arv a []
                where procAux V _ _= Nothing
                      procAux (N x e d) a c | x==a = Just c
                                            | procAux d a (c++[True])==Nothing = procAux e a (c++[False])
                                            | otherwise = procAux d a (c++[True])

--Questão 3

divide:: [Int] -> Int -> ([Int],[Int])
divide l x = divideAux l x 0
             where divideAux l x n | sum l <= x = (l,[])
                                   | sum (take n l) >= x = ((take n l),(drop n l))
                                   | otherwise = divideAux l x (n+1)

menor :: [([Int],[Int])] -> ([Int],[Int])
menor [x] = x
menor ((a,b):xs) = let (c,d) = menor xs
                   in if (sum a) > (sum c) then menor xs else (a,b)

-- Função perms supostamente predefinida =P

perms :: [Int] -> [[Int]]
perms l = (possiveis l)

possiveis :: [a] -> [[a]]
possiveis [x,y] = [[x,y],[y,x]]
possiveis (h:t) = addto h (possiveis t)


addto :: a -> [[a]] -> [[a]]
addto s [] = []
addto s l= coloca s (length (head l)) (head l)++addto s (tail l)

coloca :: a -> Int -> [a] -> [[a]]
coloca s 0 l = [(s:l)]
coloca s pos l =(concat [(take pos l),[s],(drop pos l)]):(coloca s (pos-1) l)

--fim da função perms

--Esta função funciona, porém não é de certeza a forma mais correcta... de qualquer maneira faz o que lhe é pedido, é preciso ver que estou a fazer isto às três da manhã! =P
pertence x []=False
pertence x (y:ys) | x==y = True
                  | otherwise = pertence x ys

melhorEscolha :: [Int] -> Int -> ([Int],[Int])
melhorEscolha cheques valor = let h = fst (menor (map (\a -> valoresmin a valor) (perms cheques)))
                              in (h,filter (\a -> not (pertence a h)) cheques)

valoresmin cheques valor= let l = reverse (fst (divide cheques valor))
                          in ((reverse (somamin l valor [])),(snd (divide cheques valor)))
                             where somamin (x:xs) n ac | (sum ac) + x >= n = ac++[x]
                                                       | otherwise = somamin xs n (ac++[x])
                                  
listar ints = (let usedcheques=concat(map (\a -> (show a)++", ") ints)
               in (take ((length usedcheques)-2) usedcheques))
--pagamento :: [Int] -> IO ([Int])
pagamento cheques = do{
                       putStrLn "Benvindo!\nPor favor, insira a quantia a pagar:";
                       n <- getLine;
                       putStrLn "Cheques necessarios ao pagamento:";
                       putStrLn ((listar (fst(melhorEscolha cheques (read n))))++".");
                       return (snd(melhorEscolha cheques (read n)))
                       }

pagamentoFull cheques = do{
                     ns <- pagamento cheques;
                     putStrLn ("Cheques restantes:\n"++(listar ns)++".\nObrigado e volte sempre!")
                     }

