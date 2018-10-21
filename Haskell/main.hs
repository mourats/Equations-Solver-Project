import Control.Monad
import System.Exit

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


usuarioResponde :: IO()
usuarioResponde = do
    putStrLn ("responde danado")


computadorResponde :: IO()
computadorResponde = do
    putStrLn ("");
    putStrLn ("Modo do computador escolhido!");
	putStrLn ("Deseja consultar as instruções? Se sim digite S, se não, digite outra tecla.");
    putStrLn ("");
    inst <- getLine
    let consultar = inst
    --let consultar = toLower (inst)
    if (consultar == "s") then instrucoes else putStrLn ("")
    

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

        opcao <- getLine   

        if (opcao == "d") then computadorResponde else if (opcao == "r") then usuarioResponde else exitWith $ ExitFailure 3;

        let opInvalida = (opcao /= "r" && opcao /= "d" && opcao /= "e");

        if (opInvalida) then putStrLn "Opção inválida. Por favor tente novamente."
        else putStrLn ""
        
        when (opInvalida) loop
    loop

	   
main = do
    start

