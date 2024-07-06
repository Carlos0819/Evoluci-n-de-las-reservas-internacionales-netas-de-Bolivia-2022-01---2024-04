# Cargar librerías necesarias
library(tidyverse)
library(readxl)

# Leer el archivo Excel
file_path <- "ruta/a/deuda.xlsx" # Actualiza con la ruta correcta al archivo
df <- read_excel(file_path, sheet = "Hoja1")

# Transformar el dataframe al formato tidy
df_tidy <- df %>%
  pivot_longer(cols = c("Oro", "Divisas", "DEG", "Tramo FMI", "Obligaciones", "Total RIN"),
               names_to = "Categoria",
               values_to = "Valor") %>%
  mutate(month = as.Date(month)) # Asegurarse de que la columna month sea de tipo fecha

# Visualizar líneas por mes y categorías
ggplot(df_tidy, aes(x = month, y = Valor, color = Categoria)) +
  geom_line() +
  labs(title = "Valores por Categoría a lo Largo del Tiempo",
       x = "Mes",
       y = "Valor",
       color = "Categoría") +
  theme_minimal()

# Guardar la visualización en un archivo
ggsave("visualizacion_deuda.png", width = 10, height = 6)