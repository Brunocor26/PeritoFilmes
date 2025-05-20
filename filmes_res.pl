%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filmes.pl - Base de Conhecimento para Filmes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exemplo simples com alguns filmes e características

filme(avatar) :-
    genero(avatar, acao),
    ano(avatar, 2009),
    diretor(avatar, cameron),
    pais(avatar, usa).

filme(titanic) :-
    genero(titanic, drama),
    ano(titanic, 1997),
    diretor(titanic, cameron),
    pais(titanic, usa).

filme(interstellar) :-
    genero(interstellar, ficcao),
    ano(interstellar, 2014),
    diretor(interstellar, nolan),
    pais(interstellar, usa).

% Definir os predicados questionaveis, que pedem input ao utilizador

genero(Filme, Genero) :-
    questiona(genero, Genero, [acao, drama, comedia, ficcao, terror, aventura]).

ano(Filme, Ano) :-
    questiona(ano, Ano).

diretor(Filme, Diretor) :-
    questiona(diretor, Diretor, [cameron, nolan, spielberg, scorsese]).

pais(Filme, Pais) :-
    questiona(pais, Pais, [usa, reino_unido, canada, frança]).

% Define o objectivo para o perito.pl
objectivo(Filme) :-
    filme(Filme).
