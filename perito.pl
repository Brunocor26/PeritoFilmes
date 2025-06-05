iniciar :-
    write('Sistema Pericial sobre Filmes'), nl,
    write('Bem-vindo ao especialista em filmes!'), nl, nl,
    aguardar_comando(123).

aguardar_comando(KC) :-
    exibir_comandos(KC),
    write('> '),
    read(Comando),
    processar_comando(KC,Comando).

exibir_comandos(123) :-
    write('Comandos disponíveis (introduza 1, 2 ou 3):'), nl,
    write('1 - Carregar uma Base de Conhecimento'), nl,
    write('2 - Resolver'), nl,
    write('3 - Sair'), nl.

exibir_comandos(23) :-
    write('Comandos disponíveis (introduza 2 ou 3):'), nl,
    write('2 - Resolver'), nl,
    write('3 - Sair'), nl.

processar_comando(_,1) :-
    write('Nome do ficheiro da Base de Conhecimento: '),
    read(F),
    consult(F),
    write('Base de conhecimento carregada com sucesso.'), nl, nl,
    continuar.

processar_comando(_,2) :-
    resolver,
    aguardar_comando(23).

processar_comando(_,3) :-
    nl,
    write('Até a próxima!'), nl,
    write('Insira qualquer tecla para sair.'), nl,
    get0(_),
    halt.

processar_comando(KC,X) :-
    write(X),
    write(' não é válido!'), nl,
    aguardar_comando(KC).

continuar :-
    aguardar_comando(23).

resolver :-
    abolish(conhecimento,3),
    asserta(conhecimento(def,def,def)),
    objetivo(Y),
    nl, nl, write('Resultado encontrado: '),
    write(Y),
    nl, nl.
resolver :-
    nl, nl, write('Nenhuma resposta encontrada :-('), nl.

questionar(Atributo,Valor) :-
    conhecimento(sim,Atributo,Valor).
questionar(Atributo,Valor) :-
    conhecimento(_,Atributo,Valor), !, fail.
questionar(Atributo,Valor) :-
    write(Atributo:Valor),
    write('? (sim/não) '),
    read(R),
    processar_resposta(R,Atributo,Valor).

processar_resposta(sim,Atributo,Valor) :-
    asserta(conhecimento(sim,Atributo,Valor)).
processar_resposta(R,Atributo,Valor) :-
    asserta(conhecimento(R,Atributo,Valor)),!,
    fail.

questionar(Atr,Val,_) :-
    conhecimento(sim,Atr,Val).
questionar(Atr,_,_) :-
    conhecimento(sim,Atr,_), !, fail.
questionar(Atr,Val,ListaOpcoes) :-
    write('Qual o valor para '),
    write(Atr),
    write('? '), nl,
    write(ListaOpcoes), nl,
    read(X),
    processar_opcao(X,Atr,Val,ListaOpcoes).

processar_opcao(Val,Atr,Val,_) :-
    asserta(conhecimento(sim,Atr,Val)).
processar_opcao(X,Atr,_,ListaOpcoes) :-
    member(X,ListaOpcoes),
    asserta(conhecimento(sim,Atr,X)), !, fail.
processar_opcao(X,Atr,Val,ListaOpcoes) :-
    write(X),
    write(' não é valor aceito!'), nl,
    questionar(Atr,Val,ListaOpcoes).
