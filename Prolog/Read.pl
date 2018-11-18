read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, String),
    atomic_list_concat(X,' ', String),
    read_file(Stream,L), !.

leituraPrimeiroGrau(Result) :- 
    open('data/first-degree-equations-bd.txt', read, Str),
    read_file(Str,Result),
    close(Str).

leituraSegundoGrau(Result) :- 
    open('data/second-degree-equations-bd.txt', read, Str),
    read_file(Str,Result),
    close(Str).