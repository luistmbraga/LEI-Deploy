
-- Pergunta 1:
-- Al�nea a)
[x*6 | x <- [1,2,3]] -- ou: [x | x <- [1..20], mod x 6 == 0]
[6,12,18]

-- Al�nea b)
[x | x <- [2,4..20], mod x 3 == 0]
[6,12,18]

-- Al�nea c)
[(x,y) | x <- [10..20], y <- [20..10], x+y == 30] -- ou: [(x,y) | x <- [10..20], y <- reverse [10..20], x+y == 30] ou ainda: [(x,30-x) | x <- [10..20]]
[(10,20),(11,19),(12,18),(13,17),(14,16),(15,15),(16,14),(17,13),(18,12),(19,11),(20,10)]

-- Al�nea d)
[sum [y | y <- [1,3..x]] | x <- [1..10]]
[1,1,4,4,9,9,16,16,25,25]

-- Pergunta 2:
-- Al�nea a)
[2^n | n <- [0..10]]

-- Al�nea b)
[(x,6-x) | x <- [1..5]] -- ou:  [(x,y) | x <- [1..5], y <- reverse [1..5], x+y == 6]

-- Al�nea c)
[[1..x] | x <- [1..5]]

-- Al�nea d)
[1 | y <- [1..x] | x <- [1..5]]

-- Al�nea e)
[product [1..x]|x<-[1..6]]

