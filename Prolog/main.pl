:- initialization main.
:- use_module(library(pio)).
:- include('Utils.pl').
:- include('Read.pl').

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
    sair).
    /*
    REMOVE O sair 
    ,
    ehValidaEquacao(Equacao, Resposta), 
    ((Resposta != ALGO_DEFINIDO) -> writeln("Equação inválida! Por favor tente novamente."), loopGetEquacao);
    ((Resposta == ALGO_DEFINIDO) -> write("VAMOS SIMPLIFICAR!")).
    */