module Teste2010 where

--Parte 1

--1
import Data.Char

intercala :: a -> [a] -> [a]
intercala _ [] = []
intercala x (h:t) = h:x:(intercala x t)

--2
recurso :: [a] -> Int -> a
recurso (h:t) 0 = h
recurso (h:t) x | x>(length (h:t)) = error "indice dado > comprimento da lista dada"
		| otherwise = recurso t (x-1)

--3
catMaybes [] = []
catMaybes ((Nothing):t) = catMaybes t
catMaybes ((Just x):t) = x:(catMaybes t)

--4
type Candidato = String
type Boletim = [Candidato] -- lista de nomes que consta nos boletins de voto
type Votacao = [Candidato] -- cada ocorrência de um candidato representa um voto
type Escrutinio = [(Candidato,Int)]

--a
votos x (h:t) = length (filter (==x) (h:t))

--b
contagem [] _ = []
contagem (x:xs) (h:t) = (x,(votos x (h:t))):(contagem xs (h:t))

--c
estatistica ((h:t):xs) = (h,((t*100)/(aux ((h:t):xs)))):(estatistica xs)

aux [] = 0
aux ((h:t):xs) = t+(aux xs)

