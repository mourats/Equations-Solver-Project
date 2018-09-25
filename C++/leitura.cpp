#include <stdio.h>

int main()
{
  FILE *arq;
  char Linha[45][200];
  char *result;
  int i;

  // Abre um arquivo TEXTO para LEITURA
  arq = fopen("banco de equações do segundo grau.txt", "rt");
  if (arq == NULL)  // Se houve erro na abertura
  {
     printf("Problemas na abertura do arquivo\n");
     return 0;
  }
  i = 0;
  while (!feof(arq)){
      result = fgets(Linha[i], 200, arq);
      if(i >= 4){
       if (result)  // Se foi possível ler
	      printf("Linha %d : %s",i,Linha[i]);
      }
      i++;
  }
  fclose(arq);
}