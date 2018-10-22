export validador where


ehSinal :: Char -> Bool
ehSinal x | x == '+' || x == '-' = True
          | otherwise = False

ehEstadoFinal :: String -> Bool
ehEstadoFinal estado | estado == "DIGITO" || estado == "X" || estado == "EXPOENTE" = True
                     | otherwise = False
    
ehValida :: String -> Bool
ehValida equacao = validarEquacao equacao "INICIAL"

validarEquacao :: String -> String -> Bool
validarEquacao estado equacao | null equacao && ehEstadoFinal estado = True
                             | estado == "INICIAL" && head equacao == 'x' = validarEquacao "X" (tail equacao)
                             | estado == "INICIAL" && isDigit (head equacao) =  validarEquacao "DIGITO" (tail equacao)
                             | estado == "INICIAL" && ehSinal (head equacao) = validarEquacao "SINAL" (tail equacao)
                             | estado == "INICIAL" && head equacao == ' ' = validarEquacao "INICIAL" (tail equacao)
                             | estado == "X" && head equacao == '^' = validarEquacao "^" (tail equacao)
                             | estado == "X" && head equacao == ' ' = validarEquacao "ESPACO" (tail equacao)
                             | estado == "DIGITO" && head equacao == ' ' = validarEquacao "ESPACO" (tail equacao)
                             | estado ==  "DIGITO" && head equacao == 'x' = validarEquacao "X" (tail equacao)
                             | estado == "DIGITO" && isDigit (head equacao) = validarEquacao "DIGITO" (tail equacao)
                             | estado == "^" && isDigit (head equacao) = validarEquacao "EXPOENTE" (tail equacao)
                             | estado == "EXPOENTE" && isDigit (head equacao) = validarEquacao "EXPOENTE" (tail equacao)
                             | estado == "EXPOENTE" && head equacao == ' ' = validarEquacao "ESPACO" (tail equacao)
                             | estado == "ESPACO" && ehSinal (head equacao) = validarEquacao "SINAL" (tail equacao)
                             | estado == "ESPACO" && head equacao == ' ' = validarEquacao "ESPACO" (tail equacao)
                             | estado == "ESPACO" && head equacao == '=' = validarEquacao "IGUAL" (tail equacao)
                             | estado == "SINAL" && head equacao == ' ' = validarEquacao "ESPACO_SINAL" (tail equacao)
                             | estado == "ESPACO_SINAL" && head equacao == 'x' = validarEquacao "X" (tail equacao)
                             | estado == "ESPACO_SINAL" && isDigit (head equacao) = validarEquacao "DIGITO" (tail equacao)
                             | estado == "IGUAL" && head equacao == ' ' = validarEquacao "INICIAL" (tail equacao)
                             | otherwise = False

getGrauTermo :: String -> Int
getGrauTermo x  = read (getGrauTermoAux x True False "") :: Int

getGrauTermoAux :: String -> Bool -> Bool -> String -> String
getGrauTermoAux termo constante expoente grau 
    | null termo && null grau = "0"
    | null termo = grau
    | expoente && not constante = getGrauTermoAux (tail termo) False True (grau ++ [(head termo)])  
    | head termo == 'x' = getGrauTermoAux (tail termo) False False "1"
    | head termo == '^' = getGrauTermoAux (tail termo) False True ""
    | otherwise = getGrauTermoAux (tail termo) True False ""

getConstante :: String -> Int
getConstante x = read (getConstanteAux x False "") :: Int

getConstanteAux :: String -> Bool -> String -> String
getConstanteAux termo digito constante
    | null termo = constante
    | isDigit (head termo) = getConstanteAux (tail termo) True (constante ++ [(head termo)])
    | not (isDigit (head termo)) && not digito = "1"
    | otherwise = constante

xor :: Bool -> Bool -> Bool          
xor a b = a /= b

somarTermosComum :: [String] -> [Int]
somarTermosComum termos = somarTermosComumAux termos 0 False 0 0 0

somarTermosComumAux :: [String] -> Int -> Bool -> Int -> Int -> Int-> [Int]
somarTermosComumAux termos i igual a b c
    | i == length termos = [a,b,c]
    | ehIgual = somarTermosComumAux termos proxI True a b c
    | sinal = somarTermosComumAux termos proxI igual a b c
    | grau == 0 && not negativo = somarTermosComumAux termos proxI igual a b (c + getConstante(termos !! i))
    | grau == 0 = somarTermosComumAux termos proxI igual a b (c - getConstante(termos !! i))
    | grau == 1 && not negativo = somarTermosComumAux termos proxI igual a (b + getConstante(termos !! i)) c
    | grau == 1 = somarTermosComumAux termos proxI igual a (b - getConstante(termos !! i)) c
    | grau == 2 && not negativo = somarTermosComumAux termos proxI igual (a + getConstante (termos !! i)) b c
    | grau == 2 = somarTermosComumAux termos proxI igual (a - getConstante (termos !! i)) b c
    where sinal = ehSinal ((termos !! i) !! 0)
          ehIgual = (termos !! i ) !! 0 == '='
          proxI = i + 1
          antI = i - 1
          negativo = i > 0 && xor ((termos !! antI) !! 0 == '-') igual
          grau = getGrauTermo (termos !! i)
