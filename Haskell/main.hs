import qualified Read as Read
import qualified Validador as Validador

import System.IO.Unsafe(unsafeDupablePerformIO)
import System.Exit
import Data.Char
import Control.Monad
import System.Console.ANSI
import Control.Concurrent
import Data.List.Split


lowerCase :: String -> String
lowerCase palavra = map toLower (palavra)


instrucoes :: IO()
instrucoes = do
    putStrLn ("====================================== INSTRUÇÕES =========================================")
    putStrLn ("");
    putStrLn ("1) A variável usada deve ser sempre x;");
	putStrLn ("2) É necessário que os termos sejam separados por espaço e os sinais também.");
    putStrLn ("");
    putStrLn ("Exemplos de expressões VÁLIDAS:");
    putStrLn ("");
	putStrLn ("a) x * x = 4");
	putStrLn ("b) x^2 / 1 = 9");
	putStrLn ("c) 18x - 43 = 65");
	putStrLn ("d) x^2 + 5x / 2 - 3 / 2 = 0");

    putStrLn ("");
    putStrLn ("Exemplos de expressões INVÁLIDAS:");
    putStrLn ("");
	putStrLn ("a) 2y^2 - 8 = 0 - Não é aceito outra variável que não seja x.");
	putStrLn ("d) x^2 + 5x/2 - 3/2 = 0 - É necessário ter espaços entre o termo e o /.");
	putStrLn ("e) 3x^2 - 24x + 5 = -6x^2 - 11 -É necessário ter espaço entre o - e o 6.");
    putStrLn ("");


mode :: String -> IO()
mode opc = do
    if (opc == "p")
    then putStrLn ("======================== Modo equações do Primeiro Grau escolhido! ========================")
    else if (opc == "s") then putStrLn ("========================= Modo equações do Segundo Grau escolhido! ========================")
    else putStr ("")
    if (opc == "p" || opc == "s") then do
        putStrLn ("")
        putStrLn ("Atenção:")
        if (opc == "p") then putStrLn ("As respostas são sempre um número (2, 5, -9, 2/3)") 
        else if (opc == "s") then putStrLn ("As respostas são sempre um número (2, 5, -9, 2/3) ou V") else putStr ("")
        if (opc == "s") then putStrLn ("V - Representa que o conjunto solução é vazio para o domínio dos Reais.") else putStr ("")
        putStrLn ("")
    else putStr ("")
    

solucaoLinear :: Int -> Int -> IO()
solucaoLinear a b = do  

    if (a == 0) then putStrLn("A equação é linear porém a operação - b/a, gera uma divisão por zero, não possuindo solução.")
    else do
        let  x = fromIntegral((-1) * b) / fromIntegral(a)

        putStrLn("A equação é linear e a sua solução é x = " ++ (show $ x))


calculaRaizes :: Int -> Int -> Int -> IO()
calculaRaizes a b c = do
    
    if (a == 0) then solucaoLinear b c
    else do
        let delta = (b * b) - (4 * a * c)
        
        if (delta < 0) then putStrLn("O delta ("++ (show $ delta) ++") é negativo, assim a equação não possui solução no conjunto dos números reais.")
        else if (delta == 0) then do

            let res = fromIntegral((-1) * b) / fromIntegral(2 * a)
            putStrLn ("O delta é igual a zero, assim a equação possui duas soluções iguais a" ++ (show $ res) ++".)")
        else do
            let raiz = floor . sqrt $ fromIntegral delta
            let x1 = fromIntegral(((-1) * b) + raiz) / fromIntegral(2 * a)
            let x2 = fromIntegral(((-1) * b) - raiz) / fromIntegral(2 * a)
            putStrLn ("Como o delta ("++ (show $ delta) ++") da quação possui duas soluções distintas. São elas: " ++ (show $ x1) ++ " e " ++ (show $ x2))
            

--removeElemento:: [String] -> Int -> [String]
--removeElemento termos index = [x | x <- termos, x /= (termos !! index)]
--    let (ys, zs) = splitAt index termos in ys ++ (tail zs)


