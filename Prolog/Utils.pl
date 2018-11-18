show_logo :-
    open('data/logomarca.txt', read, Str),
    read_file(Str,String),
    close(Str),
    imprime(String), nl,nl.

imprime([]).
imprime([H|T]):- atomic_list_concat(H, " ", Result), write(Result), nl, imprime(T).

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

leituraNumber(X) :- 
    read_line_to_codes(user_input, X3),
    string_to_atom(X3,X2),
    atom_number(X2,X).

leitura(X) :- 
    read_line_to_codes(user_input, X2),
    string_to_atom(X2,X).

quebrandoQuestao(Questao, Result) :- 
    split_string(Questao, "&", "", Result).

questaoRandom(String, Result) :-
    lengthList(String, LengthList),
    random(0,LengthList,Index),
    nth1(Index, String, Elem),
    atomic_list_concat(Elem, " ", Result).

lengthList([], 0).
lengthList([_|Xs] , L ) :- lengthList(Xs,N), L is N+1.

sair :- halt(0).