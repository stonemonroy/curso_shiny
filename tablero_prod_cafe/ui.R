dashboardPage(
  skin = "green",
  
  dashboardHeader(
    title = "Café"
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem(" Producción", tabName = "produccion", icon = icon("mug-saucer"))
    )
  ),
  
  dashboardBody(
    
    # Importamos css con propiedades para algunos elementos
    tags$head(includeCSS('www/style.css')),
    
    tabItems(
      
      # Tab 
      tabItem(
        
        tabName = "produccion",
        
        #### Filtros ----------------------------------------
        
        div(
          class = "filtros",
          fluidRow(
            column(
              width = 10,
              box(
                width = 12,
                style = "margin-top: 2%",
                background = "green",
                align = "center",
                column(
                  width = 6,
                  sliderInput(
                    inputId = "select_anio",
                    label = "Seleccione un año",
                    min = as.numeric(max(datos %>% distinct(ano) %>% pull()))-10,
                    max = as.numeric(max(datos %>% distinct(ano) %>% pull())),
                    value = as.numeric(max(datos %>% distinct(ano) %>% pull())),
                    sep = "",
                    ticks = 100
                  )
                ),
                column(
                  width = 6,
                  pickerInput(
                    inputId = "select_depto",
                    options = list(`actions-box` = TRUE,
                                   `deselect-all-text` = "Deseleccionar todo",
                                   `select-all-text` = "Seleccionar todo",
                                   `none-selected-text` = "Nada seleccionado",
                                   size = 7),
                    multiple = T,
                    label = "Seleccione los departamentos a mostrar",
                    choices = (datos %>% distinct(departamento) %>% pull()),
                    selected = "RISARALDA"
                  )
                )
              )
            )
          )
        ), # Cierra div filtros
        
        br(),
        br(),
        
        div(
          class = "contenido",
          
          ##### Encabezado ------------------------
          
          fluidRow(
            align = "center",
            div(style="display: inline-block; margin-right: 30px;", img(src="https://yt3.googleusercontent.com/ytc/APkrFKbWwqXAmcNzty35LqQnSyJB6zfHIJ5O0ldSX5by1A=s176-c-k-c0x00ffffff-no-rj", height=104, width=104)),
            div(style="display: inline-block; vertical-align: middle;", h1("Producción anual de café", span("por departamentos", style = "font-weight: 300"),
                                                                           style = "font-family: 'Source Sans Pro';
                                                                                    color: #fff; text-align: center;
                                                                                    background-image: url('https://img.freepik.com/vector-premium/fondo-vector-patrones-fisuras-granos-cafe-textura-marron-oscura-repetida-menu-cafe_554888-2322.jpg');
                                                                                    padding: 20px")
            )
          ),
          
          br(),
          br(),
          
          fluidRow(
            column(
              width = 12,
              box(
                width = 12,
                background = "green",
                align = "center",
                #### Texto --------------
                column(
                  width = 6,
                  fluidRow(align="center",
                           column(width = 10,offset = 1, align = "center",
                                  textOutput("texto_produccion")
                           )
                  )
                ),
                #### ValueBoxes ------------------------------------------------------------- 
                column(
                  width = 6,
                  uiOutput("valuebox_produccion")
                )
              )
            )
          ),
          
        ) # Cierra div contenido
        
      )# Cierra tabItem Producción
      
    ) # Cierra tabItems
  ) # Cierra dashboardBody
) # Cierra dashboard page