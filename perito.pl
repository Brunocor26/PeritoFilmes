perito :-
    write('Concha simples de Sistema Pericial'), nl,
    write('Versao de 2024'), nl, nl,
    esperaOrdens.

esperaOrdens :-
    write('Comandos disponiveis (introduza o numero "1.", "2." ou "3."):'),
    nl,
    write('1 - Consultar uma Base de Conhecimento (BC)'), nl,
    write('2 - Solucionar'), nl,
    write('3 - Sair'), nl,
    write('> '),
    read(Comando),
    executa(Comando).

executa(1) :-
    write('Nome da BC: '),
    read(F),
    consult(F),
    write('BC consultada com sucesso.'), nl, nl,
    esperaOrdens.

executa(2) :-
    soluciona,
    esperaOrdens.

executa(3) :-
    nl,
    write('Volte Sempre!'), nl,
    write('Qualquer tecla para sair.'),
    get0(_),
    halt.

executa(_) :-
    write('Comando nao valido!'), nl,
    esperaOrdens.

soluciona :-
    write('Qual o ano do filme? '),
    read(Ano),
    write('Qual o realizador do filme? '),
    read(Realizador),
    write('Qual o genero do filme? '),
    read(Genero),
    consultar_ano(Ano, Filme),
    consultar_realizador(Realizador, Filme),
    consultar_genero(Genero, Filme),
    write('Filme encontrado: '), write(Filme), nl.

soluciona :-
    write('Nao foi encontrado nenhum filme com as caracteristicas fornecidas.'), nl.
