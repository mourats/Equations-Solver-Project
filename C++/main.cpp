#include <iostream>
#include <cctype>
#include <errno.h>
#include <locale.h>
#include <string>
#include <stdlib.h>

using namespace std;

bool ehValida(string equacao){
  string state = "INICIAL";
  int parenteses = 0;
  int igual = 1;
  for(int i = 0; i < equacao.length();++i){
    if(state == "INICIAL"){
        if(equacao[i] == 'x'){
            state = "X";
        }else if(isdigit(equacao[i])){
            state = "DIGITO";
        }else if(equacao[i] == '('){
            parenteses++;
            state = "PARENTESES";
        }else if(equacao[i] == '+' || equacao[i] == '-'){
            state = "SINAL";
        }else if(equacao[i] == ' '){

        }else{
            return false;
        }
      }else if(state == "X"){
          if(equacao[i] == '^'){
            state = "^";
          }else if(equacao[i] == ' '){
            state = "ESPACO";
          }else if(equacao[i] == '('){
            parenteses ++;
            state = "PARENTESES";
          }else if(equacao[i] == ')'){
            if(parenteses == 0){
              return false;
            }
            parenteses --;
            state = "PARENTESES_FEC";
          }else{
            return false;
          }
    }else if(state == "DIGITO"){
      if(equacao[i] == ' '){
        state = "ESPACO";
      }else if(equacao[i] == 'x'){
        state = "X";
      }else if(equacao[i] == '('){
        parenteses ++;
        state = "PARENTESES";
      }else if(isdigit(equacao[i])){

      }else if(equacao[i] == ')'){
        if(parenteses == 0){
          return false;
        }
        parenteses --;
        state = "PARENTESES_FEC";
      }else{
        return false;
      }
    }
    else if(state == "^"){
      if(isdigit(equacao[i])){
        state = "EXPOENTE";
      }else{
        return false;
      }
    }else if(state == "EXPOENTE"){   
      if(isdigit(equacao[i])){

      }else if(equacao[i] == ' '){
        state = "ESPACO";

      }else{
        return false;
      }
    }
    else if(state == "ESPACO"){
      if(equacao[i] == '+' || equacao[i] == '-' || equacao[i] == '*' || equacao[i] == '/'){
        state = "SINAL";
      }else if(equacao[i] == '='){
        if(igual == 0){
          return false;
        }
        igual --;
        state = "SINAL";
      }else if(equacao[i] == ' '){

      }else{
        return false;
      }
    }
    else if(state == "SINAL"){
      if(equacao[i] == ' '){
        state = "ESPACO_SINAL";
      }else{
        return false;
      }
    }
    else if(state == "ESPACO_SINAL"){
      if(equacao[i] == 'x'){
        state = "X";
      }else if(isdigit(equacao[i])){
        state = "DIGITO";
      }else if(equacao[i] == '('){
        parenteses ++;
        state = "PARENTESES";
      }else{
        return false;
      }
    }
    else if(state == "PARENTESES"){
      if(equacao[i] == ')'){
        if(parenteses == 0){
          return false;
        }
        parenteses --;
        state = "PARENTESES_FEC";
      }else if(equacao[i] == 'x'){
        state = "X";
      }else if(isdigit(equacao[i])){
        state = "DIGITO";
      }else if(equacao[i] == '('){
        parenteses ++;
      }else{
        return false;
      }
    }
    else if(state == "PARENTESES_FEC"){
      if(equacao[i] == ')'){
        if(parenteses == 0){
          return false;
        }
        parenteses --;
      }else if(equacao[i] == '('){
        parenteses ++;
        state = "PARENTESES";
      }else if(equacao[i] == ' '){
        state = "ESPACO";
      }else if(equacao[i] == '^'){
        state = "EXPOENTE";
      }else{
        return false;
      }
    }
  }
  if(igual == 0 && parenteses == 0 && (state == "DIGITO" || state == "X" || state == "PARENTESES_FEC" || state == "EXPOENTE")){
    return true;
  }else{
    return false;
  }
}

void instrucoes(){
  cout << "====================================== INSTRUÇÕES =========================================";
  cout << "\n1) A variável usada deve ser sempre x;\n";
  cout << "2) É necessário que os termos sejam separados por espaço e os\n";
  cout << "sinais também, entretanto termos que multiplicam uma expressão\n";
  cout << "entre parêntesis não devem ser separados do parêntesis.\n";

  cout << "\nExemplos de expressões VÁLIDAS:\n\n";
  cout << "a) x * x = 4\n";
  cout << "b) x^2 / 1 = 9\n";
  cout << "c) 18x - 43 = 65\n";
  cout << "d) x(3x / 2) = 100\n";
  cout << "e) (x - 2)(x - 1) = 2\n";
  cout << "f) (x^2 - 2(4x - 1) - 0) = 0\n";
  cout << "g) 10x - 5(1 + x) = 3(2x - 2) - 20\n";
  cout << "h) x(x + 4) + x(x + 2) = 2x^2 + 12\n";
  cout << "i) (x - 5) / 10 + (1 - 2x) / 5 = (3 - x) / 4\n";

  cout << "\nExemplos de expressões INVÁLIDAS:\n\n";
  cout << "a) x(3x/2) = 1350 - Os termos devem estar espaçados da barra.\n";
  cout << "b) 2y^2 - 8 = 0 - Não é aceito outra variável que não seja x.\n";
  cout << "c) 4x (x + 6) - x^2 = 5x^2 - Há espaço entre o 4x e o parêntesis.\n";
  cout << "d) 10x - 5 (1 + x) = 3(2x - 2) - 20 - Há espaço entre o 5 e o parêntesis.\n";
}

int computadorResponde(){

	cout << "Modo do computador escolhido!\n";
  cout << "\nDeseja consultar as instruções? Se sim digite S, se não, digite outra tecla.\n";
  char inst;
  cin >> inst;
  inst = tolower(inst);
  if(inst == 's'){
    instrucoes();
  } 

  cout << "\nDigite uma equação linear ou quadrática:\n";
  string equacao = "";
  cin >> equacao;
}


int usuarioResponde(){
	cout << "Modo do usuário escolhido!\n";
}



int main(){
	
	setlocale(LC_ALL,"Portuguese");
	
   //COLOCAR A LOGO AQUI
    char opcao;
    bool opInvalida = true;
    
    do{
      cout << "\n===========================================================================================\n";
      cout << "                                Bem vindo ao Equations Solver!\n";
      cout << "===========================================================================================\n";
      cout << "=========================================== MENU =========================================="; 
	    cout << "\n\nEscolha uma das opções abaixo:\n";
	    cout << "\nModo Digitar equações (D)";
      cout << "\nModo Descobrir resultados (R)";
      cout << "\nEncerrar programa (S)\n";

		cin >> opcao;
		opcao = tolower(opcao);
		opInvalida = (opcao != 'r' && opcao != 'd' && opcao != 's');

		if(opInvalida){
			cout << "\nOpção inválida. Por favor tente novamente.\n\n";
      system("pause");
      system("cls");
		}

	}while(opInvalida);
	
	if(opcao == 'd'){
		computadorResponde();
	}else if(opcao == 'r'){
		usuarioResponde();
	}else{
    exit(0);
  }
	
    return 0;       
}
