import pandas as pd

# Carregar o ficheiro CSV
file_path = 'dados/top500.csv'
data = pd.read_csv(file_path)

# Função para gerar a base de conhecimento em Prolog
def gerar_base_conhecimento(data):
    conhecimento = []

    # Cabeçalho do conhecimento
    conhecimento.append("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
    conhecimento.append("%% Conhecimento sobre Filmes.")
    conhecimento.append("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n")

    # Iterar sobre as linhas do DataFrame e gerar o conhecimento para cada filme
    for index, row in data.iterrows():
        titulo = row['title']
        
        # Verificar se 'genre' não é NaN e se for, fazer split
        if isinstance(row['genre'], str):
            genero = row['genre'].split(', ')
        else:
            genero = []
        
        pais = row['country_origin']
        ano = row['year']
        duracao = row['duration']
        classificacao_imdb = row['rating_imdb']
        classificacao_mpa = row['rating_mpa'] if pd.notna(row['rating_mpa']) else 'NaN'
        realizador = row['director']
        
        # Verificar se 'star' não é NaN e se for, dividir a string de atores
        if isinstance(row['star'], str):
            atores = row['star'].split(', ')
        else:
            atores = []
        
        # Predicado do filme
        conhecimento.append(f"filme('{titulo}') :-")

        for g in genero:
            conhecimento.append(f"    genero('{g.strip()}'),")
        
        conhecimento.append(f"    pais('{pais}'),")
        conhecimento.append(f"    ano({ano}),")
        conhecimento.append(f"    duracao('{duracao}'),")
        conhecimento.append(f"    classificacao_imdb({classificacao_imdb}),")
        conhecimento.append(f"    classificacao_mpa('{classificacao_mpa}'),")
        conhecimento.append(f"    realizador('{realizador}'),")
        
        atores_str = ", ".join([f"'{ator.strip()}'" for ator in atores])
        conhecimento.append(f"    atores([{atores_str}]).\n")

    # Categorias de Géneros
    conhecimento.append("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
    conhecimento.append("%% Categorias de Géneros.")
    conhecimento.append("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n")

    generos = set()
    for index, row in data.iterrows():
        if isinstance(row['genre'], str):
            generos.update(row['genre'].split(', '))

    for genero in generos:
        conhecimento.append(f"genero('{genero.strip()}').")

    # Dados adicionais (pais, realizadores, etc.)
    conhecimento.append("\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
    conhecimento.append("%% Dados adicionais.")
    conhecimento.append("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n")

    paises = set(data['country_origin'])
    for pais in paises:
        conhecimento.append(f"pais('{pais}').")
    
    realizadores = set(data['director'])
    for realizador in realizadores:
        conhecimento.append(f"realizador('{realizador}').")
    
    return "\n".join(conhecimento)

# Gerar o conhecimento em formato Prolog
conhecimento_prolog = gerar_base_conhecimento(data)

# Salvar em um arquivo .pl
output_path = 'filmes.pl'
with open(output_path, 'w') as file:
    file.write(conhecimento_prolog)

output_path
