import Control.Monad
import System.Exit

usuarioResponde :: IO()
usuarioResponde = do
    putStrLn ("responde danado")


computadorResponde :: IO()
computadorResponde = do
    putStrLn ("responde danada")
    






start = do
    
    
    let loop = do
            putStrLn "==========================================================================================="
            putStrLn "                                Bem vindo ao Equations Solver!";
            putStrLn "==========================================================================================="
            putStrLn "=========================================== MENU =========================================="
            putStrLn "Escolha uma das opções abaixo:"
            putStrLn "Modo Digitar equações (D)"
            putStrLn "Modo Descobrir resultados (R)"
            putStrLn "Encerrar programa (E)"


            opcao <- getLine   

            if (opcao == "d") then computadorResponde else if (opcao == "r") then usuarioResponde else exitWith $ ExitFailure 3;

            let opInvalida = (opcao /= "r" && opcao /= "d" && opcao /= "e");

            if (opInvalida) then putStrLn "Opção inválida. Por favor tente novamente."
            else putStrLn ""
            

            
            when (opInvalida) loop
    loop  

	
    
main = do
    start

