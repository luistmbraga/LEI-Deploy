-- @author Pirata
-- @version 2015.12

module FichaTP10 where

import FichaTP9
import FichaTP7 --é precciso tirar os "deriving Show"

-- Ex 1 - Fracções

data Frac = F Integer Integer

-- a) função que calcula a fracção equivalente irredutível e com o denominador positivo.
-- a > 0 e b > 0
mdc :: Integer -> Integer -> Integer
mdc a b | a > b = mdc (a - b) b
		| a < b = mdc a (b - a)
		| a == b = a

normaliza :: Frac -> Frac
normaliza (F n 0) = error "denominador nulo"
normaliza (F 0 d) = F 0 1
normaliza (F n d) = F ((signum d) * (n `div` m)) ((abs d) `div` m) where m = mdc (abs n) (abs d)

-- b) Defina Frac como instancia da classe Eq.
instance Eq Frac where -- ver "slides 06" para a definição da classe.
	(==) x y = (a1 == a2) && (b1 == b2) where
		(F a1 b1) = normaliza x
		(F a2 b2) = normaliza y

-- c) Defina Frac como instancia da classe Ord.
instance Ord Frac where -- ver "slides 06" para a definição da classe.
	compare (F n1 d1) (F n2 d2) = compare (n1 * d2) (d1 * n2)
-- ou	(<=) (F n1 d1) (F n2 d2) = (n1 * d2) <= (d1 * n2)

-- d) Defina Frac como instancia da classe Show.
instance Show Frac where -- ver "slides 06" para a definição da classe.
	show (F num den) = "(" ++ show num ++ "/" ++ show den ++ ")"

-- e) Defina Frac como instancia da classe Num.
instance Num Frac where
	(+) (F n1 d1) (F n2 d2) = normaliza (F ((n1 * d2) + (n2 * d1)) (d1 * d2))
	(*) (F n1 d1) (F n2 d2) = normaliza (F (n1 * n2) (d1 * d2))
	(-) (F n1 d1) (F n2 d2) = normaliza (F ((n1 * d2) - (n2 * d1)) (d1 * d2))
	abs (F n d) = (F (abs n) (abs d))
	signum (F n d) = let (F a b) = normaliza (F n d) in if (a == 0) then 0 else if (a > 0) then 1 else (-1)
	fromInteger x = (F x 1)

-- f) função que, dada uma fracção f e uma lista de fracções l, selecciona de l os elementos que são maiores do que o dobro de f.
twiceBiggerThen :: Frac -> [Frac] -> [Frac]
twiceBiggerThen _ [] = []
twiceBiggerThen f (h:ts) = if (h > (2 * f)) then h : (twiceBiggerThen f ts) else (twiceBiggerThen f ts)
-- podemos usar o (>), o (*) e o fromInteger na função porque os definimos para as classes certas antes.

-- Ex 2 - Expressoes Inteiras (ficha anterior)
-- import da Ficha 9 feita no inicio

-- a) Defina ExpInt como instancia da classe Show.
instance Show ExpInt where
	show x = infixx x

-- b) Defina ExpInt como instancia da classe Eq.
instance Eq ExpInt where
	(==) x y = (calcula x) == (calcula y)

-- c) Defina ExpInt como instancia da classe Num.
instance Num ExpInt where
	(+) x y = (Mais x y)
	(-) x y = (Menos x y)
	(*) x y = (Mult x y)
	abs x = if (calcula x) < 0 then (Simetrico x) else x
	signum x = if (c == 0) then (Const 0) else if (c > 0) then (Const 1) else (Const (-1)) where c = calcula x
	fromInteger y = (Const (fromInteger y))

-- Ex 3 - Retoma da Ficha 7

-- a) Defina Data como instancia da classe Ord.
-- É necessário definir como instancia de Eq primeiro.
instance Eq Data where
	(==) (D d1 m1 a1) (D d2 m2 a2) = (a2 == a1) && (m2 == m1) && (d2 == d1)

instance Ord Data where
	compare (D d1 m1 a1) (D d2 m2 a2) = if ((a1 == a2) && (m1 == m2) && (d1 == d2)) then EQ else if ((a2 > a1) || ((a2 == a1) && (m2 > m1)) || ((a2 == a1) && (m2 == m1) && (d2 > d1))) then GT else LT

-- b) Defina Data como instancia da classe Show.
instance Show Data where
	show (D d m a) = (show a) ++ "/" ++ (show m) ++ "/" ++ (show d)

-- c) função que transforma um extracto de modo a que a lista de movimentos apareça ordenada por ordem crescente de data.
ordena :: Extracto -> Extracto
ordena (Ext st moves) = Ext st (oAux moves []) where
	oAux [] new = new
	oAux (h:ts) new = oAux ts (insOrdAux h new)
	insOrdAux x [] = [x]
	insOrdAux (dt,x,y) ((date,strg,move):ts) = if (dt > date) then (date,strg,move) : (insOrdAux (dt,x,y) ts) else (dt,x,y) : (date,strg,move) : ts

-- d) Defina Extracto como instancia da classe Show de modo a imprimir como no exemplo da ficha.
instance Show Extracto where
	show (Ext st list) = "Saldo anterior: " ++ (show st) ++ "\n----------------------------------------------\nData\t\tDescricao\tCredito\tDebito\n----------------------------------------------\n" ++ (concat (map auxMovimento list)) ++ "----------------------------------------------\nSaldo actual: " ++ (show (saldo (Ext st list))) where
		auxMovimento (dt,strg,Credito x) = if (length strg) < 7 then (show dt) ++ "\t" ++ strg ++ "\t\t" ++ (show x) ++ "\n" else (show dt) ++ "\t" ++ strg ++ "\t" ++ (show x) ++ "\n"
		auxMovimento (dt,strg,Debito x) = if (length strg) < 7 then (show dt) ++ "\t" ++ strg ++ "\t\t\t" ++ (show x) ++ "\n" else (show dt) ++ "\t" ++ strg ++ "\t\t" ++ (show x) ++ "\n"

-- exemplo extracto, já ordenado.
ext1 :: Extracto
ext1 = Ext 300 [(D 5 4 2010,"DEPOSITO",Credito 2000),(D 10 8 2010,"COMPRA",Debito 37.5),(D 1 9 2010,"LEV",Debito 60),(D 7 1 2011,"JUROS",Credito 100),(D 22 1 2011,"ANUIDADE",Debito 8)]

