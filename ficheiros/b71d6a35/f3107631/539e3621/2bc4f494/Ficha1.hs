module Ficha1 where
	
import Data.Char

--1

perimetro :: Float -> Float 
perimetro r = 2 * pi * r

dist :: (Float,Float) -> (Float,Float) -> Float
dist (x1,y1) (x2,y2) = sqrt(((x2-x1)^2) + ((y2-y1)^2))

primUlt :: [Int] -> (Int,Int)
primUlt [] = (0,0)
primUlt l = (head l ,last l)

multiplo :: Int -> Int -> Bool
multiplo x y = if ((mod x y)==0) then True else False

impar :: Int -> Bool
impar x = (mod x 2 /= 0)

truncaImpar :: [Int] -> [Int]
truncaImpar l = if((impar(length l))) then (tail l) else l

max2 :: (Int, Int) -> Int
max2 (x,y) = if(x>y) then x else y

max3 :: (Int,Int,Int) -> Int
max3 (x,y,z)= max2(max2(x,y),z)

distOrigem :: (Float,Float) -> Float
distOrigem (x,y) = sqrt(((0-x)^2) + ((0-y)^2))

type Ponto = (Float,Float)
type Circulo  = (Centro, Raio)
type Centro = Ponto
type Raio = Float

dentro :: Ponto -> Circulo -> Bool
dentro p (c,r) = ((dist p c) <= r)

--2

desTriang :: (Int,Int,Int) -> Bool
desTriang (a,b,c) | (a+b) >= c = True
				  | (a+c) >= b = True
				  | (b+c) >= a = True
				  | otherwise = False

--4

qraizes :: (Float,Float,Float) -> Int
qraizes (a,b,c) = let d = (b^2-4*a*c)
				  in if(d>0) then 2 else
						if(d==0) then 1 else 0
						
--5

raizes :: (Float,Float,Float) -> [Float]
raizes (a,b,c) = let d = (b^2-4*a*c);
					sd = sqrt(d)
				 in if(qraizes(a,b,c)>0) then [((-1)*b+sd)/(2*a),((-1)*b-sd)/(2*a)] else
						if(qraizes(a,b,c)==0) then [((-1)*b)/(2*a)] else []
						
--6

raizes2 :: Float-> Float-> Float -> [Float]
raizes2 a b c = let d = (b^2-4*a*c);
					 sd = sqrt(d)
				  in if(qraizes(a,b,c)>0) then [((-1)*b+sd)/(2*a),((-1)*b-sd)/(2*a)] else
						if(qraizes(a,b,c)==0) then [((-1)*b)/(2*a)] else []

--7

lower :: Char -> Bool
lower c = ((ord c >= (ord 'a')) && ((ord c) <= (ord 'z')))

digit :: Char -> Bool
digit c = ((ord c >= (ord '0')) && ((ord c) <= (ord '9')))

alpha :: Char -> Bool
alpha c = ((ord c >= (ord 'a')) && ((ord c) <= (ord 'z'))) && ((ord c >= (ord 'A')) && ((ord c) <= (ord 'Z')))

upper :: Char -> Char
upper c = if(lower(c)) then chr ((ord c) - ((ord 'a') - (ord 'A'))) else c

toDigit :: Int -> Char
toDigit d | (d >= 0) && (d <= 9) = chr (d + (ord '0'))

--8


type Hora = (Int,Int)

hValida :: Hora -> Bool
hValida (h,m) = ((h >= 0) && (h < 24)) && ((m >= 0) && (m < 60))

hCompare :: Hora -> Hora -> Bool
hCompare (h1,m1) (h2,m2) = ((h1 > h2) || (h1 == h2)) && (m1 > m2)

hToM :: Hora -> Int
hToM (h,m) = h*60 + m

mToH :: Int -> (Int,Int)
mToH m = (div m 60, mod m 60)

difHora :: Hora -> Hora -> Int
difHora (h1,m1) (h2,m2) = ((hToM(h1,m1)) - (hToM(h2,m2)))


--10

dobros :: [Float] -> [Float]
dobros [] = []
dobros (x:xs) = 2*x : dobros xs

ocorre :: Char -> String -> Int
ocorre _ [] = 0
ocorre c (x:xs) = if (c==x) then 1 + (ocorre c xs) else ocorre c xs

