import Control.Monad




start = do
    putStrLn "Before the loop!"
    -- we define "loop" as a recursive IO action
    let loop = do
            print "\n===========================================================================================\n"
            print "                                Bem vindo ao Equations Solver!\n";
            print "===========================================================================================\n"
            print "=========================================== MENU =========================================="
            print "\n\nEscolha uma das opções abaixo:\n";
            print "\nModo Digitar equações (D)";
            print "\nModo Descobrir resultados (R)";
            print "\nEncerrar programa (E)\n";


            opcao <- getLine   
           
            
            when (opcao /= "r" && opcao /= "d" && opcao /= "e") loop
    loop  
    putStrLn "After the loop!"
    
main = do
start


