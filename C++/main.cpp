#include <iostream>
#include <cctype>
#include <errno.h>
#include <locale.h>
#include <string>

using namespace std;

int computadorResponde(){
	cout << "Modo do computador escolhido!\n";
}


int usuarioResponde(){
	cout << "Modo do usuário escolhido!\n";
}

int main(){
	
	setlocale(LC_ALL,"Portuguese");
	
    cout << "Bem vindo ao Equations Solver!\n";
    char opcao;
    bool opInvalida = true;
    
    do{
	    cout << "Escolha um dos modos abaixo:\n";
	    cout << "\nDigitar equações (D)\nDescobrir o resultado (R)\n";
		cin >> opcao;
		opcao = tolower(opcao);
		opInvalida = (opcao != 'r' && opcao != 'd');

		if(opInvalida){
			cout << "Opção inválida.\n";
		}

	}while(opInvalida);
	
	if(opcao == 'd'){
		computadorResponde();
	}else{
		usuarioResponde();
	}
	
    return 0;       
}
