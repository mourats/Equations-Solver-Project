:- initialization main.
:- use_module(library(pio)).
:- include('Utils.pl').

main :-
    show_logo,
    menu.

menu :-
    show_menu,
    show_opcoes,
    read_opcao(Opcao).

read_opcao(Opcao) :-
    read(Option).