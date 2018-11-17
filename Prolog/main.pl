:- initialization main.
:- use_module(library(pio)).
:- include('Utils.pl').

main :-
    show_logo,
    menu.

menu :-
    show_menu,
    opcaoModo.

opcaoModo :- 
    show_opcoes,
    leitura(Opcao) -> 
    (Opcao == 1, modoComputador; 
    Opcao == 2, modoUsuario; 
    Opcao == 3, sair; 
    writeln("Opção Inválida!"),nl, opcaoModo).

modoComputador :- 
    writeln("Modo do computador escolhido!"), halt(0).

modoUsuario :-
    nl, writeln("Modo do usuário escolhido!"), 
    show_equatios_types,
    leitura(Option) -> 
    (Option == 1, leituraPrimeiroGrau; 
    Option == 2, leituraPrimeiroGrau; 
    Option == 3, menu; 
    writeln("Opção inválida. Por favor tente novamente."),nl, modoUsuario).

sair :- halt(0).