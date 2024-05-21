library(dplyr)
library(readr)
library(ggplot2)

# Carregar dados do IMDb

titles <- read_tsv("title.basics.tsv.gz", na = "\\N")  # Definir "\\N" como NA
ratings <- read_tsv("title.ratings.tsv.gz", na = "\\N")  # Definir "\\N" como NA

# Combinar os dois conjuntos de dados usando 'tconst'
data <- titles %>%
  inner_join(ratings, by = "tconst")
             
             

# Limpeza de dados

# 1. Filtrar apenas filmes
filmes <- data %>%
  filter(titleType == "movie")

# 2. Remover entradas sem dados
filmes <- filmes %>%
  filter(!is.na(startYear) & !is.na(runtimeMinutes) & runtimeMinutes >= 0 & runtimeMinutes <= 300)

# 3. Separar gêneros em linhas individuais
filmes <- data %>%
  filter(titleType == "movie") %>%
  separate_rows(genres, sep = ",") %>%
  filter(!is.na(genres))

# 3. Contar o número de filmes por gênero
contagem_genero <- filmes %>%
  count(genres, sort = TRUE)

# 5. Filtrar filmes com dados de duração e avaliação
filmes <- data %>%
  filter(titleType == "movie" & !is.na(runtimeMinutes) & !is.na(averageRating) & runtimeMinutes <= 300)




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



# Gráfico pizza de classificação (notas)
grafico_pizza_classificacao <- data %>%
  filter(titleType == "movie" & !is.na(startYear) & !is.na(averageRating)) %>%
  mutate(averageRating = round(averageRating)) %>%
  count(averageRating, sort = TRUE) %>%
  ggplot(aes(x = "", y = n, fill = as.factor(averageRating))) +
  geom_bar(stat = "identity") +
  coord_polar("y", start = 0) +
  labs(title = "Distribuição das Classificações dos Filmes",
       fill = "Classificação (Notas)",
       x = NULL,
       y = NULL) +
  theme_void() +
  scale_fill_manual(values = c(
    "1" = "#1f77b4",
    "2" = "#ff7f0e",
    "3" = "#2ca02c",
    "4" = "#d62728",
    "5" = "#9467bd",
    "6" = "#8c564b",
    "7" = "#e377c2",
    "8" = "#7f7f7f",
    "9" = "#bcbd22",
    "10" = "#17becf"
  ))

ggsave("plots/grafico_pizza_classificacao.png", plot = grafico_pizza_classificacao, width = 8, height = 6)



# Grafico de barras por gênero
grafico_barras_genero <- ggplot(contagem_genero, aes(x = reorder(genres, -n), y = n)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Distribuição dos Filmes por Gênero",
       x = "Gênero",
       y = "Número de Filmes") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("plots/grafico_barras_genero.png", plot = grafico_barras_genero, width = 10, height = 6, units = "in")



# Gráfico de dispersão
grafico_dispersao_duracao_avaliacao <- ggplot(filmes, aes(x = runtimeMinutes, y = averageRating)) +
  geom_point(color = "#0072B2", alpha = 0.6) + # Altera a cor dos pontos e adiciona transparência
  geom_smooth(method = "lm", color = "#D55E00") + # Adiciona uma linha de tendência
  labs(title = "Relação entre Duração e Avaliação dos Filmes",
       x = "Duração (minutos)",
       y = "Avaliação Média") +
  theme_minimal() +
  theme(panel.grid.major = element_line(color = "gray", linetype = "dotted"), # Adiciona grade ao gráfico
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black")) # Adiciona linhas do eixo

ggsave("plots/grafico_dispersao_duracao_avaliacao.png", plot = grafico_dispersao_duracao_avaliacao, width = 10, height = 6, units = "in", dpi = 300)


# Salvar os dados limpos em um arquivo CSV
write.csv(filmes, "filmes_limpos.csv", row.names = FALSE)