pmaior :: Int -> [Int] -> Int
pmaior n [] = n
pmaior n (x:xs) = if(x>n) then x else pmaior n xs

repetidos :: [Int] -> Bool
repetidos [] = False
repetidos (x:y:xys) = if(x/=y) then repetidos (y:xys) else True

nums :: String -> [Int]
nums [] = []
nums (x:xs) = if(isDigit(x)) then (digitToInt x) : nums xs else nums xs

tresUlt :: [Int] -> [Int]
tresUlt (x:y:w:z:xys) = tresUlt (y:w:z:xys)
tresUlt l = l

posImpares :: [Int] -> [Int]
posImpares [] = []
posImpares (x:xs) = if (odd x) then x : posImpares xs else posImpares xs

somaNeg :: [Int] -> Int
somaNeg [] = 0
somaNeg (x:xs) = if (x<0) then x + somaNeg xs else somaNeg xs

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial(n-1)

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib(n-2) + fib(n-1)

mdc :: (Int, Int) -> Int 
mdc (x,y) = if(mod x y /= 0) then mdc(y,mod x y) else y

--11

type Aluno = (Numero,Nome,ParteI,ParteII)
type Numero = Int
type Nome = String
type ParteI = Float
type ParteII = Float
type Turma = [Aluno]

notasOK :: Turma -> Bool
notasOK [] = True
notasOK ((_,_,p1,p2):t) = (p1>=0) && (p1<=12) && (p2>=0) && (p2<=8) && (notasOK t)

numsOK :: Turma -> Bool
numsOK [] = True
numsOK ((n,_,_,_):t) = (nOK n t) && (numsOK t)

nOK :: Int -> Turma -> Bool
nOK _ [] = True
nOK x ((n,_,_,_):t) = if(x==n) then False else (nOK x t)

turmaOK :: Turma -> Bool
turmaOK t = (notasOK t) && (numsOK t)

passaram :: Turma -> Turma
passaram [] = []
passaram (a:t) = if (passou a) then a:(passaram t) else (passaram t)

passou :: Aluno -> Bool
passou (_,_,p1,p2) = (p1>=8) && (p1+p2 >= 9.5)

notaFinal :: Turma -> [Float]
notaFinal [] = []
notaFinal ((nu,no,p1,p2):t) = if (passou (nu,no,p1,p2)) then (p1+p2) : (notaFinal t) else (notaFinal t)

somaNotas :: Turma -> Float
somaNotas [] = 0
somaNotas ((_,_,p1,p2):t) = (p1+p2) + (somaNotas t)

mediaNotas :: Turma -> Float
mediaNotas t = let pa = (passaram t) 
				 ;  sn = (somaNotas pa) 
				 ;  tt = (length pa)
			   	in (sn / (fromIntegral tt))

maisAlta :: Turma -> String
maisAlta t = let (_,n,_,_) = alta t
			 in n

alta :: Turma -> Aluno
alta [x] = x
alta ((a,b,c,d):(x,y,w,z):t) = if ((c+d) > (w+z)) then alta ((x,y,w,z):t) else alta ((a,b,c,d):t)

--12

--type Hora = (Int,Int)

type Etapa = (Hora,Hora)
type Viagem = [Etapa]

etapaOK :: Etapa -> Bool
etapaOK ((h1,m1),(h2,m2)) = ((h2>h1) || ((h2>=h1) && (m2>m1)))

viagemOK :: Viagem -> Bool
viagemOK [] = True
viagemOK [e] = (etapaOK e)
viagemOK (e1:e2:v) = (etapaOK e1) && (etapaOK e2) && (viagemOK (e2:v))

hPartida :: Viagem -> Hora
hPartida v = (fst (head v))

hChegada :: Viagem -> Hora
hChegada v = (snd (last v))

vEfetiva :: Viagem -> Hora
vEfetiva v = mToH( abs((hToM(hPartida v)) - (hToM(hChegada v))) )

tEspera :: Viagem -> Int
tEspera [] = 0
tEspera [(h1,h2)] = 0
tEspera ((h1,h2):(h3,h4):v) = ((hToM h3) - (hToM h2)) + tEspera ((h3,h4):v)

vTotal :: Viagem -> Hora
vTotal v = mToH((hToM (vEfetiva v)) + (tEspera v))
