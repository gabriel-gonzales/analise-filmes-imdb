# Instalar pacotes necessários (caso ainda não estejam instalados)
install.packages(c("dplyr", "ggplot2", "readr"))

# Carregar pacotes
library(dplyr)
library(ggplot2)
library(readr)

# Definir a URL do conjunto de dados do IMDB
url <- "https://datasets.imdbws.com/title.basics.tsv.gz"

# Fazer download do arquivo
download.file(url, destfile = "title.basics.tsv.gz")

# Ler os dados no R
data <- read_tsv("title.basics.tsv.gz")

# Inspecionar os dados
head(data)