#include <iostream>
#include <vector>
#include <sstream>
#include <cctype>
#include <errno.h>
#include <locale.h>
#include <string>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <cmath>

 #include "validate.h"

#define linhas 40
#define caracteres 200

using namespace std;

 void instrucoes() {
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

void solucaoLinear(float a, float b){
  float x = ((-1) * b) / a;
  std :: cout.precision(3);
  std :: cout << "A equação é linear e a sua solução é x = " << x << ".\n";
}

void calculaRaizes(float a, float b, float c){
  if(a == 0){
    solucaoLinear(b, c);
  }else{
    float delta = (b * b) - (4 * a * c);
    if(delta < 0){
      std :: cout << "O delta é negativo(" << delta << "), assim a equação não possui solução no conjunto dos números reais.\n";
     }else if(delta == 0){
      float res = ((-1) * b) / 2 * a;
      std :: cout << "O delta é igual a zero, assim a equação possui duas soluções iguais a " << res << ".\n";
    }
    else{
      float raiz = sqrt(delta);
      float x1, x2;
      x1 = (((-1) * b) + raiz) / 2 * a;
      x2 = (((-1) * b) - raiz) / 2 * a;
       std :: cout.precision(3);
      std :: cout << "Como o delta é positivo(" << delta << "), a equação possui duas soluções distintas.\nSão elas: \n" << x1 << "\n" << x2 << "\n";
    }
  }
}

int stringToInt(string valor){
  stringstream geek(valor);
  int intGrau = 0;
  geek >> intGrau;
  return intGrau; 
}

int getGrauTermo(string termo){
  	bool constante = true;
  	bool expoente = false;
  	string grau = "";
  	for(int i = 0; i < termo.length(); i++){
    	if(expoente && (!constante)){
      		grau += termo[i];
    	}
    	if(termo[i] == 'x'){
      		grau = "1";
      		constante = false;
    	}else if(termo[i] == '^'){
      		expoente = true;
      		grau = "";
    	} 
  }
  if(constante){
    return 0;
  }
  return stringToInt(grau);

}

int getConstante(string termo){
  bool digito = false;
  string constante;
  int i = 0;
  while(i < termo.length()){
    if(isdigit(termo[i])){
      constante += termo[i];
      digito = true;
    }else{
      break;
    }
    i++;
  }
  if(!digito){
    return 1;
  }
  return stringToInt(constante);
}

 //split();
std::vector<std::string> split(std::string strToSplit, char delimeter) {
    std::stringstream ss(strToSplit);
    std::string item;
    std::vector<std::string> splittedStrings;
    while (std::getline(ss, item, delimeter)) {
       splittedStrings.push_back(item);
    }
    return splittedStrings;
}

int usuarioResponde() {
 	FILE *arq;
	char matriz[linhas][caracteres];
	char *result;
	int i;
	int random;
	char returned[linhas];
	bool disponivel = false;
	bool guard = true;
	char answer[8];
	bool opInvalida = false;
	char opcao;
 	do {
	cout <<std::endl << "----Modo do usuário escolhido!----\n"<<std::endl;
	cout << "Escolha um tipo de equação:\n\n";
	cout << "Primeiro Grau (P)\n";
	cout << "Segundo Grau (S)\n\n";
 	cout << "Caso deseje sair, digite <e>"<<std::endl<<std::endl;
 	cin >> opcao;
	opcao = tolower(opcao);
	opInvalida = (opcao != 'p' && opcao != 's' && opcao != 'e');
 		if (opInvalida) {
			cout << "\nOpção inválida. Por favor tente novamente.\n\n";
			system("pause");
			system("cls");
		}
 	} while (opInvalida);
 	if (opcao == 'p') {
		cout << "---- Modo equações do Primeiro Grau escolhido! ---- \n\n";
		cout << "As respostas são sempre um número (2, 5, -9, 2/3)"<<std::endl<<std::endl;
		arq = fopen("data/first-degree-equations-bd.txt", "rt");
	} else if (opcao == 's') {
		cout << "---- Modo equações do Segundo Grau escolhido! ---- \n\n";
		cout << "As respostas são sempre um número (2, 5, -9, 2/3) ou V"<<std::endl;
		cout << "V - Representa que o conjunto solução é vazio para o domínio dos Reais."<<std::endl<<std::endl;
		arq = fopen("data/second-degree-equations-bd.txt", "rt");
	} else {
		exit(0);
	}
 	if (arq == NULL) {
		cout << "Problemas na abertura do arquivo\n";
		return 0;
	}
 	i = 0;
	while (!feof(arq)) {
		result = fgets(matriz[i], 200, arq);
		i++;
	}
	fclose(arq);
 	srand(time(NULL));
 	do{
 		while (!disponivel){
			random = rand() % 40;
			if (returned[random] != 'x'){
				disponivel = true;
			}
		}
		returned[random] = 'x';
		disponivel = false;
 		std::vector<std::string> splittedQuest = split(matriz[random], '$');
		std::cout<<splittedQuest[0]<<std::endl;
		std::cout<<splittedQuest[2]<<std::endl;
 		cin >> answer;
		
		if(!strcmp(answer, "e")){
			guard = false;
		} else if(answer == splittedQuest[1]){
			cout << "ACERTOU! :)"<<std::endl<<std::endl;
		}else{
			cout << "ERROU! :("<<std::endl<<std::endl;
		}
 	} while (guard);
}

string intToString(int valor){
  stringstream ss;
  ss << valor;
  string str = ss.str();
  return str;
}
 
void simplificar(vector<string> &equacao){
  int novoGrau = 0;
  int novaConstante = 0;
  for(int i = 1; i < equacao.size() - 1;i++){
    if(equacao[i][0] == '*'){
      novoGrau = getGrauTermo(equacao[i-1]) + getGrauTermo(equacao[i+1]);
      novaConstante = getConstante(equacao[i-1]) * getConstante(equacao[i+1]);
      equacao[i-1] = intToString(novaConstante) + "x^" + intToString(novoGrau);
      cout << equacao[i] << "\n"; 
      equacao[i] = "+";
      equacao[i+1] = "0";
    }else if(equacao[i][0] == '/'){
    	novoGrau = getGrauTermo(equacao[i-1]) - getGrauTermo(equacao[i+1]);
    	novaConstante = getConstante(equacao[i-1]) / getConstante(equacao[i+1]);
    	equacao[i-1] = intToString(novaConstante) + "x^" + intToString(novoGrau);
        equacao[i] = "+";
   	equacao[i+1] = "0";
  }
 }
	
}
 
bool ehSinal(string termo) {
  return termo[0] == '+' || termo[0] == '-' || termo[0] == '*' || termo[0] == '/' || termo[0] == '=';
}
 
void resolverEquacao(vector<string> equacao){
  int valores[3] = {0,0,0};
  int grau = 0;
  int valor = 0;
  bool igual = false;
  for(int i = 0; i < equacao.size(); i++){
    if(equacao[i][0] == '=') igual = true;
    if(!ehSinal(equacao[i])){
      grau = getGrauTermo(equacao[i]);
      valor = getConstante(equacao[i]);
     if(i != 0 && equacao[i - 1][0] == '-'){
        valor = -1 * valor;
     }
     if(igual) valor = -1 * valor;
     valores[grau] += valor;
    }
  }
  calculaRaizes(valores[2],valores[1],valores[0]);
 
}

int computadorResponde() {
 	cout << "Modo do computador escolhido!\n";
	cout << "\nDeseja consultar as instruções? Se sim digite S, se não, digite outra tecla.\n";
	char inst;
	cin >> inst;
	inst = tolower(inst);
 	if (inst == 's') {
		instrucoes();
	}
	
 	string equacao;
	cout << "\nDigite uma equação linear ou quadrática:\n";
	cin.ignore();
 	getline(cin,equacao);
 	while (!ehValida(equacao)) {
		cout << "\nEquacao invalida\n\n";
		cout << "Digite Novamente\n";
		cin.ignore();
		getline(cin, equacao);
	}

	std::vector<std::string> splitted = split(equacao, ' ');

	simplificar(splitted);
	resolverEquacao(splitted);

 	// Invoca Funcao para simplificacao da expressao deixando ela no formato ax^2 + bx + c = 0. Essa função retorna por ex um array dessa forma ->[a, b, c] a,b e c precisam ser float.
	// se a equacao for linear o termo a será 0. Por fim fazemos:
	// calculaRaizes(arr[0], arr[1], arr[2]);
}


int main() {
 	setlocale(LC_ALL, "Portuguese");
 	int tamanho = 100;
    char str[100];
    FILE *logo;
    
    logo = fopen("data/logomarca.txt","rt");
	if(logo == NULL){
		cout << "Arquivo <logomarca.txt> não encontrado.\n";
	}else{
		while(!feof(logo)){
			fgets(str, tamanho, logo);
			cout << str;
		} 
		fclose(logo);
	}
 	char opcao;
	bool opInvalida = true;
 	do {
 		cout << "\n===========================================================================================\n";
		cout << "                                Bem vindo ao Equations Solver!\n";
		cout << "===========================================================================================\n";
		cout << "=========================================== MENU ==========================================";
		cout << "\n\nEscolha uma das opções abaixo:\n";
		cout << "\nModo Digitar equações (D)";
		cout << "\nModo Descobrir resultados (R)";
		cout << "\nEncerrar programa (E)\n";
 		cin >> opcao;
		opcao = tolower(opcao);
		opInvalida = (opcao != 'r' && opcao != 'd' && opcao != 'e');
 		if (opInvalida) {
			cout << "\nOpção inválida. Por favor tente novamente.\n\n";
			getchar();
			system("clear");
		}
 	} while (opInvalida);
 	if (opcao == 'd') {
		computadorResponde();
	}
	else if (opcao == 'r') {
		usuarioResponde();
	}
	else {
		exit(0);
	}
	return 0;
}
