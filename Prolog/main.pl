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
    leitura(Opcao) -> 
    (Opcao == 1, nl,writeln("Modo do computador escolhido!"), nl, modoComputador; 
    Opcao == 2, nl,writeln("Modo do usuário escolhido!"), nl, modoUsuario; 
    Opcao == 3, sair; 
    writeln("Opção Inválida!"),nl, opcaoModo).

modoComputador :- 
    halt(0).

modoUsuario :- 
    show_equatios_types,
    leitura(Option) -> 
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
    read_line_to_codes(user_input, X2),
    string_to_atom(X2,Resultado) ->
    (Resultado == 'E', halt(0);
    Resultado == Resposta, writeln("ACERTOU!"), respondendo(Arquivo);
    writeln("Errou! :( "), write("Resposta: "), writeln(Resposta), respondendo(Arquivo)).