-- Defini��o de maior de idade:

maiorDeIdade :: Int -> Bool
maiorDeIdade x = x>=18

-- Fun��o que eleva um n�mero ao quadrado:

quadrado :: Int -> Int
quadrado x = x*x

-- Fun��o que mostra o menor valor entre dois inteiros:

menor :: Int -> Int -> Int
menor a b | a<=b      = a
          | otherwise = b
          
-- Fun��o que transforma um n�mero inteiro em caracter:

chr :: Int -> Char

-- Fun��o que transforma um caracter em n�mero inteiro:

ord :: Char -> Int

-- Fun��o que passa uma tupla (Nome, Idade) e devolve a idade:

verIdade :: (Nome, Idade) -> Idade
verIdade (a,b) = b

-- Fun��o factorial:

factorial :: Int -> Int
factorial 0 = 1
factorial n = n*factorial(n-1)

-- Fun��o que, dado o n�mero de chamada de um aluno, fornece a nota do aluno na �ltima prova como resultado:

soma :: Int -> Float
soma 1 = aluno 1
soma n = aluno n + soma (n-1)

-- Fun��o que calcula a m�dia da soma das notas (definida na fun��o anterior):

media :: Int -> Float
media n = (soma n)/(fromInt n)

-- A fun��o "fromInt n" transforma o valor n que tem tipo Int em Float

