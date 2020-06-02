solution :: [Int] -> Bool
solution xs = (3 * (head xs) + 1) == (head.tail) xs

equal :: [Int] -> Bool
equal xs =  (sum xs) == (product xs)

equals :: (Eq a)=> [a]->[a]->Bool
equals [] [] =True
equals _ [] = False
equals [] _ = False
equals (x:xs) (y:ys) = x == y && equals xs ys 

palindromo :: (Eq a)=>[a] -> Bool
palindromo [] = True
palindromo xs = equals xs (reverse xs)


