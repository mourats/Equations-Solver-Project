:- include('Read.pl').

show_logo :-
    open('data/logomarca.txt', read, Str),
    read_file(Str,String),
    close(Str),
    nl,nl,
    imprime(String), nl,nl.

show_menu :-
    write("==========================================================================================="), nl,
    write("                                Bem vindo ao Equations Solver!                             "), nl,
    write("==========================================================================================="), nl,
    write("=========================================== MENU =========================================="), nl.

show_opcoes :-
    write("Escolha uma das opções abaixo:"),nl,
    write("[1] - Modo Digitar equações"),nl,
    write("[2] - Modo Descobrir resultados"),nl,
    write("[3] - Encerrar programa"),nl.

leitura(X) :- 
    read_line_to_codes(user_input, X3),
    string_to_atom(X3,X2),
    atom_number(X2,X).