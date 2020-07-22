module Ficha1 where

-- EX 1 - Funções Gerais

-- a) calcula o per ımetro de uma circunferˆencia, dado o comprimento do seu raio.
-- O valor de pi está predefinido no Haskell.
-- perimetro :: Float -> Float
perimetro :: Floating a => a -> a  --Aqui o tipo abrange todos os tipos flutuantes (Double, Float, etc).
perimetro r = 2 * pi * r

-- b) calcula a distância entre dois pontos no plano Cartesiano. Cada ponto ́e um par de valores do tipo Float.
dist :: (Float,Float) -> (Float,Float) -> Float
dist (a,b) (x,y) = sqrt(((x - a)**2) + ((y - b)**2))

-- c) recebe uma lista e devolve um par com o primeiro e último elemento dessa lista.
primUlt :: [a] -> (a,a)
primUlt l = (head l, last l)

-- d) testa se o número inteiro m é múltiplo de n.
multiplo :: Int -> Int -> Bool
multiplo m n = mod m n == 0
-- mesmo que: multiplo m n = if(mod m n == 0) then True else False

-- e) recebe uma lista e, se o comprimento da lista for ímpar retira-lhe o primeiro elemento, caso contŕario devolve a própria lista.
truncaImpar :: [a] -> [a]
truncaImpar l = if(mod (length l) 2 /= 0) then tail l else l

-- f) calcula o maior de dois números inteiros. Mudando o tipo pode-se generalizar para qualquer tipo que aceite ordenação.
max2 :: Int -> Int -> Int
max2 a b = if(a > b) then a else b

-- g) calcula o maior de três números inteiros usando a função max2. Mudando o tipo pode-se generalizar para qualquer tipo que aceite ordenação.
max3 :: Int -> Int -> Int -> Int
max3 a b c = max2 (max2 a b) c

-- EX 2 - Polinómios do 2º grau

-- a) recebe os 3 coeficientes de um polinómio do 2º grau e calcula o número de raízes reais desse polinómio.
nRaizes :: (Floating a, Ord a) => a -> a -> a -> Int
nRaizes a b c | delta > 0 	= 2
              | delta == 0 	= 1
              | delta < 0 	= 0
			where delta = (b**2) - (4 * a * c)

-- é a mesma coisa que:
nRaizes_v2 :: (Floating a, Ord a) => a -> a -> a -> Int
nRaizes_v2 a b c = let delta = (b**2) - (4 * a * c) in
				   if(delta > 0) then 2
								 else (if(delta == 0) then 1
													  else 0 )
-- o tipo também podia ser: nRaizes :: Float -> Float -> Float -> Int

-- b) usando a função anterior, recebe os coeficientes do polinómio e devolve a lista das suas raízes.
-- raizes :: Float -> Float -> Float -> [Float]
raizes :: (Floating a, Ord a) => a -> a -> a -> [a]
raizes a b c | nR == 0 	= []
			 | nR == 1 	= [(-b) / (2 * a)]
			 | nR == 2 	= [((-b) + sqrt((b**2) - (4 * a * c))) / (2 * a), ((-b) - sqrt((b**2) - (4 * a * c))) / (2 * a)]
			where nR = nRaizes a b c

-- EX 3 - Pontos Cartesianos

type Ponto = (Float,Float)

-- a) defina uma função que recebe 3 pontos que sao os vértices de um triângulo e devolve um tuplo com o comprimento dos seus lados.
ladosTri :: Ponto -> Ponto -> Ponto -> (Float,Float,Float)
ladosTri x y z = (dist x y, dist y z, dist z x)

-- b) Defina uma função que recebe 3 pontos que são os vértices de um triângulo e calcula o perímetro desse triângulo.
periTri :: Ponto -> Ponto -> Ponto -> Float
periTri x y z = a + b + c where (a,b,c) = ladosTri x y z

-- c) Defina uma função que recebe 2 pontos que são os vértices da diagonal de um rectângulo paralelo aos eixos e constroi uma lista com os 4 pontos desse rectângulo.
listaPontosRect :: Ponto -> Ponto -> [Ponto]
listaPontosRect (a,b) (x,y) = [(a,b), (a,y), (x,y), (x,b)]

-- EX 4 - Horas

type Hora = (Int,Int)

-- a) testar se um par de inteiros representa uma hora do dia válida.
horaValida :: Hora -> Bool
horaValida (h,m) = (h >= 0) && (h < 24) && (m >= 0) && (m < 60)

-- similar: horaValida (h,m) = if((h >= 0) && (h < 24) && (m >= 0) && (m < 60)) then True else False

-- b) testar se uma hora é ou não depois de outra (comparação). (Compara que a primeira hora escrita é anterior à outra).
horaDepois :: Hora -> Hora -> Bool
horaDepois (a,b) (x,y) = (a < x) || ((a == x) && (b < y))

-- c) converter um valor em horas (par de inteiros) para minutos (inteiro).
hora2Mins :: Hora -> Int
hora2Mins (h,m) = (h * 60) + m

-- d) converter um valor em minutos para horas.
mins2Hora :: Int -> Hora
mins2Hora m = (div m 60, mod m 60)

-- e) calcular a diferença entre duas horas (cujo resultado deve ser o número de minutos).
diferHoras :: Hora -> Hora -> Int
diferHoras a b = if(horaDepois a b) then (hora2Mins b) - (hora2Mins a) else (hora2Mins a) - (hora2Mins b)

-- f) adicionar um determinado número de minutos a uma dada hora.
adicionaMinutos :: Hora -> Int -> Hora
adicionaMinutos hora mins = mins2Hora ((hora2Mins hora) + mins)
