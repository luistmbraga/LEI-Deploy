import Data.Char
import Data.List

-- 1
myEnumFromTo :: Int -> Int -> [Int]
myEnumFromTo a b
    | a == b = a : []
    | a < b = a : (myEnumFromTo (a+1) b)
    | otherwise = []
  
-- 2
myEnumFromThenTo :: Int -> Int -> Int -> [Int]
myEnumFromThenTo a b c
    | a>c && a<b = []
    | c>a && a>b = []
    | a==b && a<=c = repeat a
    | a==b && a>c = []
    | a<b && b>c = [a]
    | a>b && b<c = [a]
    | otherwise = a:myEnumFromThenTo b (b+(b-a)) c

-- 3
(+++) :: [a] -> [a] -> [a]
(+++) [] l = l
(+++) (h1:t1) l2 = h1 : ((+++) t1 l2)

-- 4
myLast :: [a] -> a
myLast [a] = a
myLast (h:t) = myLast t

-- 5
myInit :: [a] -> [a]
myInit [a] = []
myInit (h:t) = h:myInit t

--6
(.!!) :: [a] -> Int -> a
(.!!) (h:t) 0 = h
(.!!) (h:t) i = (.!!) t (i-1)

--7
myReverse :: [a] -> [a]
myReverse [] = []
myReverse l = myLast l:myReverse (myInit l)

--8
myTake :: Int -> [a] -> [a]
myTake 0 _ = []
myTake _ [] = []
myTake x (h:t) =
    if x>0
    then h:myTake (x-1) t
    else []

--9
myDrop :: Int -> [a] -> [a]
myDrop 0 l = l
myDrop _ [] = []
myDrop x (h:t) =
    if x>0
    then myDrop (x-1) t
    else (h:t)

--10
myZip :: [a] -> [b] -> [(a,b)]
myZip (x:xs) (y:ys) = (x,y):myZip xs ys
myZip _ _ = []

--11
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (h:t) = x==h || myElem x t

--12
myReplicate :: Int -> a -> [a]
myReplicate 0 _ = []
myReplicate x a =
    if x>0
    then a:myReplicate (x-1) a
    else []

--13
myIntersperse :: a -> [a] -> [a]
myIntersperse _ [] = []
myIntersperse _ [a] = [a]
myIntersperse x (h:t) = h:x:myIntersperse x t

--14
myGroup :: Eq a => [a] -> [[a]]
myGroup [] = []
myGroup l = lst:myGroup (myDrop (length lst) l)
    where lst = mkglist l

mkglist :: Eq a => [a] -> [a]
mkglist [x] = [x]
mkglist (x:x2:t) = if x==x2 then x: mkglist (x2:t) else [x]

--15
myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (h:t) = ((+++) h (myConcat t))

--16
myInits :: [a] -> [[a]]
myInits l = inits_aux 0 l

inits_aux :: Int -> [a] -> [[a]]
inits_aux _ [] = [[]]
inits_aux x l =
    if x<length l
    then myTake x l : inits_aux (x+1) l
    else [l]

--17
myTails :: [a] -> [[a]]
myTails l = tails_aux 0 l

tails_aux :: Int -> [a] -> [[a]]
tails_aux _ [] = [[]]
tails_aux x l = 
    if x<length l
    then myDrop x l : tails_aux (x+1) l
    else [[]]

--18
myIsPrefixOf :: Eq a => [a] -> [a] -> Bool
myIsPrefixOf [] _ = True
myIsPrefixOf _ [] = False
myIsPrefixOf l1 l2 = myElem l1 $ myInits l2


--19
myIsSuffixOf :: Eq a => [a] -> [a] -> Bool
myIsSuffixOf [] _ = True
myIsSuffixOf _ [] = False
myIsSuffixOf l1 l2 = myElem l1 $ myTails l2

--20
myIsSubsequenceOf :: Eq a => [a] -> [a] -> Bool
myIsSubsequenceOf [] _ = True
myIsSubsequenceOf _ [] = False
myIsSubsequenceOf (x:xs) (y:ys) =
    if x==y
    then myIsSubsequenceOf xs ys
    else myIsSubsequenceOf (x:xs) ys

--21
myElemIndices :: Eq a => a -> [a] -> [Int]
myElemIndices _ [] = []
myElemIndices x l = elemIndexAux 0 x l

elemIndexAux :: Eq a => Int -> a -> [a] -> [Int]
elemIndexAux _ _ [] = []
elemIndexAux i x (h:t) =
    if x==h
    then i:elemIndexAux (i+1) x t
    else elemIndexAux (i+1) x t

--22
myNub :: Eq a => [a] -> [a]
myNub [] = []
myNub (h:t) = h: myNub ((myRemove h t))

myRemove :: Eq a => a -> [a] -> [a]
myRemove _ [] = []
myRemove x (h:t) =
    if h==x
    then (myRemove x t)
    else h:(myRemove x t)

--23
myDelete :: Eq a => a -> [a] -> [a]
myDelete _ [] = []
myDelete x l = myDeleteAux x l []

myDeleteAux :: Eq a => a -> [a] -> [a] -> [a]
myDeleteAux _ [] _ = []
myDeleteAux x [y] l2
    | myElem x l2 = [y]
    | x==y = []
    | otherwise = [y]
myDeleteAux x (h:t) l2 =
    if myElem x l2
    then h:myDeleteAux x t l2
    else if x==h
         then myDeleteAux x t (x:l2)
         else h:myDeleteAux x t l2

--24
(\\\) :: Eq a => [a] -> [a] -> [a]
(\\\) l [] = l
(\\\) [] _ = []
(\\\) l1 (h:t) = ((\\\) (myDelete h l1) t)

