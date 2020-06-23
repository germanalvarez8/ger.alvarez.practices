fib :: Int -> Int
fib n = fst(fibo n)

fibo :: Int -> (Int,Int)
fibo 0 = (0,1)
fibo x = (b,a+b)  
        where (a,b)= fibo(x-1)

exponente :: Int->Int->Int
exponente 0 _ = 1
exponente i x = x *exponente (i-1) x

suma :: Int->Int->Int
suma 0 _= 0
suma n x = suma(n-1) x + exponente (n-1) x

tuplaSum :: Int->Int->(Int,Int)
tuplaSum 0 x = (0,1)
tuplaSum n x = (a+b,x*b)
        where (a,b) = tuplaSum (n-1) x

sumexp n x= fst(tuplaSum n x)

aproxE :: Float -> Float
aproxE n = fst(tuplaE n)

tuplaE :: Float->(Float,Float)
tuplaE 0 = (0,1)
tuplaE n = (a+(1/b),n*b)
        where (a,b) = tuplaE (n-1)

cubo :: Int->Int
cubo 0 = 0
cubo n = cubo(n-1) + fst(qbo (n-1)) 

qbo :: Int -> (Int,Int)
qbo 0 = (1,6)
qbo x = (b+a, 6+b)
     where (a,b) = qbo (x-1)

g :: Int->[Int]->Int
g x [] = maxBound
g x (y:ys)= (min (abs (x-y)) (g x ys))

h :: [Int]->Int->Int
h [] y = maxBound
h (x:xs) y = (min(abs(x-y)) (h xs y))

f :: [Int]->[Int]->Int
f [] ys = maxBound
f xs [] = maxBound
f (x:xs) (y:ys) = min (min (abs(x-y)) (g x (y:ys))) (min (f xs ys)(h (x:xs) y))

conkt :: (Eq a)=>[[a]]->[a]
conkt [] = []
conkt (x:xs)= x ++ conkt xs

todosCeros :: [Int]->Bool
todosCeros [] = True
todosCeros (x:xs) = (x == 0) && todosCeros xs

p :: [Int] -> Int
p [] = 0
p (x:xs) | todosCeros(x:xs)= length(x:xs)
         | otherwise = p xs 

bal :: [Bool]->Bool
bal xs = balgen 0 xs

balgen :: Int->[Bool]->Bool
balgen n [] = n == 0
balgen n (True:xs) = balgen (n+1) xs
balgen n (False:xs) = balgen (n-1) xs

efe :: [Int]->Int
efe [] = 0
efe (x:xs) = min (fmod (x:xs)) (efe xs)

fmod :: [Int]->Int
fmod xs = fmodgen 0 xs

fmodgen :: Int->[Int]->Int
fmodgen n [] = n
fmodgen n (x:xs) = min n (fmodgen (n+x) xs)

quitaElemento :: (Eq a) => [a] -> a -> [a]
quitaElemento l n = [ x | x <- l , x /= n]

esPerm :: (Eq a, Ord a) => [a]->[a]->Bool
esPerm xs ys = eqList (orden xs) (orden ys)

orden :: (Ord a) => [a] -> [a]
orden [] = []
orden (x:xs) = 
    orden menores ++ [x] ++ orden mayores
    where menores = [y | y <- xs, y <= x]
          mayores = [y | y <- xs, y >  x] 

eqList :: (Eq a) => [a]->[a]->Bool
eqList [][] = True
eqList [] ys = False
eqList xs [] = False
eqList (x:xs)(y:ys) = x == y && eqList xs ys


espermutacion :: Eq a => [a] -> [a] -> Bool
espermutacion [] [] = True
espermutacion [] (y:ys) = False
espermutacion (x:xs) ys = elem x ys && espermutacion xs (borrar x ys)

borrar :: Eq a => a -> [a] -> [a]
borrar x [] = []
borrar x (y:ys) | x == y = ys
                | otherwise = y : borrar x ys

data Racional = Integer :/ Integer deriving Show

instance Eq Racional where
(x:/y)´==´ (x':/y') = (x == x') && (y == y')
(x:/y)´/=´ (x':/y') = (x /= x') || (y /= y')

sumarac :: Racional->Racional->Racional
sumarac (x:/y)(x':/y')| y==y' = ((x+x'):/y)
                      |otherwise = redufracc (((x*x')+y'):/((y*y'))) 2

redufracc :: Racional -> Integer ->Racional
redufracc (x:/y) n |(( mod x n) == 0) && ((mod y n) == 0) && n /= 10 = redufracc ((div x n):/(div y n)) n 
                   |(((mod x n) /= 0)||((mod y n) /= 0)) && n /= 10  = redufracc (x:/y) (n+1) 
                   | otherwise = (x:/y)     

















