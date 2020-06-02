fib :: Int -> Int
fib n = fst(fibo n)

fibo :: Int -> (Int,Int)
fibo 0 = (0,1)
fibo x = (b,a+b)  
        where (a,b)= fibo(x-1)

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

