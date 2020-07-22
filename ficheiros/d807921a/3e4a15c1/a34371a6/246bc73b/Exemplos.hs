
-- Função que reproduz o que o utilizador escreve:



main :: IO ()

main = do

     str <- getContents

     putStrLn str





-- Função que reproduz o que o utilizador escreve de forma envertida:

main :: IO ()

main = do

     str <- getContents

     let str' = reverse str

     putStrLn str'





f :: String -> String

f = undefined



-- undefined = ao que quisermos definir


main :: IO ()

main = do

     str <- readFile "temp"

     putStrLn str





main :: IO ()

main = do

     str <- readFile "temp"

     writeFile "res" str





main :: IO ()

main = do

     str <- readFile "temp"

     let str = f str

     writeFile "res" str







main :: IO ()

main = do

     args <- getArgs

     putStrLn $  show args





main :: IO ()

main = do

     args <- getArgs

     pname <- getProgName
     
putStrLn pname

     putStrLn $ show args






main :: IO ()

main = do

     args <- getArgs

     pname <- getProgName
     system "cat temp"

     putStrLn pname

     putStrLn $ show args






main :: IO ()

main = do

     args <- getArgs

     pname <- getProgName
     
system "ls -la"

     putStrLn pname

     putStrLn $ show args


