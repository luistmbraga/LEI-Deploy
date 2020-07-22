--1

--a

data BTree a = Vazia | Nodo a (BTree a) (BTree a)

filtra :: (a -> Bool) -> (BTree a) -> [a]
filtra f Vazia = []
filtra f (Nodo a b c) = if f a then a : filtra f b ++ filtra f c
                               else     filtra f b ++ filtra f c

--b

data Contacto = Casa  Integer
              | Trab  Integer
              | Tlm   Integer
              | Email String

type Nome = String
type Agenda = [(Nome, [Contacto])]

--i
acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail n email [] = [(n, [Email email])]
acrescEmail nome email ((n, c):xs) = if n == nome then (n, (Email email):c):xs
                                                  else (n, c):(acrescEmail nome email xs)

--ii

verEmails :: Nome -> Agenda -> Maybe [String]
verEmails n [] = Nothing
verEmails n ((n1, c):xs) = if n == n1 then Just (getMails c)
                                      else verEmails n xs
    where getMails :: [Contacto] -> [String]
          getMails []                 = []
          getMails ((Email email):xs) = email : getMails xs
          getMails (_:xs)             = getMails xs

--2

data LTree a = Leaf a | Fork (LTree a) (LTree a)

--a

instance (Show a) => Show (LTree a) where
    show (Leaf x)   = show x
    show (Fork x y) = "(" ++ show x ++ "/\\" ++ show y ++ ")"

--b

mktree :: Int -> a -> LTree a
mktree x y = build (replicate x y)

--3

type Dakar = [Piloto]

data Piloto = Carro  Numero Nome Categoria
            | Mota   Numero Nome Categoria
            | Camiao Numero Nome

type Numero    = Int
data Categoria = Competicao | Maratona


--a

nPilotosRepetidos :: Dakar -> Bool
nPilotosRepetidos xs = existeRepetidos $ map nDePiloto xs

existeRepetidos :: Eq a => [a] -> Bool
existeRepetidos [] = False
existeRepetidos (x:xs) = elem x xs || existeRepetidos xs

nDePiloto :: Piloto -> Numero 
nDePiloto (Carro  n _ _) = n
nDePiloto (Mota   n _ _) = n
nDePiloto (Camiao n _  ) = n

--b

inserePil :: Piloto -> Dakar -> Dakar
inserePil p []     = [p]
inserePil p (x:xs) = if nDePiloto x < nDePiloto p then (x:p:xs)
                                                  else (x:(inserePil p xs))

--c

type DakarB = BTree Piloto

menor :: DakarB -> Piloto
menor (Nodo a Vazia _) = a
menor (Nodo a b _)     = menor b

--4

--a

minimo :: (Ord a) => BTree a -> a
minimo (Nodo x Vazia _) = x
minimo (Nodo x y _)     = minimo y

--b

semMinimo :: (Ord a) => BTree a -> BTree a
semMinimo (Nodo x Vazia y) = y
semMinimo (Nodo x y z)     = Nodo x (semMinimo y) z

--c

minSmin :: (Ord a) => BTree a -> (a, BTree a)
minSmin (Nodo x Vazia y) = (x, y)
minSmin (Nodo x y z)     = (minim, Nodo x semM z)
    where (minim, semM) = minSmin y

--5

--a
--Visto que ArvBin == BTree, vamos continuar a utilizar BTree

minAB :: BTree Int -> Maybe Int
minAB Vazia            = Nothing
minAB (Nodo x Vazia _) = Just x
minAB (Nodo x y _)     = minAB y

--b

type BD = [Video]
data Video = Filme String Int     --titulo, ano
           | Serie String Int Int --titulo, temporada, episodio
           | Show  String Int     --titulo, ano
           | Outro String

--i

espectaculos :: BD -> [(String, Int)]
espectaculos []         = []
espectaculos ((Show t a):xs) = (t, a) : espectaculos xs 
espectaculos (_:xs)          =          espectaculos xs

--ii

filmesAno :: Int -> BD -> [String]
filmesAno _ []                       = []
filmesAno ano ((Filme nome ano2):xs) = if ano == ano2 then nome:(filmesAno ano xs)
                                                      else       filmesAno ano xs
filmesAno a (_:xs)                    = filmesAno a xs

--6

--a

instance Eq a => Eq (LTree a) where
    Leaf a   == Leaf b   = a == b
    Fork a b == Fork c d = (a == c) && (b == d)
    _        == _        = False
--b

mapLT :: (a -> b) -> LTree a -> LTree b
mapLT f (Leaf a)   = (Leaf (f a))
mapLT f (Fork a b) = (Fork (mapLT f a) (mapLT f b))

--7

type Biblio = [Livro]

data Livro  = Romance Titulo Autor Ano Lido
            | Ficcao  Titulo Autor Ano Lido

type Titulo = String
type Autor  = String
type Ano    = Int
data Lido   = Sim | Nao

--a

instance Eq Livro where
    (Romance t1 a1 l1 _) == (Romance t2 a2 l2 _) = (t1 == t2) && (a1 == a2) && (l1 == l2)   
    (Ficcao  t1 a1 l1 _) == (Ficcao  t2 a2 l2 _) = (t1 == t2) && (a1 == a2) && (l1 == l2)   
    _                    == _                    = False
livrosRepetidos :: Biblio -> Bool
livrosRepetidos xs = existeRepetidos xs

--b

lido :: Biblio -> Titulo -> Biblio
lido [] _ = error "No such book"
lido (x@(Romance t a an _):xs) t1 = if t == t1 then (Romance t a an Sim):xs
                                               else x:(lido xs t1)
