:- initialization main.
:- use_module(library(pio)).
:- include('Utils.pl').
:- include('Read.pl').
:- include('Validador.PL').


main :-
    show_logo,
    menu.

menu :-
    show_menu,
    opcaoModo.

opcaoModo :- 
    show_opcoes,
    leituraNumber(Opcao) -> 
    (Opcao == 1, nl,writeln("Modo do computador escolhido!"), nl, modoComputador; 
    Opcao == 2, nl,writeln("Modo do usuário escolhido!"), nl, modoUsuario; 
    Opcao == 3, sair; 
    writeln("Opção Inválida!"),nl, opcaoModo).

modoComputador :- 
    writeln("Deseja consultar as instruções? Se sim digite S, se não, digite outra tecla."),
    writeln(""),
    leitura(Opcao),
    (Opcao == 'S'; Opcao == 's' -> instrucoes, loopGetEquacao); loopGetEquacao.

modoUsuario :- 
    show_equatios_types,
    leituraNumber(Option) -> 
    (Option == 1, leituraPrimeiroGrau(Result), respondendo(Result); 
    Option == 2, leituraSegundoGrau(Result), respondendo(Result); 
    Option == 3, menu; 
    writeln("Opção inválida. Por favor tente novamente."),nl, modoUsuario).

respondendo(Arquivo) :-
    nl, questaoRandom(Arquivo, Questao),
    quebrandoQuestao(Questao, Result),
    nth1(1, Result, Pergunta),
    nth1(2, Result, X),
    string_to_atom(X,Resposta),
    nth1(3, Result, Dica),
    writeln(Pergunta),
    writeln(Dica),
    writeln("Digite E para sair."),
    leitura(Resultado) ->
    (Resultado == 'E'; Resultado == 'e', sair;
    Resultado == Resposta, writeln("ACERTOU!"), respondendo(Arquivo);
    writeln("Errou! :( "), write("Resposta: "), writeln(Resposta), respondendo(Arquivo)).

loopGetEquacao :-
    nl, write("Caso queira retornar ao menu tecle M. Para Sair tecle S."), nl, 
    write("Digite uma equação linear ou quadrática:"), nl,
    leitura(Equacao) -> 
    (((Equacao == 'M'; Equacao == 'm'), menu);
    ((Equacao == 'S'; Equacao == 's'), sair);
    (Equacao == '', writeln("Entrada inválida."), loopGetEquacao);
    ehValidaEquacao(Equacao, Resposta), %! SETAR O 1 de Resposta == 1 PARA O VALOR ESPERADO POR QUEM IMPLEMENTOU 
    Resposta == 1 -> resolverEquacao(Equacao), loopGetEquacao;
    (writeln("Equação inválida! Por favor tente novamente."), loopGetEquacao)).

ehValidaEquacao(Eq, Resp) :- %! COLOCAR ESSA FUNÇÃO
    Resp is 1. 

simplificar(Eq, Simpl) :- %! COLOCAR ESSA FUNÇÃO
    Simpl is 12.

resolverEquacao(Eq) :-
    split_string(Eq, " ", "", Splitted), somarTermosComum(Splitted, TermosSomados), 
    nth0(2, TermosSomados, a),
    nth0(1, TermosSomados, b),
    nth0(0, TermosSomados, c),
    calculaRaizes(a, b, c). 

calculaRaizes(A, B, C) :-
    (A == 0 -> solucaoLinear(B, C));
    solucaoQuadratica(A, B, C).

solucaoLinear(A, B) :-
    A == 0 -> (writeln("A equação é linear porém a operação - b/a, gera uma divisão por zero, não possuindo solução."), nl);
    X is (((-1) * B) / A), write("A equação é linear e a sua solução é x = "), write(X), write("."), nl.

solucaoQuadratica(A, B, C) :-
    Delta is ((B * B) - (4 * A * C)),
    (((Delta < 0) -> write("O delta é negativo, "), write(Delta), write(" , assim a equação não possui solução no conjunto dos números reais."));
    ((Delta == 0) -> X is (((-1) * B) / (2 * A)), write("O delta é igual a zero, assim a equação possui duas soluções iguais a "), write(X), write("."));
    (
    Raiz is Delta ** (1/2),
    X1 is ((((-1) * B) + Raiz) / (2 * A)),
    X2 is ((((-1) * B) - Raiz) / (2 * A)),
    write("Como o delta é positivo, "), write(Delta), write(", a equação possui duas soluções distintas. São elas: "), writeln(""), write("x1 = "), write(X1), write(" e X2 = "), write(X2)), write("."), nl).
 
