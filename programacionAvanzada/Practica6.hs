data BinTree a = Nil | Node (BinTree a) a (BinTree a) deriving Show
data LeafTree a = L a | B a (LeafTree a) (BinTree a) deriving Show 
data Nat = Zero | Succ Nat deriving Show 

eqNat :: Nat->Nat->Bool
eqNat Zero Zero = True
eqNat Zero (Succ n) = False
eqNat (Succ m) Zero = False
eqNat (Succ m) (Succ n) = eqNat m n

instance Eq Nat where
      n == m = eqNat n m

eqTree :: Eq a => BinTree a -> BinTree a -> Bool
eqTree Nil Nil = True
eqTree Nil (Node hi n hd) = False
eqTree (Node hi m hd) Nil = False
eqTree (Node hii m hid) (Node hdi n hdd) = (m == n) && (eqTree hii hdi) && (eqTree hid hdd)
                     

instance Eq a => Eq (BinTree a) where x == y = eqTree x y

--instance Show Bintree a where

natToInt :: Nat -> Int
natToInt Zero = 0
natToInt (Succ n) = 1 + (natToInt n)

intToNat :: Int -> Nat
intToNat 0 = Zero
intToNat n = Succ(intToNat (n-1))  

sumaNat1 :: Nat->Nat->Nat
sumaNat1 Zero y = y
sumaNat1 x Zero = x
sumaNat1 (Succ x) (Succ y) = sumaNat1 x (Succ (Succ y))

sumaNat2 :: Nat->Nat->Nat
sumaNat2 x y= intToNat ((natToInt x)+(natToInt y))

prodNat :: Nat->Nat->Nat
ProdNat Zero y = Zero
prodNat x Zero = Zero
prodNat (Succ x)(Succ y) = sumaNat1 (Succ x) (prodNat (Succ x) y)

size :: BinTree a-> Int
size Nil = 0
size (Node hi r hd) = 1 + size hi + size hd

height :: BinTree a-> Int 
height Nil = 0
height (Node hi r hd) = 1 + max (height hi) (height hd)

aTree = (Node (Node (Nil) 0 ( Node (Nil) 8 (Nil))) 1 (Node (Node (Nil)3(Nil))2(Nil)))

mergeTree :: BinTree a -> a -> BinTree a -> BinTree a
mergeTree (Node hi m hd) x Nil = (Node (Node hi m hd) x Nil)
mergeTree  Nil x (Node hi n hd) = (Node Nil x (Node hi n hd))
mergeTree (Node hii m hid) x (Node hdi n hdd) = (Node (Node hii m hid) x (Node hdi n hdd))

leafFinder :: (Eq a) => BinTree a -> a -> Bool
leafFinder Nil x = False
leafFinder (Node hi n hd) x | x == n = True
                           | otherwise = leafFinder hi x || leafFinder hd x

leafPath :: (Eq a) => BinTree a -> [a] -> Bool
leafPath Nil (x:xs) = False
leafPath Nil [] = True
leafPath (Node hi n hd) [] = True
leafPath (Node hi n hd) (x:xs) | n == x = leafPath hi xs || leafPath hd xs
                               | otherwise = False

sonOfTree :: (Eq a) => BinTree a -> a -> [a]
sonOfTree Nil x = []
sonOfTree (Node hi n hd) x | n == x = [n]
                           | leafFinder hi x = n:(sonOfTree hi x) 
                           | leafFinder hd x = n:(sonOfTree hd x)

pineTree :: (Eq a) => BinTree a -> Bool
pineTree  Nil = True
pineTree (Node hi n hd) = hi == hd 
























  


