lido (x@(Ficcao  t a an _):xs) t1 = if t == t1 then (Ficcao  t a an Sim):xs
                                               else x:(lido xs t1)

--c

type BiblioB = BTree Livro

livroAutor :: Biblio -> Autor -> [Livro]
livroAutor xs a = filter ((== a).autor) xs

autor :: Livro -> Autor
autor (Romance _ a _ _) = a
autor (Ficcao  _ a _ _) = a

--8

--a

mapBT :: (a -> b) -> (BTree a) -> (BTree b)
mapBT _ Vazia = Vazia
mapBT f (Nodo a b c) = Nodo (f a) (mapBT f b) (mapBT f c)

--b

--i

consTelefs :: [Contacto] -> [Integer]
consTelefs []              = []
consTelefs ((Casa tel):xs) = tel : (consTelefs xs)
consTelefs ((Trab tel):xs) = tel : (consTelefs xs)
consTelefs ((Tlm  tel):xs) = tel : (consTelefs xs)
consTelefs (_         :xs) =       (consTelefs xs)

--ii

casa :: Nome -> Agenda -> Maybe Integer
casa n agenda 
    | null contact = Nothing
    | otherwise    = (contactCasa.snd.head) contact
    where contact  = filter ((==n).fst) agenda

contactCasa :: [Contacto] -> Maybe Integer
contactCasa []              = Nothing
contactCasa ((Casa tel):xs) = Just tel
contactCasa (_:xs)          = contactCasa xs

--9

data LTree' a = Leaf' a | Fork' (LTree' a) (LTree' a)

--a

instance Eq (LTree' a) where
    Leaf' x   == Leaf' y   = True
    Fork' a b == Fork' c d = (a == c) && (b == d)
    _         == _         = False

--b

build :: [a] -> LTree a
build [x] = Leaf x
build (x:y:xs) = Fork (Fork (Leaf x) (Leaf y)) (build xs)

--10

--a

maxBT :: BTree Float -> Maybe Float
maxBT Vazia            = Nothing
maxBT (Nodo x _ Vazia) = Just x
maxBT (Nodo _ _ y)     = maxBT y

--b

--i

outros :: BD -> BD
outros = filter eOutro 

eOutro :: Video -> Bool
eOutro (Outro _) = True
eOutro _        = False

--ii

totalEp :: String -> BD -> Int
totalEp n xs = length $ filter (\(Serie nome _ _) -> nome == n) (filter eSerie xs)

eSerie :: Video -> Bool
eSerie (Serie _ _ _) = True
eSerie _             = False

--11

--a

instance (Show a) => Show (LTree' a) where
    show lt = unlines $ map (\(e, d) -> (replicate d '.' ++ show e)) (travessia lt)

travessia :: LTree' a -> [(a,Int)]
travessia (Leaf' x) = [(x,0)]
travessia (Fork' e d) = map (\(x,n) -> (x,n+1)) (travessia e ++ travessia d)

--b

cresce :: LTree a -> LTree a
cresce (Leaf a)   = Fork (Leaf a) (Leaf a)
cresce (Fork x y) = Fork x y

--12

--a

inserePil' :: Piloto -> Dakar -> Dakar
inserePil' p []     = [p]
inserePil' p (x:xs) = if nomePiloto x < nomePiloto p then (x:p:xs)
                                                     else (x:(inserePil' p xs))

nomePiloto :: Piloto -> Nome
nomePiloto (Carro  _ n _) = n
nomePiloto (Mota   _ n _) = n
nomePiloto (Camiao _ n  ) = n

--b

estaOrdenada :: Dakar -> Bool
estaOrdenada []       = True
estaOrdenada [x]      = True
estaOrdenada (x:y:xs) = nomePiloto x < nomePiloto y && estaOrdenada (y:xs)

--c

maior :: DakarB -> Piloto
maior (Nodo a _ Vazia) = a
maior (Nodo _ _ b)     = maior b

--13

--a

maximo :: (Ord a) => BTree a -> a
maximo (Nodo x _ Vazia) = x
maximo (Nodo _ _ y)     = maximo y

--b

semMaximo :: (Ord a) => BTree a -> BTree a
semMaximo (Nodo x y Vazia) = y
semMaximo (Nodo x y z)     = Nodo x y (semMaximo z) 

--c

maxSmax :: (Ord a) => BTree a -> (a, BTree a)
maxSmax (Nodo x y Vazia) = (x, y)
maxSmax (Nodo x y z)     = (maxim, Nodo x y semM)
    where (maxim, semM) = maxSmax z 

--14

--a

livrosLidos :: Biblio -> Int
livrosLidos xs = length $ filter jaLido xs

instance Eq Lido where
    Sim == Sim = True
    Nao == Nao = True
    _   == _   = False

jaLido :: Livro -> Bool
jaLido (Romance _ _ _ l) = l == Sim
jaLido (Ficcao  _ _ _ l) = l == Sim

--b

--A função não diz se o novo livro é de romance ou ficcao, por isso mudamos a função para que aceite um Livro(qualquer livro) e o insira de acordo como que é pedido.

compra :: Livro -> Biblio -> Biblio
compra l [] = [l]
compra l (x:xs) = if autor x < autor l then (x:l:xs)
                                       else (x:(compra l xs))

--A função autor já foi definida anteriormente no exercício 7c.

--c

naoLidos :: BiblioB -> [Livro]
naoLidos Vazia = []
naoLidos (Nodo a b c) = if (not . jaLido) a then naoLidos b ++ (a:naoLidos c)
                                            else naoLidos b ++    naoLidos c


