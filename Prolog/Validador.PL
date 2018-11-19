sinal(-).
sinal(/).
sinal(+).
sinal(*).
numero('0').
numero('1').
numero('2').
numero('3').
numero('4').
numero('5').
numero('6').
numero('7').
numero('8').
numero('9').
initial(inicial).
final(digito).
final(x).
final(expoente).
final(espaco).
transicao(inicial,' ',inicial).
transicao(inicial,X,sinal) :-
    sinal(X).
transicao(inicial,x,x).
transicao(inicial,X,digito) :- 
    numero(X).
transicao(x,^,^).
transicao(x,' ',espaco).
transicao(digito,' ',espaco).
transicao(digito,x,x).
transicao(digito,X,digito):-
    numero(X).
transicao(^,X,expoente):-
    numero(X).
transicao(expoente,X,expoente) :-
    numero(X).
transicao(expoente,' ',espaco).
transicao(espaco,X,sinal):-
    sinal(X).
transicao(espaco,' ',espaco).
transicao(espaco,=,igual).
transicao(sinal,' ',espaco_sinal).
transicao(espaco_sinal,x,x).
transicao(espaco_sinal,X,digito):-
    numero(X).
transicao(espaco_sinal,' ',espaco_sinal).
transicao(igual,' ',inicial).

/** uma String deve ser passada como argumento,por exemplo "3x + 5 = 7" **/
test(Words) :-
    atom_chars(Words,Lista),
    initial(Node),
    recognize(Node,Lista).

recognize(Node,[]) :-
    final(Node).

recognize(FromNode,String) :-
    transicao(FromNode,Label,ToNode),
    traverse(Label,String,NewString),
    recognize(ToNode,NewString).


traverse(First,[First|Rest],Rest).

grauTermo(String,Result):- 
    atom_chars(String,Array),
    getGrauTermoAux(Array,true,false,[],Aux),
    atom_number(Aux,Result).

getGrauTermoAux([],_,_,[],Result) :-
    atomic_list_concat(['0'], Result).
    
getGrauTermoAux([],_,_,Grau,Result) :- 
    atomic_list_concat(Grau, Result).

getGrauTermoAux(String,false,true,Grau,Result):-
    listsplit(String,Head,Tail),
    atom_chars(Head, Aux),
    append(Grau,Aux,GrauAux),
    getGrauTermoAux(Tail,false,true, GrauAux,Result).

getGrauTermoAux(String,_,_,_,Result):-
    listsplit(String,Head,Tail),
    Head == x,
    getGrauTermoAux(Tail,false,false,['1'],Result).

getGrauTermoAux(String,_,_,_,Result):-
    listsplit(String,Head,Tail),
    Head == ^,
    getGrauTermoAux(Tail,false,true,[],Result).

getGrauTermoAux(String,_,_,_,Result):-
    listsplit(String,_,Tail),
    getGrauTermoAux(Tail,true,false,[],Result).

getConstante(String,Result):-
    atom_chars(String,Array),
    getConstanteAux(Array,false,[],Aux),
    atom_number(Aux,Result).

getConstanteAux([],_,Constante,Result):-
    atomic_list_concat(Constante, Result).

getConstanteAux(String,_,Constante,Result):-
    listsplit(String,Head,Tail),
    numero(Head),
    atom_chars(Head, Aux),
    append(Constante,Aux,ConstanteAux),
    getConstanteAux(Tail,true,ConstanteAux,Result).

getConstanteAux(String,false,_,Result):-
    listsplit(String,Head,_),
    not(numero(Head)),
    atomic_list_concat(['1'], Result).

getConstanteAux(_,_,Constante,Result):-
    atomic_list_concat(Constante, Result).

/** Uma lista de Strings deve ser passada como argumento, por exemplo:
 * ["x^2","2x"," =","0"] **/
somarTermosComum(String,Result):-
    somarTermosComumAux(String,0,false,[0,0,0],Result).

somarTermosComumAux(String,I,_,ResultAux,Result):-
    length(String,Valor),
    Valor == I,
    Result = ResultAux.
somarTermosComumAux(String,I,_,ResultAux,Result):-
    nth0(I,String, Element),
    Element == "=",
    PI is I+1,
    somarTermosComumAux(String,PI,true,ResultAux,Result).

somarTermosComumAux(String,I,Igual,ResultAux,Result):-
    nth0(I,String, Element),
    Element == "+" ; Element == "-",
    PI is I+1,
    somarTermosComumAux(String,PI,Igual,ResultAux,Result).

somarTermosComumAux(String,I,true,ResultAux,Result):-
    I > 0,
    LI is I - 1,
    nth0(LI,String, Sinal),
    Sinal == "-",
    nth0(I,String,Element),
    grauTermo(Element,Indice),
    getConstante(Element,Valor),    
    nth0(Indice,ResultAux,ValorAtual),
    NovoValor is ValorAtual + Valor,
    replace(ResultAux,Indice,NovoValor,NovoResultAux),
    PI is I + 1,
    somarTermosComumAux(String,PI,true,NovoResultAux,Result).


somarTermosComumAux(String,I,true,ResultAux,Result):-
    nth0(I,String,Element),
    grauTermo(Element,Indice),
    getConstante(Element,Valor),    
    nth0(Indice,ResultAux,ValorAtual),
    NovoValor is ValorAtual - Valor,
    replace(ResultAux,Indice,NovoValor,NovoResultAux),
    PI is I+1,
    somarTermosComumAux(String,PI,true,NovoResultAux,Result).

somarTermosComumAux(String,I,false,ResultAux,Result):-
    I > 0,
    LI is I - 1,
    nth0(LI,String, Sinal),
    Sinal == "-",
    nth0(I,String,Element),
    grauTermo(Element,Indice),
    getConstante(Element,Valor),    
    nth0(Indice,ResultAux,ValorAtual),
    NovoValor is ValorAtual - Valor,
    replace(ResultAux,Indice,NovoValor,NovoResultAux),
    PI is I+1,
    somarTermosComumAux(String,PI,false,NovoResultAux,Result).

somarTermosComumAux(String,I,false,ResultAux,Result):-
    nth0(I,String,Element),
    grauTermo(Element,Indice),
    getConstante(Element,Valor),    
    nth0(Indice,ResultAux,ValorAtual),
    NovoValor is ValorAtual + Valor,
    replace(ResultAux,Indice,NovoValor,NovoResultAux),
    PI is I+1,
    somarTermosComumAux(String,PI,false,NovoResultAux,Result).

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 0,
    I1 is I - 1,
    replace(T, I1, X, R).

listsplit([H|T], H, T).





    





