# Carregar pacotes necessários
library(dplyr)

# Carregar dados do IMDb
data <- readr::read_tsv("title.basics.tsv.gz")

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
  mutate(startYear = as.numeric(startYear),
         runtimeMinutes = as.numeric(runtimeMinutes))

# Verificar se há problemas de conversão
if (any(is.na(filmes$startYear))) {
  # Imprimir linhas com problemas
  print(filmes[is.na(filmes$startYear), ])
}
if (any(is.na(filmes$runtimeMinutes))) {
  # Imprimir linhas com problemas
  print(filmes[is.na(filmes$runtimeMinutes), ])
}

# Análise de dados


# Visualização da distribuição do ano de lançamento
hist(filmes$startYear, main = "Distribuição do Ano de Lançamento", xlab = "Ano de Lançamento")

# Visualização da distribuição da duração dos filmes
hist(filmes$runtimeMinutes, main = "Distribuição da Duração dos Filmes", xlab = "Duração (minutos)")

# Salvar as visualizações em um diretório de plots
png("plots/distribuicao_ano_lancamento.png")
hist(filmes$startYear, main = "Distribuição do Ano de Lançamento", xlab = "Ano de Lançamento")
dev.off()

png("plots/distribuicao_duracao_filmes.png")
hist(filmes$runtimeMinutes, main = "Distribuição da Duração dos Filmes", xlab = "Duração (minutos)")
dev.off()

# Salvar os dados limpos em um arquivo CSV
write.csv(filmes, "filmes_limpos.csv", row.names = FALSE)