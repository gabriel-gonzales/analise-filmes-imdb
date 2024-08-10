# Análise de Dados de Filmes do IMDb

Este é um projeto de análise de dados de filmes do IMDb, onde foi explorado diferentes aspectos dos filmes, como distribuição do ano de lançamento, duração, classificações e gêneros.

## Objetivo

O principal objetivo deste projeto é praticar e aprimorar técnicas de análise de dados, enquanto simultaneamente se familiariza com ferramentas essenciais no meio, como Git, GitHub e R.

## Conjunto de Dados

Os dados foram obtidos do IMDb e consistem em dois conjuntos de dados:

titles: Contém informações sobre os filmes, como título, gênero, duração, ano de lançamento, entre outros.

ratings: Contém informações sobre as avaliações dos filmes, incluindo a média de classificação e o número de votos.

## Estrutura do Projeto

 dados: Este diretório contém os conjuntos de dados originais em formato TSV (Tab-Separated Values).
 
 plots: Este diretório contém as visualizações geradas a partir dos dados.
 
 filmes_limpos.csv: Arquivo CSV contendo os dados limpos e filtrados usados nas análises.

## Análises Realizadas

- Distribuição do Ano de Lançamento: Visualização da distribuição dos anos de lançamento dos filmes.

- Distribuição da Duração dos Filmes: Histograma mostrando a distribuição da duração dos filmes em minutos.

- Distribuição das Classificações dos Filmes: Gráfico de pizza mostrando a distribuição das classificações dos filmes.

- Distribuição dos Filmes por Gênero: Gráfico de barras mostrando a distribuição dos filmes por gênero.

- Relação entre Duração e Avaliação dos Filmes: Gráfico de dispersão mostrando a relação entre a duração e a avaliação dos filmes, com uma linha de tendência.


## Requisitos

    R (https://www.r-project.org/)
    Pacotes necessários: dplyr, readr, ggplot2

## Como Executar

Clone este repositório:

    git clone https://github.com/seu-usuario/nome-do-repositorio.git

Instale os pacotes necessários no R:

    install.packages(c("dplyr", "readr", "ggplot2"))
    

Execute o script R analise_filmes.R.

Os resultados das análises serão gerados na pasta plots.



## Contribuição

Sinta-se à vontade para contribuir com melhorias, correções de bugs ou novas análises. Basta criar um fork deste repositório, fazer suas alterações e enviar um pull request.


