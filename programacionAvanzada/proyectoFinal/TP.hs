--Asignatura: Programacion Avanzada(1948)
--Año: 2020
--Integrantes:- Alvarez, German 
--            - Solterman Agustin
--            - Toledo Lucas

--El trabajo practico se trata de hacer un algoritmo para jugar el juego de las piedras. Este juego es muy sencillo
--y consiste de dos jugadores (Humano vs Computadora). El juego empieza con N piedras (con N > 0) y cada
--jugador puede tomar 1, 3 o 4 piedras en turnos. Cuando un jugador se queda sin piedras pierde, y por lo tanto
--gana el otro jugador.

--El siguiente tipo define los jugadores del juego, 
--la letra 'C' hace referencia a la Computadora y la letra 'H' al Humano.
data Jugador = C | H deriving (Eq,Show)


-- Definimos la nocion de estado, el mismo hace referencia a un jugador y la cantidad de piedras disponibles
type Estado = (Jugador, Int) 

-- Definimos los posibles estados del juegos, el resultado del juego, puede ser que la computadora pierda, o gane
data Resultado = CPerdio | CGano deriving (Eq,Ord,Show) 

-- Definimos las posible jugadas, sacar 1 piedra, 3 piedras o 4 piedras
jugadas = [1,3,4]

-- La funcion otro Jugador, dado un jugador, devuelve el otro jugador, por ejemplo: otroJugador C = H
otroJugador :: Jugador -> Jugador
otroJugador C = H
otroJugador H = C

--La funcion hacerJugada, Recibe una numero de piedras y un estado, 
--y devuelve el estado resultante de quitar el numero de piedras a la cantidad total de piedras.
--En caso de que el numero de piedras supere la cantidad de piedras actual, devuelve error
hacerJugada :: Int -> Estado -> Estado
hacerJugada piedras (jug, cantPiedras) | cantPiedras >= piedras && elem piedras jugadas = (otroJugador jug, cantPiedras-piedras)
                                       | cantPiedras < piedras && elem piedras jugadas = error "Jugada no admitida,\nEl numero ingresado es mayor a la cantidad de piedras disponibles"
                                       | otherwise = error "Jugada no valida:\nel numero ingresado no pertenece a [1,3,4]"
             
-- evalEstado toma un estado como parametro, y dice si el estado es ganador o perdedor considerando
-- las mejores jugadas del oponente. Por ejemplo, evalEstado (H,2) = CGano, porque H solo puede
-- retirar 1 y luego la computadora retira 1 y gana
evalEstado :: Estado -> Resultado
evalEstado  (j, k)| (k == 0) = if j == C then CPerdio else CGano
                  |  k>0 && j == C   = foldl max CPerdio $ map evalEstado posibleJugs
                  |  k>0 && j == H   = foldl min CGano $ map evalEstado posibleJugs   
                  |  otherwise = error "Jugada no valida"
                  where posibleJugs = [(otroJugador j, k - i) | i<- jugadas, i<=k]    

-- Calcula la mejor jugada para un estado dado para el jugador dado.
-- Por ejemplo, si mejorJug (H,3)=3, ya que la mejor jugada para H cuando hay 3 piedras es retirar 3.
-- Ayuda: Tener en cuenta que el tipo Resultado implementa la clase Ord, es decir, tenemos
-- CPerdio < CGano. Entonces para el caso mejorJug (C, k) tenemos que devolver la jugada 
-- que nos da el resultado maximo con respecto a < (es decir, la mejor jugada para la computadora).
-- En el caso mejorJug (H, k) tenemos que devolver la jugada que nos da el valor minimo (es decir, consideramos 
-- la mejor jugada para H, que seria la peor para C)
mejorJug :: Estado -> Int
mejorJug (jug,k) | elem k jugadas = k  
                 | jug == H = if list(jug,k) /= [] 
                             then maximum (list(jug,k)) 
                             else maximum posibilities--Para forzar que pc pierda
                 | jug == C = if list(jug,k) /= []
                             then minimum (list(jug,k))
                             else minimum posibilities   
                 where posibilities= [i|i<-jugadas, i<=k]

--La funcion list,toma un estado, y devuelve una lista de enteros con las jugadas 
--que llevan a cada jugador a un estado ganador.
list :: Estado->[Int]
list (jug,k)|jug == H = [x|x<-posibilities, evalEstado(otroJugador jug, k-x) == CPerdio]
            |jug == C = [x|x<-posibilities, evalEstado(otroJugador jug, k-x) == CGano]
            where posibilities= [i|i<-jugadas, i<=k]


-- Las siguientes funciones implementan una pequeña interface para poder jugar interactivamente,
-- empieza el usuario con X.
jugar :: Estado -> IO()
jugar (j,k) =   do
                putStrLn("Jugadas disponibles: [1,3,4]")
                putStrLn ("Hay "++ (show k) ++ " piedras, cuantas saca?:")      
                jugada <-  getLine
                let s  = read jugada 
                    (j', k') = hacerJugada s (j,k) 
                if k'==0 then (putStrLn "Gano!")
                else do 
                     let mj = mejorJug (j',k')    
                     putStrLn ("mi jugada: "++(show mj))
                     if k' - mj ==0 
                     then putStrLn "Perdio!"
                     else do 
                       jugar (H, k' - mj) 
          
-- Comienza el juego con una cantidad de piedras dada   
comenzarJuego :: Int -> IO()
comenzarJuego cant | cant <= 0 = error "La cantidad de piedras debe ser mayor que 0."
                   | otherwise = jugar (H, cant)

-- juegosGanadores k, calcula todos los comienzos ganadores para la computadora hasta con k piedras
-- por ejemplo, juegosGanadores 10 = [2,7,9]
juegosGanadores :: Int -> [Int]
juegosGanadores k = filter (juegoPerf) [1..k]

--La funcion juegosPerf, toma un entero, y devuelve True si la computadora resulta ganadora, 
--tomando como referencia de juego el resultado de la funcion mejorJug
juegoPerf :: Int->Bool
juegoPerf k = do      
            let s  = mejorJug(H,k) 
                (j', k') = hacerJugada s (H,k)
            if k'==0 then False
            else do 
                 let mj = mejorJug (C,k')    
                 if (k'-mj) == 0 
                 then True
                 else do 
                       juegoPerf (k' - mj)








