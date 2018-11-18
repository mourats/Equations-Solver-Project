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
    nth0(Index, String, Elem),
    atomic_list_concat(Elem, " ", Result).

lengthList([], 0).
lengthList([_|Xs] , L ) :- lengthList(Xs,N), L is N+1.

sair :- halt(0).

instrucoes :-
    writeln("====================================== INSTRUÇÕES ========================================="),nl,
    writeln("1) A variável usada deve ser sempre x;"),
	writeln("2) É necessário que os termos sejam separados por espaço e os sinais também."),nl,
    writeln("Exemplos de expressões VÁLIDAS:"),nl,
    writeln("a) x * x = 4"),
	writeln("b) x^2 / 1 = 9"),
	writeln("c) 18x - 43 = 65"),
	writeln("d) x^2 + 5x / 2 - 3 / 2 = 0"),nl,
    writeln("Exemplos de expressões INVÁLIDAS:"),nl,
	writeln("a) 2y^2 - 8 = 0 - Não é aceito outra variável que não seja x."),
	writeln("d) x^2 + 5x/2 - 3/2 = 0 - É necessário ter espaços entre o termo e o /."),
	writeln("e) 3x^2 - 24x + 5 = -6x^2 - 11 -É necessário ter espaço entre o - e o 6."),nl.