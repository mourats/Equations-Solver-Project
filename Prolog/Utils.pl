
read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, String),
    atomic_list_concat(X,' ', String),
    read_file(Stream,L), !.

show_logo :-
    open('data/logomarca.txt', read, Str),
    read_file(Str,String),
    close(Str),
    nl,nl,
    imprime(String).

imprime([]).
imprime([H|T]):- write(H),nl, imprime(T).

show_menu :-
    write("==========================================================================================="), nl,
    write("                                Bem vindo ao Equations Solver!                             "), nl,
    write("==========================================================================================="), nl,
    write("=========================================== MENU =========================================="), nl.

show_opcoes :-
    write("Escolha uma das opções abaixo:"),nl,
    write("Modo Digitar equações (D)"),nl,
    write("Modo Descobrir resultados (R)"),nl,
    write("Encerrar programa (E)"),nl.