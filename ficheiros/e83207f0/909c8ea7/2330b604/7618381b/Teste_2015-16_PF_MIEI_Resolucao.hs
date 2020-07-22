
-- 1) a)
mynub :: Eq a => [a] -> [a]
mynub []=[]
mynub (h:t) = aux [h] t
where aux :: Eq a =>[a] -> [a]->[a]
aux a [] = a
aux a (h:t) = if (elem h a) then aux a t else aux (a++[h]) t

-- 1) b)
myzipWith :: (a->b->c) -> [a] -> [b] -> [c]
myzipWith a [] c = []
myzipWith a b [] = []
myzipWith a (h:t) (x:xs) = a h x : myzipWith a t xs

-- 2)
type MSet a = [(a,Int)]

-- 2) a)
converte :: Eq a => [a] -> MSet a
converte [] = []
converte (h:t) = (h, 1 + ( length ( filter ( h == ) t ) ) ) : converte (filter (h/=) t)

-- 2) b)
intersect :: Eq a => MSet a -> MSet a ->MSet a 
intersect [] b = []
intersect a [] = []
intersect (h:t) b = if (length rep == 0 ) then intersect t b else (devolveMset h compara): intersect t b
where rep = filter (\l -> fst h == fst l) b
compara = head rep

devolveMset ::Eq a => (a,Int) -> (a,Int)->(a,Int)
devolveMset (a,b) (c,d) = if (b<=d) then (a,b) else (c,d)

-- 3)
data Prop = Var String | Not Prop | And Prop Prop | Or Prop Prop
p1 :: Prop
p1 = Not (Or (And (Not (Var "A")) (Var "B")) (Var "C"))

-- 3) a)
instance Show Prop where
show (Var s) = s
show (Not a) = "-"++show a
show (And a b) = "("++ show a ++" And "++ show b ++ " )"
show (Or a b) = "("++ show a ++" Or "++ show b ++ " )"

-- 3) b)
eval :: [(String,Bool)] -> Prop -> Bool
eval s (Var a) = propBool s a
eval s (Not p) = not (eval s p)
eval s (And p1 p2) = (eval s p1) && (eval s p2)
eval s (Or p1 p2) = (eval s p1) || (eval s p2)

propBool :: [(String,Bool)] -> String -> Bool
propBool s v = bool
where var = filter (\l -> fst l == v) s
bool = snd (head var)

-- 3) c)
nnf :: Prop -> Prop
nnf (Not (Var a)) = Not (Var a)
nnf (Not (Not a)) = nnf a
nnf (Not (And a b)) = nnf (Or (Not a) (Not b))
nnf (Not (Or a b)) = nnf (And (Not a) (Not b))
nnf (Var a) = Var a
nnf (And a b) = And (nnf a) (nnf b)
nnf (Or a b) = Or (nnf a) (nnf b)

-- 3) d)
avalia :: Prop -> IO Bool
avalia p = do l <- avaliaAux p (listOfVariables p)
return $ eval l p

listOfVariables :: Prop -> [String]
listOfVariables (Var a) = [a]
listOfVariables (Not a) = listOfVariables a
listOfVariables (And a b) = listOfVariables a ++ listOfVariables b
listOfVariables (Or a b) = listOfVariables a ++ listOfVariables b

avaliaAux :: Prop -> [String] -> IO [(String,Bool)]
avaliaAux p [] = return []
avaliaAux p (h:t) = do putStr ("Insira um valor para " ++ h ++ " (clique V se for verdadeiro, clique outra tecla para falso) \n")
x <- getChar
y <- avaliaAux p t
putStr "\n"
if x == 'V' || x == 'v' then return ((h,True):y) else return ((h,False):y)