--25
myUnion :: Eq a => [a] -> [a] -> [a]
myUnion [] l = noRepeats l
myUnion l [] = l
myUnion l (h:t) =
    if myElem h l
    then myUnion l t
    else myUnion ((+++) l [h]) t

noRepeats :: Eq a => [a] -> [a]
noRepeats [] = []
noRepeats (h:t) =
    if myElem h t
    then h:noRepeats (myRemove h t)
    else h:noRepeats t
--26
myIntersect :: Eq a => [a] -> [a] -> [a]
myIntersect [] _ = []
myIntersect _ [] = []
myIntersect (h:t) l2 =
    if myElem h l2
    then h:(myIntersect t l2)
    else myIntersect t l2

--27
myInsert :: Ord a => a -> [a] -> [a]
myInsert x [] = [x]
myInsert x (h:t) =
    if x<h
    then x:h:t
    else h:(myInsert x t)

--28
myMaximum :: Ord a => [a] -> a
myMaximum [] = undefined
myMaximum (h:t) = maxAux h t

maxAux :: Ord a => a -> [a] -> a
maxAux x [] = x
maxAux x (h:t) =
    if x>=h
    then maxAux x t
    else maxAux h t

--29
myMinimum :: Ord a => [a] -> a
myMinimum [] = undefined
myMinimum (h:t) = minAux h t

minAux :: Ord a => a -> [a] -> a
minAux x [] = x
minAux x (h:t) =
    if x<=h
    then minAux x t
    else minAux h t

--30
mySum :: Num a => [a] -> a
mySum [] = 0
mySum (h:t) = h + mySum t

--31
myProduct :: Num a => [a] -> a
myProduct [] = 1
myProduct (h:t) = h * myProduct t

--32
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (h:t) = h && myAnd(t)

--33
myOr :: [Bool] -> Bool
myOr [] = False
myOr (h:t) = h || myOr(t)

--34
myUnwords :: [String] -> String
myUnwords [] = ""
myUnwords [x] = x
myUnwords (h:t) = (+++) ((+++) h " ") (myUnwords t)

--35
myUnlines :: [String] -> String
myUnlines [] = ""
myUnlines [x] = (+++) x "\n"
myUnlines (h:t) = (+++) ((+++) h ['\n']) (myUnlines t)

--36
pMaior :: Ord a => [a] -> Int
pMaior [] = undefined
pMaior (h:t) = pMaiorAux 0 0 h t

pMaiorAux :: Ord a => Int -> Int -> a -> [a] -> Int
pMaiorAux i _ _ [] = i
pMaiorAux i j x (h:t) =
    if x>=h
    then pMaiorAux i (j+1) x t
    else pMaiorAux (j+1) (j+1) h t

--37
temRepetidos :: Eq a => [a] -> Bool
temRepetidos [] = False
temRepetidos (h:t) = myElem h t || temRepetidos t

--38
algarismos :: [Char] -> [Char]
algarismos [] = []
algarismos (h:t) =
    if isDigit(h)
    then h:algarismos t
    else algarismos t

--39
posImpares :: [a] -> [a]
posImpares [] = []
posImpares l = posImpAux False l

posImpAux :: Bool -> [a] -> [a]
posImpAux _ [] = []
posImpAux True (h:t) = h:posImpAux False t
posImpAux False (h:t) = posImpAux True t

--40
posPares :: [a] -> [a]
posPares [] = []
posPares l = posParesAux True l

posParesAux :: Bool -> [a] -> [a]
posParesAux _ [] = []
posParesAux True (h:t) = h:posParesAux False t
posParesAux False (h:t) = posParesAux True t

--41
isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (h:j:t) = h<=j && isSorted (j:t)

--42
iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort l =
    if isSorted l
    then l
    else m:iSort (myDelete m l)
        where m = myMinimum l
--43
menor :: String -> String -> Bool
menor _ [] = False
menor [] _ = True
menor (h1:t1) (h2:t2)
    | ord(h1)<ord(h2) = True
    | ord(h1)>ord(h2) = False
    | otherwise = menor t1 t2
-- >>> menor "a" "B" = False (estupido, mas e o que o Codeboard pede)

--44
elemMSet :: Eq a => a -> [(a,Int)] -> Bool
elemMSet _ [] = False
elemMSet x (h:t) = x==(fst h) || elemMSet x t

--45
lengthMSet :: [(a,Int)] -> Int
lengthMSet [] = 0
lengthMSet (h:t) = snd(h) + lengthMSet t

--46
converteMSet :: [(a,Int)] -> [a]
converteMSet [] = []
converteMSet (h:t) = ((+++) (myReplicate (snd h) (fst h)) (converteMSet t))

--47
insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet x [] = [(x,1)]
insereMSet x (h:t) =
    if x==(fst h)
    then (x, (snd h)+1):t
    else h:insereMSet x t

--48
removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet x (h:t) =
    if x==(fst h)
    then if (snd h) == 1
         then t
         else (x, (snd h)-1):t
    else h:(removeMSet x t)

--49
constroiMSet :: Ord a => [a] -> [(a,Int)]
constroiMSet [] = []
constroiMSet x = cMSetAux [] x

cMSetAux :: Eq a => [(a,Int)] -> [a] -> [(a,Int)]
cMSetAux x [] = x
cMSetAux x (h:t) = cMSetAux (insereMSet h x) t

--50
somaPares :: [Int] -> Int
somaPares [] = 0
somaPares (h:t) =
    if mod h 2 == 0
    then h + somaPares t
    else somaPares t
