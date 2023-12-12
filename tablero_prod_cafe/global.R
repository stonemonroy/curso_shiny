library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(openxlsx)
library(janitor)
library(tidyverse)
library(scales)

datos <- read.xlsx("datos_cafe.xlsx") %>% 
  clean_names()

