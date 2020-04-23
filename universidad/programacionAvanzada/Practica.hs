--- 1)
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

factoriales_2 :: Int -> [Int]
factoriales_2 x = reverse (aux (x+1) 0 [1])
  where aux n m (x:xs) = if n==m then [] else factorial (n-1) : aux (n-1) m (x:xs) 

--- 2)
divs :: Int -> [Int]
divs x = [n | n<-[1..x], ((mod x n) == 0)]

isprim :: Int -> Bool
isprim x | length (divs x) == 2 = True
         | otherwise = False

primlist :: Int -> [Int]
primlist x = [n|n<-[1..x], isprim n]

--- 3)
{-foldr (:) [] [1..]
{Definición de foldr}
1:(foldr (:) [] [2..])
{Definición de foldr}
1:(2:(foldr (:) [] [3..]))-}

---4)
{-Intentará evaluar (..((([]:1):2):3)..) pero el constructor : no está definido para concatenar una lista a la cabeza, si no un elemento.
Por lo tanto no se podrá ejecutar la función -}

---5)
{-divs :: Int -> [Int]
divs x = [n | n<-[2..x], ((mod x n) == 0)]-}

common :: [Int] -> [Int] -> Int
common [] ys = 0
common xs [] = 0
common (x:xs) (y:ys) |isIn x (y:ys) = 1 + common xs (y:ys)
                     |otherwise = common xs (y:ys)
                     where isIn x [] = False
                           isIn x (y:ys) | x == y = True
                                         | otherwise = isIn x ys
 
coprimosInf :: [(Int,Int)]
coprimosInf = [(x,y)|x<-[1..], y<-[1..x], (sonCoprimos x y)]
             where sonCoprimos n m = (common (divs n) (divs m)) == 0

---6)
{-Si, implementando la funcion $, la cual busca reducir una expression siempre que sea posible, puede utilizarse para evitar una sobrecarga en la memoria, o bien para asegurarse que la funcion se aplique como nosotros queremos.
Su correcta utilizacion puede reducir tambien el uso excesivo de parentesis, ya que por ejemplo expresiones como (2^)(2 + 8) puede reemplazarse por (2^) $ 2+8.
De esta forma primero va a reducir la expresion 2+8 y el resultado será el exponente al que eleva 2-}
mapVariable :: Int -> [Int]
mapVariable x = map ($ x) [(2-),(5*),(^2)]

---7)
pitagoras :: Float->Float->Float
pitagoras x y = sqrt ((x^2)+(y^2))
























