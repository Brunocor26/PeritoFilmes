% Sistema Pericial - Identificação de Filmes
perito :-
    write('Sistema Pericial - Identificação de Filmes'), nl,
    write('Escolha uma opção: '), nl,
    esperaOrdens.

esperaOrdens :-
    write('Escolha uma opção: '), nl,
    write('1 - Consultar uma Base de Conhecimento (BC)'), nl,
    write('2 - Solucionar'), nl,
    write('3 - Sair'), nl,
    read(Comando),
    executa(Comando).

executa(1) :-
    write('Nome da BC: '),
    read(F),
    consult(F),
    write('BC consultada com sucesso.'), nl,
    esperaOrdens.

executa(2) :-
    soluciona,
    esperaOrdens.

executa(3) :-
    write('A sair...'), nl, halt.

% Identificação do filme
soluciona :-
    abolish(conhece, 3),
    asserta(conhece(def, def, def)),
    questiona_genero(Genero),
    questiona_pais(Pais),
    questiona_ano(Ano),
    resolve_filme(Genero, Pais, Ano, Filme),
    write('Resposta encontrada: '), write(Filme), nl.

soluciona :-
    nl, nl, write('Não foi encontrada resposta :-( '), nl.

% Perguntas para o utilizador
questiona_genero(Genero) :-
    write('Qual o genero do filme? '),
    read(Genero),
    asserta(conhece(sim, genero, Genero)).

questiona_pais(Pais) :-
    write('Qual o país de origem do filme? '),
    read(Pais),
    asserta(conhece(sim, pais, Pais)).

questiona_ano(Ano) :-
    write('Qual o ano de lançamento do filme? '),
    read(Ano),
    asserta(conhece(sim, ano, Ano)).

% Resolução do filme baseado nas respostas
resolve_filme(Genero, Pais, Ano, Filme) :-
    filme(Filme),
    verifica_genero(Genero),
    verifica_pais(Pais),
    verifica_ano(Ano).

verifica_genero(Genero) :-
    genero(Genero),
    !.

verifica_pais(Pais) :-
    pais(Pais),
    !.

verifica_ano(Ano) :-
    ano(Ano),
    !.
