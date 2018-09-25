#include <iostream>
#include <cctype>
#include <errno.h>
#include <locale.h>
#include <string>

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
