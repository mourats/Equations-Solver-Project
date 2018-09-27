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

#define linhas 40
#define caracteres 200

using namespace std;

bool ehValida(string equacao) {
	string state = "INICIAL";
	int parenteses = 0;
	int igual = 1;
	for (int i = 0; i < equacao.length(); ++i) 	{
		if (state == "INICIAL") {
			if (equacao[i] == 'x') {
				state = "X";
			}
			else if (isdigit(equacao[i])) {
				state = "DIGITO";
			}
			else if (equacao[i] == '(') {
				parenteses++;
				state = "PARENTESES";
			}
			else if (equacao[i] == '+' || equacao[i] == '-') {
				state = "SINAL";
			}
			else if (equacao[i] == ' ') {
			}
			else {
				return false;
			}
		}
		else if (state == "X") {
			if (equacao[i] == '^') {
				state = "^";
			}
			else if (equacao[i] == ' ') {
				state = "ESPACO";
			}
			else if (equacao[i] == '(') {
				parenteses++;
				state = "PARENTESES";
			}
			else if (equacao[i] == ')') {
				if (parenteses == 0) {
					return false;
				}
				parenteses--;
				state = "PARENTESES_FEC";
			}
			else {
				return false;
			}
		}
		else if (state == "DIGITO") {
			if (equacao[i] == ' ') {
				state = "ESPACO";
			}
			else if (equacao[i] == 'x') {
				state = "X";
			}
			else if (equacao[i] == '(') {
				parenteses++;
				state = "PARENTESES";
			}
			else if (isdigit(equacao[i])) {
			}
			else if (equacao[i] == ')') {
				if (parenteses == 0) {
					return false;
				}
				parenteses--;
				state = "PARENTESES_FEC";
			}
			else {
				return false;
			}
		}
		else if (state == "^") {
			if (isdigit(equacao[i])) {
				state = "EXPOENTE";
			}
			else {
				return false;
			}
		}
		else if (state == "EXPOENTE") {
			if (isdigit(equacao[i])) {
			}
			else if (equacao[i] == ' ') {
				state = "ESPACO";
			}
			else {
				return false;
			}
		}
		else if (state == "ESPACO") {
			if (equacao[i] == '+' || equacao[i] == '-' || equacao[i] == '*' || equacao[i] == '/') {
				state = "SINAL";
			}
			else if (equacao[i] == '=') {
				if (igual == 0) {
					return false;
				}
				igual--;
				state = "SINAL";
			}
			else if (equacao[i] == ' ') {
			}
			else {
				return false;
			}
		}
		else if (state == "SINAL") {
			if (equacao[i] == ' ') {
				state = "ESPACO_SINAL";
			}
			else {
				return false;
			}
		}
		else if (state == "ESPACO_SINAL") {
			if (equacao[i] == 'x') {
				state = "X";
			}
			else if (isdigit(equacao[i])) {
				state = "DIGITO";
			}
			else if (equacao[i] == '(') {
				parenteses++;
				state = "PARENTESES";
			}
			else {
				return false;
			}
		}
		else if (state == "PARENTESES") {
			if (equacao[i] == ')') {
				if (parenteses == 0) {
					return false;
				}
				parenteses--;
				state = "PARENTESES_FEC";
			}
			else if (equacao[i] == 'x') {
				state = "X";
			}
			else if (isdigit(equacao[i])) {
				state = "DIGITO";
			}
			else if (equacao[i] == '(') {
				parenteses++;
			}
			else {
				return false;
			}
		}
		else if (state == "PARENTESES_FEC") {
			if (equacao[i] == ')') {
				if (parenteses == 0) {
					return false;
				}
				parenteses--;
			}
			else if (equacao[i] == '(') {
				parenteses++;
				state = "PARENTESES";
			}
			else if (equacao[i] == ' ') {
				state = "ESPACO";
			}
			else if (equacao[i] == '^') {
				state = "EXPOENTE";
			}
			else {
				return false;
			}
		}
	}

	if (igual == 0 && parenteses == 0 && (state == "DIGITO" || state == "X" || state == "PARENTESES_FEC" || state == "EXPOENTE")) {
		return true;
	}
	else {
		return false;
	}
}

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
	cin >> equacao;
	getline(cin, equacao);

	while (!ehValida(equacao)) {
		cout << "\nEquacao invalida\n\n";
		cout << "Digite Novamente\n";
		cin >> equacao;
		getline(cin, equacao);
	}

	// Invoca Funcao para simplificacao da expressao deixando ela no formato ax^2 + bx + c = 0. Essa função retorna por ex um array dessa forma ->[a, b, c] a,b e c precisam ser float.
	// se a equacao for linear o termo a será 0. Por fim fazemos:
	// calculaRaizes(arr[0], arr[1], arr[2]);
}

/*
	for (int i = 0; i < equacao.length(); i++) {
		if (equacao[i] == "=") {
			if (i != (equacao.length - 1)) {
				
			}
		} 
	}
	*/


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
	cout <<std::endl << "Modo do usuário escolhido!"<<std::endl;
	cout << "As respostas são sempre um número (2, 5, -9, 2/3) ou V"<<std::endl;
	cout << "V - Representa que o conjunto solução é vazio para o domínio dos Reais."<<std::endl<<std::endl;
	cout << "Caso deseje sair, digite <s>"<<std::endl<<std::endl;
	FILE *arq;
	char matriz[linhas][caracteres];
	char *result;
	int i;
	int random;
	char returned[linhas];
	bool disponivel = false;
	bool guard = true;
	char answer[8];
	

	arq = fopen("data/equations-bd.txt", "rt");

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
		
		if(!strcmp(answer, "s")){
			guard = false;
		} else if(answer == splittedQuest[1]){
			cout << "Acertou!"<<std::endl<<std::endl;
		}else{
			cout << "Errou!"<<std::endl<<std::endl;
		}

	} while (guard);
}

int main() {

	setlocale(LC_ALL, "Portuguese");

	int tamanho = 10;
    char str[100];
    FILE *logo;
    
    logo = fopen("C:/Users/USUARIO/Documents/Gabriel/UFCG/plp/Equations Solver/Equations-Solver-Project/C++/logomarca.txt","r"); // TA BUGADO, SE NÃO COLOCAR O CAMINHO TODO NÃO PEGA, POREM DEVERIA PORQUE O ARQUIVO ESTÁ NA MESMA PASTA QUE O MAIN
	if(logo == NULL){
		cout << "Arquivo <logomarca.txt> não encontrado.\n";
	}else{
		while(!feof(logo)){
			fgets(str, tamanho, logo);
			cout << str << endl;
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
		cout << "\nEncerrar programa (S)\n";

		cin >> opcao;
		opcao = tolower(opcao);
		opInvalida = (opcao != 'r' && opcao != 'd' && opcao != 's');

		if (opInvalida) {
			cout << "\nOpção inválida. Por favor tente novamente.\n\n";
			system("pause");
			system("cls");
		}

	} while (opInvalida);


	if (opcao == 'd')
	{
		computadorResponde();
	}
	else if (opcao == 'r')
	{
		usuarioResponde();
	}
	else
	{
		exit(0);
	}

	return 0;
}
