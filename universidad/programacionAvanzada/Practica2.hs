hd :: [a]->a
hd (x:xs) = x 

tl :: [a] -> [a]
tl (x:xs) = xs

lst :: [a] -> a
lst  [x] = x
lst (x:xs) = lst xs

inity :: [a]->[a]
inity [x] = []
inity (x:xs) = x: inity xs

conca :: a->[a]->[a]
conca x xs = x : xs

tomar :: Int->[a]->[a]
tomar 0 xs = []
tomar n (x:xs) = x : tomar (n-1) xs

tirar :: Int->[a]->[a]
tirar 0 xs = xs
tirar n (x:xs) = tirar (n-1) xs

concfin :: a -> [a] -> [a]
concfin y [] = [y]
concfin y (x:xs) = x: concfin y xs

absolute :: Int->Int
absolute x |x > 0 = x
           |x <= 0 = -x

edad :: (Int,Int,Int)->(Int,Int,Int)-> Int
edad (x,y,z) (m,n,p) = p-z

divs :: Int->[Int]
divs n = [x|x<-[2..n-1], mod n x == 0]

prim :: Int->Bool
prim x = divs x == []

listprim :: Int->[Int]
listprim n = [x|x<- [1..n-1], prim x]

cant :: [a]->Int
cant [] = 0
cant (x:xs) = 1 + cant xs

rev :: [a]->[a]
rev [] = []
rev (x:xs) = (lst (x:xs)) : rev (tomar ((cant (x:xs))-1) (x:xs) )

equalist :: (Eq a) => [a]->[a]->Bool
equalist [] [] =True
equalist _ [] = False
equalist [] _ = False
equalist (x:xs) (y:ys) = x == y && equalist xs ys 

palindrom :: (Eq a) =>[a]->Bool
palindrom [] = True
palindrom xs = equalist xs (rev xs)


