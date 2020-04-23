limit :: [Int] -> [Int]
limit xs = take 15 xs

listInf :: [Int]
listInf = 1:listInf

infNat :: Int -> [Int]
infNat x = x: infNat (succ x)

firstn :: Int->[Int]
firstn x = take x (infNat 0)

firstfive :: [Int]
firstfive = firstn 5

---- Lista de cuadrados
listcuad :: [Int] -> [Int]
listcuad [] = []
listcuad xs = map (^2) xs

cuadlist :: [Int]->[Int]
cuadlist xs = [n^2| n<-(xs)]

--Divisores de un numero
isdiv :: Int -> Int -> Bool
isdiv x y = (mod x y) == 0 

divs :: Int -> [Int]
divs x = [n | n<-[1..x], ((mod x n) == 0)]

----Lista de primos
isprim :: Int -> Bool
isprim x | length (divs x) == 2 = True
         | otherwise = False

listprim :: [Int] -> [Int]
listprim [] = []
listprim xs = filter isprim xs

filterprim :: [Int] -> [Int]
filterprim xs = [n|n<-(xs),isprim n]

---- Suma de cuadrados
sumcuads :: [Int]->Int
sumcuads [] = 0
sumcuads xs = foldl (+) (0) (map (^2) xs)

sumcuad :: [Int]->Int
sumcuad xs = sum ([n^2|n<-(xs)])

---- Sucesores
nexts :: [Int] -> [Int]
nexts [] = []
nexts xs = map (+1) xs

succlist :: [Int]->[Int]
succlist xs = [n+1|n<-(xs)]

---- Suma de enteros
totalsum :: [Int]->Int
totalsum [] = 0
totalsum xs = foldr (+) (0) xs 

sumint :: [Int]->Int
sumint xs = sum ([n|n<-xs])

---- Factorial
prevs :: Int -> [Int]
prevs 1 = [1]
prevs x = x : (prevs (x-1))

fact :: Int -> Int
fact 0 = 1
fact x = foldl (*) (1) (prevs x)

factorial :: Int -> Int
factorial x = product ([n|n<-[1..x]])

---- Pares > 8
pares :: [Int] -> [Int]
pares xs = [n|n<-(xs),even n, n > 8]

---- Primos
primos :: Int -> [Int]
primos x = [n|n<-[1..x], isprim n]

---- Producto cartesiano
cartesian :: [Int]->[Int]->[(Int,Int)]
cartesian xs ys = [(n,m)|n<-(xs), m<-(ys)]

---- Infinitos Pares
infiniteven :: [Int]
infiniteven = [x|x<-[1..], even x]

---- Primeros n
evens :: Int -> [Int]
evens x = take x ([n|n<-(infiniteven)])






















