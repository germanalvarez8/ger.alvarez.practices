--1)

nand :: Bool->Bool->Bool
nand True True = False
nand False _ = True
nand _ False = True
--2)

maj :: Bool->Bool->Bool->Bool
maj True True _ = True
maj True _ True = True
maj _ True True = True
maj _ _ _ = False

--3)
even :: Int -> Bool
even x = (mod x 2) == 0

isEven :: Int -> [Int] -> Bool
isEven i xs = (mod (xs!!i) 2) == 0

isOdd :: Int -> [Int] -> Bool
isOdd i xs = (mod (xs!!i) 2) == 1

todos :: [Int] -> [a] -> (Int -> [a] -> Bool)->Bool
todos is xs p = foldl (&&) (True) (ys)
        where ys = [p i xs | i <- (is)]

todosPares :: [Int] -> Bool
todosPares xs = todos [0..((length xs) -1)] xs isEven

positive :: [Int] -> Bool
positive (x:xs) | (mod x 2) == 1 = True && positive xs
                | otherwise = False

esPos :: Int -> [Int] -> Bool
esPos i xs = xs!!i > 0

imparesPos :: [Int] -> Bool
imparesPos xs = todos [n| n<-[0..((length xs) -1)],odd n] xs esPos

--4)

sumatoria :: [Int] -> [Int] -> (Int -> [Int] -> Bool)->Int
sumatoria is xs p = foldl (+) (0) (xs)
        where ys = [p i xs | i <- (is)]

sumaTodo :: [Int]->Int
sumaTodo xs = sumatoria [0..(length xs)-1] xs esPos












