import System.Exit
import Data.Char

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


usuarioResponde :: IO()
usuarioResponde = do

    let loop = do
        putStrLn ("----Modo do usuário escolhido!----")
        putStrLn ("Escolha um tipo de equação:")
        putStrLn ("Primeiro Grau (P)")
        putStrLn ("Segundo Grau (S)")
        putStrLn ("Caso deseje sair, digite <E>")

        op <- getLine
        let operacao = map toLower (op)
    
        if (operacao == "p") then do
        putStrLn ("---- Modo equações do Primeiro Grau escolhido! ---- ")
        putStrLn ("As respostas são sempre um número. Exemplos: (2, 5, -9, 2/3)")
            -- Leitura do arquivo first-degree-equations-bd.txt
        else if (operacao == "s") then do            
        putStrLn ("---- Modo equações do Segundo Grau escolhido! ---- ")
        putStrLn ("As respostas são sempre um número (2, 5, -9, 2/3) ou V")
        putStrLn ("V - Representa que o conjunto solução é vazio para o domínio dos Reais.")
            -- Leitura do arquivo second-degree-equations-bd.txt
        else if (operacao == "e") then exitWith $ ExitFailure 3
        else do  
            putStrLn ("Opção inválida. Por favor tente novamente.")
            loop
    loop

    -- Leitura e exibição linha por linha





computadorResponde :: IO()
computadorResponde = do
    putStrLn ("");
    putStrLn ("Modo do computador escolhido!");
	putStrLn ("Deseja consultar as instruções? Se sim digite S, se não, digite outra tecla.");
    putStrLn ("");
    inst <- getLine
    let consultar = inst
    let consultar = map toLower inst
    if (consultar == "s") then instrucoes else putStr ("")

    let guard = False
    --putStrLn ("Caso deseje sair, digite 'E'.");
    --putStrLn ("");
    putStrLn ("Digite uma equação linear ou quadrática:");
    equacao <- getLine

    let loopGuard = do
        if (equacao == "") then putStrLn ("Digite uma equação linear ou quadrática:") else putStr ("")
        
    loopGuard
    

start :: IO()
start = do
    let loop = do
        putStrLn ("===========================================================================================")
        putStrLn ("                                Bem vindo ao Equations Solver!                             ")
        putStrLn ("===========================================================================================")
        putStrLn ("=========================================== MENU ==========================================")
        putStrLn ("Escolha uma das opções abaixo:")
        putStrLn ("Modo Digitar equações (D)")
        putStrLn ("Modo Descobrir resultados (R)")
        putStrLn ("Encerrar programa (E)")

        op <- getLine
        -- Falta toLower
    
        if (op == "D") then computadorResponde 
        else if (op == "R") then usuarioResponde 
        else if (op == "E") then exitWith $ ExitFailure 3
        else do 
            putStrLn ("Opção inválida. Por favor tente novamente.")
            loop
    loop

main :: IO()
main = do
    start

