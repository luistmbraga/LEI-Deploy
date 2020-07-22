
-- Pergunta 1
type Ponto = (Float,Float)		-- (abcissa,ordenada)
type Rectangulo = (Ponto,Float,Float)	-- (canto superior esquerdo,largura,altura)
type Triangulo = (Ponto,Ponto,Ponto)
type Poligonal = [Ponto]

distancia :: Ponto -> Ponto -> Float
distancia (a,b) (c,d) = sqrt (((c-a)^2) + ((b-d)^2))

-- Alinea a)
comp :: Poligonal -> Float
comp [] = 0
comp [x] = 0
comp (p1:p2:t) = (distancia p1 p2)+(comp (p2:t))

-- Alinea b)
converteTri :: Triangulo -> Poligonal
converteTri (a,b,c) = [a,b,c,a]

-- Alinea c)
converteRec :: Rectangulo -> Poligonal
converteRec ((x,y),l,a) = [(x,y),(x+l,a),(x+l,y-a),(x,y-a),(x,y)]

-- Alinea d)
fechada :: Poligonal -> Bool
fechada l = (head l)==(last l)

-- Alinea e)
triangula :: Poligonal -> [Triangulo]
triangula [p1,p2,p3,_] = [(p1,p2,p3)]
triangula (p1:p2:p3:t) = (p1,p2,p3):(triangula(p1:p3:t))

-- Alinea f)
areaTriangulo :: Triangulo -> Float
areaTriangulo (x,y,z) = let a = distancia x y
			    b = distancia y z
			    c = distancia z x
			    s = (a+b+c)/2		-- semi-perimetro
			in sqrt (s*(s-a)*(s-b)*(s-c))	-- formula de Heron

area :: Poligonal -> Float
area l = calcula (triangula l)
   where calcula :: [Triangulo] -> Float
	 calcula (t:ts) = (areaTriangulo t)+(calcula ts)
	 calcula [] = 0

-- Alinea g)
mover :: Poligonal -> Ponto -> Poligonal
mover ((x1,y1):t)(x2,y2) = let v = (x2-x1,y2-y1)
			   in translacao v ((x,y):t)

translacao :: (Float,Float) -> Poligonal -> Poligonal
translacao (v1,v2) ((x,y):t) = (x+v1,y+v2):(translacao (v1,v2) t)
translacao _ [] = []

-- ou:
-- mover ((x1,y1):t)(x2,y2) = let (v1,v2) = (x2-x1,y2-y1)
--			      in (x2,y2):[(a+v1,b+v2) | (a,b) <- t]

--Alínea h)


-- Pergunta 2:
type Stock = [(Produto,Preco,Quantidade)]
type Produto = String
type Preco = Float
type Quantidade = Float

-- Alínea a)
-- i)
quantos :: Stock -> Int
quantos l = lenght l -- ou: quantos = lenght

-- ii)
emStock :: Produto -> Stock -> Quantidade
emStock x [] = 0
emStock x ((p,s,q):t) |x == p = q
		      |otherwise = emStock x t

-- iii)
consulta :: Produto -> Stock -> (Preco,Quantidade)
consulta x [] = (0,0)
consulta x ((p,s,q):t) = if x==p then (s,q)
				 else consulta x t

-- iv)
tabPrecos :: Stock -> [(Produto,Preco)]
tabPrecos [] = []
tabPrecos ((p,s,q):t) = (p,s):(tabPrecos t)

-- v)
valorTotal :: Stock -> Float
valorTotal [] = 0
valorTotal ((p,s,q):t) = (s*q) + (valorTotal t)

-- vi)
inflacao :: Float -> Stock -> Float
inflacao x l = [p,s*(1+(x/100)),q)/(p,s,q) <- l]

-- vii)
omaisBarato :: Stock -> (Produto,Preco)
omaisBarato ((p,s,q):(p2,s2,q2):t) = if s>s2 then omaisBarato ((p,s,q):t)
					     else omaisBarato ((p2,s2,q2):t)

-- viii)
maisCaros :: Preco -> Stock -> [Produto]
maisCaros x [] = []
maisCaros x ((p,s,q):t) = if s>x then p:maisCaros x t
				 else maisCaros x t

-- Alínea b)
type ListaCompras = [(Produto,Quantidade)]

-- i)
verifLista :: ListaCompras -> Stock -> Bool
verifLista [] s = True
verifLista ((p,q):t) s = if ((emStock p s)>=q) then verifLista t s
					       else False

-- ii)
falhas :: ListaCompras -> Stock -> ListaCompras
falhas [] s = []
falhas ((p,q):t) s = if ((emStock p s)>=q) then falhas t s
					   else (p,q-emStock p s):falhas t s

-- iii)
custoTotal :: ListaCompras -> Stock -> Float
custoTotal [] s = 0
custoTotal ((x,y):t) s = let (p,q) = consulta x s
			 in (min y q)*p + custoTotal t s

-- iv)
partePreco :: Preco -> ListaCompras -> Stock -> (ListaCompras,ListaCompras)
partePreco p ((x,y):t) s = let (l1,l2) = partePreco p t s
			       (a,_)   = consulta x s
			   in if a<p then ((x,y):l1,l2)
				     else (l1,(x,y):l2)
partePreco p [] s = ([],[])
