#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define linhas 40
#define caracteres 200

int main()
{
  FILE *arq;
  char matriz[linhas][caracteres];
  char *result;
  int i;

  arq = fopen("data/equations-bd.txt", "rt");

  if (arq == NULL) {
     printf("Problemas na abertura do arquivo\n");
     return 0;
  }

  i = 0;
  while (!feof(arq)) {
      result = fgets(matriz[i], 200, arq);
      i++;
  }
  fclose(arq);
  
  int random;
  
  
  for(i = 0; i < 5; i++){
  random = rand() % 40;
  
  printf("%d\n", random);
  printf("%s", matriz[random]);
    
  }

  
  
}