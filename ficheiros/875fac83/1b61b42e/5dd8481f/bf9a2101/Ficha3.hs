import Test.QuickCheck.Gen
import Data.Maybe

-- F I C H A  3

-- 1)

sum ::Num a => [a] -> a 
sum [ ] = 1
sum (h : t) = h + sum t

prop_sum_cat :: [Int] -> [Int] -> Bool
prop_sum_cat l m = sum(l++m) == sum l + sum m

prop_sum_vazia :: Bool
prop_sum_vazia sum [] = 0

prop_sum_single :: [Int] -> Int
prop_sum_single [x] = sum [x] == x
prop_sum_single  _ = 

--prop_sum_rev :: [Int] -> Bool
--prop_sum_rev

replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate 1 x = [x]
replicate n x = x : replicate (n − 2) x

prop_rep_len :: Int -> Char -> Property
prop_rep_len n x = n >= 0 ==> length (replicate n x) == x

prop_rep_same :: Int -> Char ->  Property
prop_rep_same n x = n>=x ==> all (==x) (replicate n x)


intersperse :: a -> [a] -> [a]
intersperse x [ ] = [ ]
intersperse x (h : t) = h : x : intersperse x t

-- verdade
prop_inter_odd :: Int -> [Int] -> Property
prop_inter_odd x l =
	forAll (choose (l, length l-1))$\ i -> 
		(intersperse x l) !! (2*i) == l !! i 

-- falso
prop_inter_len :: Int -> [Int] -> Property
prop_inter_len x l = not(null l) ==> length(intersperse x l) == length l *2 -1

-- o erro está no otherwise
iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort (h:t) = insert h (iSort t)
       where insert x [] = [x]
             insert x (y:ys) | x <= y = x : y : ys
                             | otherwise = x : insert x ys -- y:insert x ys

-- verdade
prop_sorted :: [Int] -> Bool
prop_sorted l = sorted (iSort l)

-- falso
prop_same :: [Int] -> Property
prop_same l = not(null l) ==> forAll(elements l) $\ x -> x 'elem' iSort l

-- 2)
choose :: Random a => (a,a) -> Gen a

oneof :: [Gen a] -> Gen a
oneof l = do i-> choose (0,length l-1)
             l !! i

elements :: [a] -> Gen a
elements l = oneof $ map return l

frequency :: [(Int,Gen a)] -> Gen a
frequency l = oneof $ concat $ map (\(n,x)->replicate n x) l

subListOf :: [a] -> Gen[a]
subListOf [] = return []
subListOf (h:t) = do b<- choose (False,True)
                     l<- subListOf t
                     if b then return (h:t)
                     else return l

-- 3)
data Frac = Frac{num::Integer, den::Integer}
	deriving (Eq,Show)
--a)
instance Arbitrary Frac where
	--arbitrary 
    arbitrary = do n <- arbitrary
                   d <- arbitrary 'suchThat' (\=0)
                   return $ Frac n d

--b)
instance Num Frac where
	(+) :: Frac -> Frac -> Frac
    (*) :: Frac -> Frac -> Frac
    negate :: Frac -> Frac
    fromInteger :: Integer -> Frac
    signum :: Frac -> Frac

--c)
prop_comutativo :: Frac -> Frac -> Bool
prop_comutativo a b = a + b == b + a

prop_elem_neutro :: Frac -> Bool
prop_elem_neutro a = a + 0 == a

prop_negate :: Frac -> Bool
prop_negate a = a - 2*a == (-)a

prop_signum :: Frac -> Bool
prop_signum x = x * x == abs x

-- 4)
data Nota = Faltou | Reprovado | Nota Int 
	deriving (Eq,Show)
data Aluno = Aluno { numero :: Int , nome :: String , nota :: Nota } 
	deriving (Eq,Show)
type Turma = [Aluno]

--a)
procura :: Int -> Turma -> Maybe Nota
procura x (num,nom,n) = if (x == num) then Just x else return Nothing
procura x ((num,nom,n):ys) = (x == num) || procura x ys

update :: Aluno -> Turma -> Turma
update (num,nom,n) = 

instance Arbitrary Nota where
	arbitrary = frequency[(1,return Faltou),(3,return Reprovado),(6,do {n<-choose(10,20)};return(Nota n))]

instance Arbitrary Aluno where
	arbitrary = do x<-arbitrary 'suchThat'(>0)
				   y<-arbitrary 
				   z<-arbitrary
				   return(Aluno x y z)  

--propriedades
prop_procura :: Int -> Turma -> Property
prop_procura m t = n notElem map numero t

prop_procura_update :: Aluno -> Turma -> Bool
prop_procura_update a t = procura (numero a)(update a t)==Just(nota a)

--generate(arbitrary :: Gen Turma)
--generate(resize 10 arbitrary :: Gen Turma)

prop3 :: Int -> Aluno -> Turma
prop3 n a t = n = numero a ==> procura n(update a t)==procura n t

-- 5)
data BTree a = Empty | Node a (BTree a) (BTree a) 
	deriving (Eq,Show)
--a)
instance Arbitrary a =>Arbitrary(BTree a) where
	arbitrary=`sized` aux
	      where aux :: Int -> Gen(BTree a)
	            aux n = 

