creciente :: [Int] -> Bool
creciente [] = True
creciente [x] = True
creciente (x:xs) = (x<= (head xs)) && creciente xs

inf = 1+inf

m :: [Int]->Int
m [] = 10000000000000000
m (x:xs)= min x (m xs)

test::(Eq a)=> [a]->Bool
test [] = True
test [x] = True
test (x:y:xs) = x==y && test (y:xs)

qu :: Int -> [Int] -> Bool
qu n [] = False
qu n (x:xs) = (x == (n + sum(xs))) || qu (n+x) xs

f :: [Int] -> Bool
f xs = qu 0 xs

q :: (Eq a) => [a]->[a]->Bool
q [] ys = True
q xs [] =False
q (x:xs)(y:ys) = (x == y) && q xs ys

p :: (Eq a) => [a]->[a]->Bool
p [] ys = True
p xs [] = False
p(x:xs)(y:ys) = (x == y && (q xs ys)) || p (x:xs) ys

cTrues :: [Bool]->Int
cTrues [] = 0
cTrues (x:xs)|x = 1 + cTrues xs
             |otherwise = cTrues xs
cFalses :: [Bool]->Int
cFalses [] = 0
cFalses (x:xs)|x = cFalses xs
             |otherwise = 1 + cFalses xs

bal :: [Bool] -> Bool
bal xs = cTrues xs == cFalses xs

















