-- Definição de maior de idade:

maiorDeIdade :: Int -> Bool
maiorDeIdade x = x>=18

-- Função que eleva um número ao quadrado:

quadrado :: Int -> Int
quadrado x = x*x

-- Função que mostra o menor valor entre dois inteiros:

menor :: Int -> Int -> Int
menor a b | a<=b      = a
          | otherwise = b
          
-- Função que transforma um número inteiro em caracter:

chr :: Int -> Char

-- Função que transforma um caracter em número inteiro:

ord :: Char -> Int

-- Função que passa uma tupla (Nome, Idade) e devolve a idade:

verIdade :: (Nome, Idade) -> Idade
verIdade (a,b) = b

-- Função factorial:

factorial :: Int -> Int
factorial 0 = 1
factorial n = n*factorial(n-1)

-- Função que, dado o número de chamada de um aluno, fornece a nota do aluno na última prova como resultado:

soma :: Int -> Float
soma 1 = aluno 1
soma n = aluno n + soma (n-1)

-- Função que calcula a média da soma das notas (definida na função anterior):

media :: Int -> Float
media n = (soma n)/(fromInt n)

-- A função "fromInt n" transforma o valor n que tem tipo Int em Float

