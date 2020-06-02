merge :: [Int]->[Int]->[Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) |x < y = x: merge xs (y:ys)
                    |otherwise = y: merge (x:xs) ys

mergesort1 :: [Int] -> [Int]
mergesort1 [] = []
mergesort1 [x] = [x]
mergesort1 xs = merge (mergesort1 (take (div (length xs) 2) xs))  (mergesort1(drop (div (length xs) 2) xs)) 

mergesort :: [Int] -> [Int]
mergesort [] = []
mergesort [x] = [x]
mergesort xs = merge (half1)  (half2) 
           where half1 = mergesort (take halfsize xs)
                 half2 = mergesort(drop halfsize xs)
                 halfsize = (div (length xs) 2)

quicksort :: [Int]->[Int]
quicksort [] = []
quicksort [x] = [x]
quicksort (x:xs) = (quicksort [n|n<-[1..x], n<=x]) ++ [x] ++ (quicksort [m|m<-[x..(length xs)], m > x])

pot :: Int -> Int
pot 0 = 1
pot 1 = 2
pot x = 3


toBin, binary :: Int -> [Int]
toBin 0 = [0]
toBin n = reverse (binary n)

binary 0 = []
binary x |  mod x 2 == 0 = 0: binary (div x 2)
         | otherwise = 1: binary (div x 2)

evenBin :: [Int] -> Bool
evenBin [] = False
evenBin xs |head(reverse xs) == 0 = True
          | otherwise = False 

cuadp :: Int -> [Int]
cuadp x = [n*n| n<- [1..x]]

isIn :: Int -> [Int] -> Bool
isIn x [] = False
isIn x (y:ys) |x == y = True
              |otherwise = isIn x ys

cuadperf :: Int -> Bool
cuadperf x = isIn x (cuadp x)

elemen :: (Eq a) => a -> Int -> [a] -> Bool
elemen x 0 [] = True
elemen x n [] = False
elemen x n (y:ys) | x == y = elemen x (n-1) ys
                  | otherwise = elemen x n ys

nelem :: (Eq a) => [a] -> Int -> a
nelem (x:xs) 0 = x
nelem (x:xs) n = nelem xs (n-1)























