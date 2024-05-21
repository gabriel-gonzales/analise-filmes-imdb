# Carregar pacotes necessários
library(dplyr)
library(readr)

# Carregar dados do IMDb
data <- read_tsv("title.basics.tsv.gz")

# Limpeza de dados

# 1. Filtrar apenas filmes
filmes <- data %>% 
  filter(titleType == "movie")

# 2. Remover entradas com dados ausentes
filmes <- filmes %>% 
  filter(!is.na(startYear) & !is.na(runtimeMinutes))

# 3. Selecionar colunas relevantes e converter tipos de dados
filmes <- filmes %>% 
  select(primaryTitle, startYear, runtimeMinutes, genres) %>%
  mutate(startYear = as.numeric(startYear)) %>%
  filter(!is.na(startYear))  # Remover linhas com valores NA na coluna startYear

# Verificar se há problemas de conversão
if (any(is.na(filmes$runtimeMinutes))) {
  # Imprimir linhas com problemas
  print(filmes[is.na(filmes$runtimeMinutes), ])
}

# Análise de dados

# Visualização da distribuição do ano de lançamento
hist(filmes$startYear, main = "Distribuição do Ano de Lançamento", xlab = "Ano de Lançamento")

# Verificar se há problemas de parsing
problems <- problems(read_tsv("title.basics.tsv.gz"))

# Visualização da distribuição da duração dos filmes
if (all(is.na(filmes$runtimeMinutes)) | all(!is.na(as.numeric(filmes$runtimeMinutes)))) {
  hist(as.numeric(filmes$runtimeMinutes), main = "Distribuição da Duração dos Filmes", xlab = "Duração (minutos)")
} else {
  print("Existem valores não numéricos em runtimeMinutes após a limpeza dos dados.")
}

# Salvar as visualizações em um diretório de plots
png("plots/distribuicao_ano_lancamento.png")
hist(filmes$startYear, main = "Distribuição do Ano de Lançamento", xlab = "Ano de Lançamento")
dev.off()

png("plots/distribuicao_duracao_filmes.png")
if (all(is.na(filmes$runtimeMinutes)) | all(!is.na(as.numeric(filmes$runtimeMinutes)))) {
  hist(as.numeric(filmes$runtimeMinutes), main = "Distribuição da Duração dos Filmes", xlab = "Duração (minutos)")
} else {
  print("Existem valores não numéricos em runtimeMinutes após a limpeza dos dados.")
}
dev.off()

# Salvar os dados limpos em um arquivo CSV
write.csv(filmes, "filmes_limpos.csv", row.names = FALSE)