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

show_equatios_types :-
    write("Escolha um tipo de equação:"),nl,
    write("[1] - Primeiro Grau "),nl,
    write("[2] - Segundo Grau"),nl,
    write("[3] - Caso deseje voltar ao menu."),nl.

leitura(X) :- 
    read_line_to_codes(user_input, X3),
    string_to_atom(X3,X2),
    atom_number(X2,X).

lengthList([], 0).
lengthList([_|Xs] , L ) :- lengthList(Xs,N), L is N+1.


leituraPrimeiroGrau:- 
    open('data/first-degree-equations-bd.txt', read, Str),
    read_file(Str,String),
    close(Str),
    lengthList(lengthList, String),
    random(0,lengthList,Index),
    nth0(Index, String, Elem),
    writeln(Elem),halt(0).

leituraPrimeiroGrau:- 
    open('data/second-degree-equations-bd.txt', read, Str),
    read_file(Str,String),
    close(Str),
    lengthList(String, LengthList),
    random(0,LengthList,Index),
    nth0(Index, String, Elem),
    writeln(Elem),halt(0).