
library(dplyr)
library(readr)
library(ggplot2)

# Carregar dados do IMDb
data <- read_tsv("title.basics.tsv.gz", na = "\\N")  # Definir "\\N" como NA

# Limpeza de dados

# 1. Filtrar apenas filmes
filmes <- data %>%
  filter(titleType == "movie")

# 2. Remover entradas com dados ausentes
filmes <- filmes %>%
  filter(!is.na(startYear) & !is.na(runtimeMinutes) & runtimeMinutes >= 0 & runtimeMinutes <= 300)


# Gerar e salvar os gráficos

# Visualização da distribuição do ano de lançamento

png("plots/distribuicao_ano_lancamento.png")
hist(filmes$startYear, main = "Distribuição do Ano de Lançamento", xlab = "Ano de Lançamento")
dev.off()

# Visualização da distribuição da duração dos filmes

grafico <- ggplot(filmes, aes(x = runtimeMinutes)) +
  geom_histogram(binwidth = 30, fill = "blue", color = "black") +
  scale_x_continuous(breaks = seq(0, 300, by = 30)) +
  labs(title = "Distribuição da Duração dos Filmes\n(em minutos)",
       x = "Duração (minutos)",
       y = "Número de Filmes") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))  # Centralizar o título do gráfico

png("plots/distribuicao_duracao_filmes.png", width = 800, height = 600)
print(grafico)
dev.off()


# Salvar os dados limpos em um arquivo CSV
write.csv(filmes, "filmes_limpos.csv", row.names = FALSE)