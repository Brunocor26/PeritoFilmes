import re

# Abrir o arquivo contendo os dados Prolog
with open('filmes.pl', 'r') as file:
    data = file.read()

# Regex ajustada para capturar o título do filme, os gêneros, a classificação IMDb e outros dados
pattern = r"filme\('([^']+)'\)\s*:\-\s*genero\(([^)]+)\)[^:]*pais\('([^']+)'\)[^:]*ano\((\d{4})\)[^:]*duracao\('([^']+)'\)[^:]*classificacao_imdb\(([^)]+)\)[^:]*classificacao_mpa\('([^']+)'\)[^:]*realizador\('([^']+)'\)[^:]*atores\(\[([^\]]+)\]\)"

# Encontrar todas as correspondências
matches = re.findall(pattern, data)

# Verifique se encontrou filmes
if not matches:
    print("Nenhuma correspondência encontrada.")
else:
    # Lista para armazenar os filmes e seus dados
    movies = []

    # Processar cada filme
    for match in matches:
        title = match[0]
        genres = match[1].split(", ")
        country = match[2]
        year = match[3]
        duration = match[4]
        imdb_rating = float(match[5])
        classification_mpa = match[6]
        director = match[7]
        actors = match[8].split(", ")

        # Adicionar o filme à lista
        movies.append({
            'title': title,
            'genres': genres,
            'country': country,
            'year': year,
            'duration': duration,
            'imdb_rating': imdb_rating,
            'classification_mpa': classification_mpa,
            'director': director,
            'actors': actors
        })

    # Ordenar os filmes pela classificação IMDb em ordem decrescente e pegar os top 500
    top_500_movies = sorted(movies, key=lambda x: x['imdb_rating'], reverse=True)[:500]

    # Gerar os dados para o arquivo de saída no formato correto
    output_data = "\n\n".join([
        f"filme('{movie['title']}') :-\n    " + \
        "\n    ".join([f"genero('{genre}')," for genre in movie['genres']]) + \
        f"\npais('{movie['country']}'),\nano({movie['year']}),\nduracao('{movie['duration']}'),\n" + \
        f"classificacao_imdb({movie['imdb_rating']:.1f}),\n" + \
        f"classificacao_mpa('{movie['classification_mpa']}'),\nrealizador('{movie['director']}'),\n" + \
        f"atores([{', '.join([f"'{actor}'" for actor in movie['actors']])}])."
        for movie in top_500_movies
    ])

    # Escrever no arquivo de saída
    with open('filmes_500.pl', 'w') as output_file:
        output_file.write(output_data)

    print("Os 500 filmes principais foram escritos em filmes_500.pl.")
