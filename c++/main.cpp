#include <iostream>
#include <cctype>
#include <errno.h>
#include <locale.h>
#include <string>

using namespace std;

int main(){
	
	setlocale(LC_ALL,"");
	
    cout << "Bem vindo ao Equations Solver!\n";
    char opcao;
    bool opInvalida = true;
    
    do{
	    cout << "Escolha um dos modos abaixo:\n";
	    cout << "Digitar equações (D)\n Descobrir o resultado (R)\n";
		cin >> opcao;
		opcao = tolower(opcao);
		opInvalida = (opcao != 'r' && opcao != 'd');
		if(opInvalida){
			cout << "Opção inválida.\n";
		}
	}while(opInvalida);
	
	if(opcao == 'd'){
		// invoca computadorResponde
	}else{
		// invoca usuarioResponde
	}
	
	
    return 0;       
}