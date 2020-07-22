
-- Pergunta 1:
max2 :: (Int,Int) -> Int
max2 (x,y) = if x>y then x
		    else y

-- Pergunta 2:
max3 :: Int,Int,Int -> Int
max3 x,y,z = if x>y && x>z then x
			   else if y>= x then y
					 else if z>y then z
						     else y

-- ou:
-- max3 x,y,z = if x>y then if x>z then x
--		       		   else z
--			    else if y>z then y
--					else z

-- ou ainda:
-- max3 x,y,z = max2 (max2 (x,y),z)

-- Pergunta 3:
-- Alínea a)
isLower2 :: Char -> Bool
isLower2 c = ord 'a' <= ord c && ord c <= ord 'z'

-- Alínea b)
isDigit2 :: Char -> Bool
isDigit2 c = ord '0' <= ord c && ord c <= ord '9'

-- Alínea c)
isAlpha2 :: Char -> Bool
isAlpha2 c = (isLower2 c) || (ord 'A' <= ord c && ord c <= ord 'Z')

-- Alínea d)
toUpper2 :: Char -> Char
toUpper2 c = if (isLower2 c) then chr ((ord c)-32) else c -- ou: if (isLower2 c) then chr ((ord 'a')-(ord 'A')) else c

-- Alínea e)
intToDigit2 :: Int -> Char
intToDigit2 c = if ord 'a' <= ord c && ord c <= ord '0' then (ord c)-(ord 'a')
							else error "Não é letra"

-- Alínea f)
digitToInt2 :: Char -> Int
digitToInt2 c = if ord '0' <= ord c && ord c <= ord 'a' then (ord c)-(ord '0')
							else error "Não é dígito"

-- Pergunta 4:
eTriangulo :: (Float,Float,Float) -> Bool
eTriangulo (a,b,c) = (a+b >= c && a+c >= b && b+c >= a) && (a>0 && b>0 && c>0)

-- Pergunta 5:
type Ponto = (Float,Float)

-- Alínea a)

-- Alínea b)


-- Pergunta 6:
nRaizes :: Float -> Float -> Float -> Int
nRaizes a b c = if (aux a b c)<0 then 0
				 else if (aux a b c) == 0 then 1
							  else 2

aux a b c = b^2-4*a*c

-- ou:
-- nRaizes a b c = let d = b^2-4*a*c
--		   in if d<0 then 0
--			     else if d == 0 then 1
-- 					    else 2

-- Pergunta 7:
raizes :: Float -> Float -> Float -> [Float]
raizes a b c = let d = b^2-4*a*c
	       in if d<0 then []
			 else if d == 0 then [(-b)/(2*a)]
					else [(-b)-sqrt d)/(2*a),(-b-sqrt d)/(2*a)]

-- Pergunta 8:


-- Pergunta 9:
type Hora = (Int,Int)

-- Alínea a)
valida :: Hora -> Bool
valida (h,m) = 0<=h && h<24 && 0<=m && m<60

-- Alínea b)
depois :: Hora -> Hora -> Bool
depois (h1,m1) (h2,m2) = (h1>h2) || (h1 == h2 && m1>m2)

-- Alínea c)
minutos :: Hora -> Int
minutos (h,m) = 60*h+m

-- Alínea d)
paraHoras :: Int -> Hora
paraHoras x = (div x 60, mod x 60)

-- Alínea e)
diferenca :: Hora -> Hora -> Int
diferenca x y = let mx = minutos x
		    my = minutos y
		in abs (mx-my)

-- Alínea f)
addMin :: Int -> Hora -> Hora
addMin x y = paraHoras ((minutos y)+x)

-- Pergunta 10:
opp :: (Int,(Int,Int)) -> Int
opp z = if ((fst z) == 1) then (fst (snd z)) + snd (snd z))
			  else if ((fst z) == 2) then (fst (snd z)) - (snd (snd z))
						 else 0

opp2 :: (Int,(Int,Int)) -> Int
opp2 (1,(y,z)) = y+z
opp2 (2,(y,z)) = y-z
opp2 (_,(y,z)) = 0
