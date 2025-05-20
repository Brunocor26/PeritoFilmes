import re

def converter_filmes_pl(input_path, output_path):
    with open(input_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Regex para capturar cada bloco 'filme(...) :- ... .'
    blocos = re.findall(r"filme\('([^']+)'\) *:- *([^\.]+)\.", content, re.DOTALL)

    with open(output_path, 'w', encoding='utf-8') as out:
        out.write("% Base convertida para formato perito.pl\n\n")

        out.write("filme(F) :- filme(F).\n\n")  # regra base

        for filme_nome, corpo in blocos:
            # extrair os predicados e argumentos do corpo
            linhas = [l.strip() for l in corpo.split(',')]
            for linha in linhas:
                # match predicado('valor') ou atores(['valores'])
                m = re.match(r"(\w+)\('([^']+)'\)", linha)
                if m:
                    pred, val = m.group(1), m.group(2)
                    regra = f"{pred}('{filme_nome}', '{val}') :- filme('{filme_nome}').\n"
                    out.write(regra)
                else:
                    # tratar lista atores(['A','B',...])
                    m_lista = re.match(r"atores\(\[([^\]]+)\]\)", linha)
                    if m_lista:
                        atores_str = m_lista.group(1)
                        atores = re.findall(r"'([^']+)'", atores_str)
                        for ator in atores:
                            regra = f"ator('{filme_nome}', '{ator}') :- filme('{filme_nome}').\n"
                            out.write(regra)

        # objectivo
        out.write("\nobjectivo(Filme) :- filme(Filme).\n")

if __name__ == "__main__":
    converter_filmes_pl("filmes.pl", "filmes_perito.pl")
