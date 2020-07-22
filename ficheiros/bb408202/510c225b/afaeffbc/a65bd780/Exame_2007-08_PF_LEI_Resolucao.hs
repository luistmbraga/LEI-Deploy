module Recurso08 where

data BTree a = Empty | Node a (BTree a) (BTree a)

menoresMaiores :: Float -> (BTree Float) -> ([Float],[Float])
menoresMaiores _ Empty = ([],[])
menoresMaiores n (Node r e d) = let (e1,e2) = menoresMaiores n e ;
																		(d1,d2) = menoresMaiores n d
																in if (r<n) then (r:(e1++d1), e2++d2)
																	 						else (e1++d1, r:(e2++d2))

ePrefixo :: String -> String -> Bool
ePrefixo [] [] = True
ePrefixo [] _ = True
ePrefixo (x:xs) (y:ys) = (x==y) && ePrefixo xs ys

