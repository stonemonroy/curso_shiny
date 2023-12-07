library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(tidyverse)
library(openxlsx)
library(janitor)
library(scales)
library(flextable)


# Función para crear flextable
## Solo es necesario pasar los datos como parámetro
ftable <- function(x) {
  x %>% 
    flextable() %>% 
    theme_vanilla() %>%
    color(part = "header", color = "#FFFFFF") %>%
    color(part = "body", j = 1, color = "#FFFFFF") %>% 
    bg(part = "header", bg = "#3592cf") %>%
    bg(part = "body", j = 1, bg = "#3592cf") %>%
    # bold(i = nrow(x), part = "body") %>% 
    fontsize(size = 11) %>%
    font(fontname = 'Calibri') %>%
    # Ajustes de ancho y tipo de alineación de las columnas
    set_table_properties(layout = "autofit") %>% 
    # width(j=1, width = 3) %>%
    align(i = NULL, j = c(2:ncol(x)), align = "right", part = "all") %>% 
    align(part = "footer", align = "center") %>% 
    fontsize(part = "footer", size = 9) %>% 
    italic(part = "footer")
}


# Lectura de datos
datos <- read.xlsx("https://docs.google.com/spreadsheets/d/e/2PACX-1vQn8PBIcLN5Q197vF5U93O57orOOMNEwvo462qX9FfR4zW-SK8IHdYNK_w4ARNa3VkagbIn7ElUhFoR/pub?output=xlsx") %>% 
  clean_names() %>% 
  select(-10)

# Renombre de variables
datos <- datos %>% 
  rename(talla_zapatos = talla_de_zapatos_en_medidas_colombia_ejemplo_talla_37_40_entre_otras_solo_escribir_la_talla_con_la_que_usted_compra_zapatos,
         pulsaciones_toma1 = pulsaciones_durante_20_segundos_y_en_reposo_toma_1,
         pulsaciones_toma2 = pulsaciones_durante_20_segundos_y_en_reposo_toma_2,
         desayuno = que_desayuno_esta_manana_puede_seleccionar_varias_opciones)

# Creación categorías de edad
datos <- datos %>% 
  mutate(categoria_edad = case_when(edad_anos_cumplidos < 20 ~ "Menor de 20 años",
                                    edad_anos_cumplidos < 30 ~ "Veinteañero",
                                    edad_anos_cumplidos < 40 ~ "Treintañero",
                                    TRUE ~ "40 o más años"),
         categoria_edad = factor(categoria_edad, levels = c("Menor de 20 años",
                                                            "Veinteañero",
                                                            "Treintañero",
                                                            "40 o más años")))

