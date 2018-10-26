module Validador where

import Data.Char (isDigit)

ehSinal :: Char -> Bool
ehSinal x 
    | x == '+' || x == '-' || x == '*' || x == '/' = True
    | otherwise = False
          
ehEstadoFinal :: String -> Bool
ehEstadoFinal estado 
    | estado == "DIGITO" || estado == "X" || estado == "EXPOENTE" || estado == "ESPACO" = True
    | otherwise = False
    
ehValida :: String -> Bool
ehValida equacao = validarEquacao "INICIAL" equacao 0

validarEquacao :: String -> String -> Int -> Bool
validarEquacao estado equacao qtdIgual
    | null equacao && ehEstadoFinal estado && qtdIgual == 1 = True
    | null equacao || qtdIgual > 1 = False
    | estado == "INICIAL" && head equacao == 'x' = validarEquacao "X" (tail equacao) qtdIgual 
    | estado == "INICIAL" && isDigit (head equacao) =  validarEquacao "DIGITO" (tail equacao) qtdIgual 
    | estado == "INICIAL" && ehSinal (head equacao) = validarEquacao "SINAL" (tail equacao) qtdIgual 
    | estado == "INICIAL" && head equacao == ' ' = validarEquacao "INICIAL" (tail equacao) qtdIgual 
    | estado == "X" && head equacao == '^' = validarEquacao "^" (tail equacao) qtdIgual 
    | estado == "X" && head equacao == ' ' = validarEquacao "ESPACO" (tail equacao) qtdIgual 
    | estado == "DIGITO" && head equacao == ' ' = validarEquacao "ESPACO" (tail equacao) qtdIgual
    | estado ==  "DIGITO" && head equacao == 'x' = validarEquacao "X" (tail equacao) qtdIgual
    | estado == "DIGITO" && isDigit (head equacao) = validarEquacao "DIGITO" (tail equacao) qtdIgual
    | estado == "^" && isDigit (head equacao) = validarEquacao "EXPOENTE" (tail equacao) qtdIgual
    | estado == "EXPOENTE" && isDigit (head equacao) = validarEquacao "EXPOENTE" (tail equacao) qtdIgual
    | estado == "EXPOENTE" && head equacao == ' ' = validarEquacao "ESPACO" (tail equacao) qtdIgual
    | estado == "ESPACO" && ehSinal (head equacao) = validarEquacao "SINAL" (tail equacao) qtdIgual
    | estado == "ESPACO" && head equacao == ' ' = validarEquacao "ESPACO" (tail equacao) qtdIgual
    | estado == "ESPACO" && head equacao == '=' = validarEquacao "IGUAL" (tail equacao) (qtdIgual + 1)
    | estado == "SINAL" && head equacao == ' ' = validarEquacao "ESPACO_SINAL" (tail equacao) qtdIgual
    | estado == "ESPACO_SINAL" && head equacao == 'x' = validarEquacao "X" (tail equacao) qtdIgual
    | estado == "ESPACO_SINAL" && isDigit (head equacao) = validarEquacao "DIGITO" (tail equacao) qtdIgual
    | estado == "ESPACO_SINAL" && head equacao == ' ' = validarEquacao "ESPACO_SINAL" (tail equacao) qtdIgual
    | estado == "IGUAL" && head equacao == ' ' = validarEquacao "INICIAL" (tail equacao) qtdIgual
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
                 
simplificar :: [String] -> [String]
simplificar termos = simplificarAux termos 1

simplificarAux :: [String] -> Int -> [String]
simplificarAux termos i
    | i == (length termos - 1) = termos
    | ehMultiplicacao = simplificarAux trocaAuxMult2 (i + 1)
    | ehDivisao = simplificarAux trocaAuxDiv2 (i + 1)
    | otherwise = simplificarAux termos (i + 1)
    where
        ehMultiplicacao = (termos !! i) !! 0 == '*'
        ehDivisao = (termos !! i) !! 0 == '/'
        termo1 = termos !! (i - 1)
        termo2 = termos !! (i + 1)
        grauTermo1 = getGrauTermo termo1
        grauTermo2 = getGrauTermo termo2
        constanteTermo1 = getConstante termo1
        constanteTermo2 = getConstante termo2
        novoGrauMult = grauTermo1 + grauTermo2
        novaConstanteMult = constanteTermo1 * constanteTermo2
        novoElementoMult = show novaConstanteMult ++ "^" ++ show novoGrauDiv
        novoGrauDiv = grauTermo1 - grauTermo2
        novaConstanteDiv = constanteTermo1 `div` constanteTermo2
        novoElementoDiv = show novaConstanteDiv ++ "^" ++ show novoGrauDiv
        trocaAuxMult = changeNth termos (i - 1) novoElementoMult
        trocaAuxMult1 = changeNth trocaAuxMult i "+"
        trocaAuxMult2 = changeNth trocaAuxMult1 (i + 1) "0"
        trocaAuxDiv = changeNth termos (i - 1) novoElementoDiv
        trocaAuxDiv1 = changeNth trocaAuxDiv i "+"
        trocaAuxDiv2 = changeNth trocaAuxDiv1 (i + 1) "0"

changeNth :: [String] -> Int -> String -> [String]
changeNth termos index novoTermo = 
    let (ys, zs) = splitAt index termos in ys ++ [novoTermo] ++ (tail zs)
