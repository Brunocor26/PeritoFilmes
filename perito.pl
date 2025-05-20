% perito.pl
% Concha do sistema pericial

:- dynamic conhece/3.

perito :-
    write('Concha simples de Sistema Pericial'), nl,
    write('Versao de 2025'), nl, nl,
    esperaOrdens(123).

esperaOrdens(123) :-
    write('Comandos disponiveis (introduza 1, 2 ou 3):'), nl,
    write('1 - Consultar uma Base de Conhecimento (BC)'), nl,
    write('2 - Solucionar'), nl,
    write('3 - Sair'), nl,
    write('> '),
    read(Comando),
    executa(Comando).

esperaOrdens(23) :-
    write('Comandos disponiveis (introduza 2 ou 3):'), nl,
    write('2 - Solucionar'), nl,
    write('3 - Sair'), nl,
    write('> '),
    read(Comando),
    executa(Comando).

executa(1) :-
    write('Nome da BC: '),
    read(Ficheiro),
    catch(consult(Ficheiro), _, (write('Erro ao carregar a BC.'), nl, esperaOrdens(123))),
    write('BC consultada com sucesso.'), nl, nl,
    esperaOrdens(23).

executa(2) :-
    soluciona,
    esperaOrdens(23).

executa(3) :-
    nl, write('Volte Sempre!'), nl, halt.

executa(_) :-
    write('Comando invalido.'), nl,
    esperaOrdens(123).

soluciona :-
    retractall(conhece(_,_,_)),
    ( objectivo(X) ->
        nl, write('Resposta encontrada: '), write(X), nl
    ; 
        nl, write('Nao foi encontrada resposta :-('), nl
    ).

questiona(Atributo, Valor) :-
    conhece(sim, Atributo, Valor).
questiona(Atributo, Valor) :-
    conhece(_, Atributo, Valor), !, fail.
questiona(Atributo, Valor) :-
    format('~w: ~w? (sim/nao) ', [Atributo, Valor]),
    read(Resposta),
    processa(Resposta, Atributo, Valor).

processa(sim, Atributo, Valor) :-
    asserta(conhece(sim, Atributo, Valor)).
processa(nao, Atributo, Valor) :-
    asserta(conhece(nao, Atributo, Valor)), !, fail.
processa(_, Atributo, Valor) :-
    write('Resposta invalida, tenta novamente.'), nl,
    questiona(Atributo, Valor).
    
questiona(Atr, Val, Opcoes) :-
    conhece(sim, Atr, Val).
questiona(Atr, _, _) :-
    conhece(sim, Atr, _), !, fail.
questiona(Atr, Val, Opcoes) :-
    format('Qual o valor para ~w? ', [Atr]), nl,
    write(Opcoes), nl,
    read(Resp),
    processa_menu(Resp, Atr, Val, Opcoes).

processa_menu(Val, Atr, Val, _) :-
    asserta(conhece(sim, Atr, Val)).
processa_menu(Resp, Atr, _, Opcoes) :-
    member(Resp, Opcoes), !, asserta(conhece(sim, Atr, Resp)), fail.
processa_menu(Resp, Atr, _, _) :-
    format('~w nao e valor aceite!~n', [Resp]),
    questiona(Atr, _, _).