respondendo :: String -> Int -> IO()
respondendo arq tam = do

    let index = Read.randomValue (tam)
    let nomeArquivo = if (arq == "p") then "data/first-degree-equations-bd.txt" else "data/second-degree-equations-bd.txt"

    let file = unsafeDupablePerformIO (readFile nomeArquivo)
    let lista =  lines file
    let linha = (lista !! index)
    
    let equacao = (splitOn "$" (linha)) !! 0
    let result = (splitOn "$" (linha)) !! 1
    let dica = (splitOn "$" (linha)) !! 2

    putStrLn ("")
    putStrLn ("Problema:")
    putStrLn (equacao)
    putStrLn (dica)
    putStrLn ("")
    putStrLn ("Digite sua resposta:")
    let resposta = do
        resp <- getLine
        if (resp == "e") then exitWith $ ExitFailure 3
        else
            if (result == resp) then 
                putStrLn ("ACERTOU!!")
            else do
                putStrLn ("ERROU! :(");
                putStrLn ("A resposta certa é: ");
                putStrLn (result);
    resposta
    respondendo arq tam


usuarioResponde :: IO()
usuarioResponde = do

    let loop = do
        putStrLn ("=============================== Modo do usuário escolhido! ================================")
        putStrLn ("")
        putStrLn ("Escolha um tipo de equação:")
        putStrLn ("Primeiro Grau (P)")
        putStrLn ("Segundo Grau (S)")
        putStrLn ("Caso deseje sair, digite <E>")
        putStrLn ("")

        op <- getLine
        let operacao = lowerCase (op)
        
        mode operacao        
        if (operacao == "e") then exitWith $ ExitFailure 3
        else if (operacao /= "s" && operacao /= "p") then do
            putStrLn ("Opção inválida. Por favor tente novamente.") 
            loop
            else
                respondendo operacao 40
    loop


computadorResponde :: IO()
computadorResponde = do
    putStrLn ("");
    putStrLn ("Modo do computador escolhido!");
	putStrLn ("Deseja consultar as instruções? Se sim digite S, se não, digite outra tecla.");
    putStrLn ("");
    inst <- getLine
    let consultar = inst
    let consultar = lowerCase (inst)
    if (consultar == "s") then instrucoes else putStr ("")

    putStrLn ("Caso deseje sair, digite 'E'.");
    putStrLn ("");
    
    let loopGetEquacao = do
        putStrLn ("Digite uma equação linear ou quadrática:");
        equacao <- getLine
        if (equacao == "e") then exitWith $ ExitFailure 3 
        else if (equacao == "") then loopGetEquacao 
        else do
            if (Validador.ehValida equacao) 
            then do
                let splitted = words equacao
                let termosSomados = Validador.somarTermosComum splitted
                calculaRaizes (termosSomados !! 0) (termosSomados !! 1) (termosSomados !! 2)
                -- SE QUISER VERIFICAR COMO O ARRAY FICA USE print(splitted), O RESULTADO É ASSIM ["2x^2","+","4","=","0"]
                --let simplificada = simplificar (splitted)
                --resolverEquacao (simplificada)
                putStr ("")
            else do
                putStrLn ("Equação inválida!")
                putStrLn ("")
                loopGetEquacao
            
    loopGetEquacao
    

start :: IO()
start = do

    putStr (Read.logomarca)

    let loop = do
        putStrLn ("")
        putStrLn ("===========================================================================================")
        putStrLn ("                                Bem vindo ao Equations Solver!                             ")
        putStrLn ("===========================================================================================")
        putStrLn ("=========================================== MENU ==========================================")
        putStrLn ("")
        putStrLn ("Escolha uma das opções abaixo:")
        putStrLn ("Modo Digitar equações (D)")
        putStrLn ("Modo Descobrir resultados (R)")
        putStrLn ("Encerrar programa (E)")

        op <- getLine
        let operacao = lowerCase (op)
        
        if (operacao == "d") then computadorResponde 
        else if (operacao == "r") then usuarioResponde 
        else if (operacao == "e") then exitWith $ ExitFailure 3
        else do 
            putStrLn ("Opção inválida. Por favor tente novamente.")
            putStrLn ("")  
            threadDelay 1000000
            clearScreen          
            loop
    loop

    
main :: IO()
main = do
    print (Read.randomValue 30)
    start

