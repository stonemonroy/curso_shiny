dashboardPage(
  dashboardHeader(
    title = "Dashboard"
  ), # Cierra dashboardHeader
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Menú 1", tabName = "menu1", icon = icon("university")),
      menuItem("Menú 2", tabName = "menu2", icon = icon("book")),
      menuItem("Menú 3", tabName = "menu3", icon = icon("users"))
    ) # Cierra sidebarMenu
  ), # Cierra dashboardSidebar
  dashboardBody(
    
    # Importamos css con propiedades para algunos elementos
    tags$head(includeCSS('www/style.css')),
    
    tabItems(
      
      tabItem(
        tabName = "menu1",
        
        #### Filtros ----------------------------------------
        
        div(
          class = "filtros",
          fluidRow(
            column(
              width = 10,
              box(
                width = 12,
                style = "margin-top: 2%",
                background = "orange",
                align = "center",
                column(
                  width = 6,
                  sliderInput(
                    inputId = "select_anio",
                    label = "Seleccione un año",
                    min = 2019,
                    max = 2023,
                    value = 2023,
                    sep = ""
                  )
                ),
                column(
                  width = 6,
                  pickerInput(
                    inputId = "select_periodo",
                    options = list(`actions-box` = TRUE,
                                   `deselect-all-text` = "Deseleccionar todo",
                                   `select-all-text` = "Seleccionar todo",
                                   `none-selected-text` = "Nada seleccionado",
                                   size = 7),
                    multiple = T,
                    label = "Seleccione un periodo",
                    choices = c(1, 2),
                    selected = 1
                  )
                )
              )
            )
          )
        ), # Cierra div filtros
        
        br(),
        br(),
        
        #### Contenido ----------------------
        
        div(
          class = "contenido",
          
          ##### Encabezado ------------------------
          
          fluidRow(
            align = "center",
            div(style="display: inline-block; margin-right: 30px;", img(src="https://yt3.googleusercontent.com/ytc/APkrFKbWwqXAmcNzty35LqQnSyJB6zfHIJ5O0ldSX5by1A=s176-c-k-c0x00ffffff-no-rj", height=104, width=104)),
            div(style="display: inline-block; vertical-align: middle;", h1("Pestaña", span("1", style = "font-weight: 300"),
                                                                           style = "font-family: 'Source Sans Pro';
                                                                                    color: #fff; text-align: center;
                                                                                    background-image: url('https://th.bing.com/th/id/R.b57082aa4dc524591c97aca2e1122436?rik=2MfUP96X0CXMzw&pid=ImgRaw&r=0.jpeg');
                                                                                    padding: 20px")
            )
          ),
          
          br(),
          br(),
          
          fluidRow(
            column(
              width = 6,
              plotOutput("plot_dona")
            ),
            
            column(
              width = 6,
              plotOutput("plot_barras")
            ) 
          ),
          
          br(),
          br(),
          
          fluidRow(
            column(
              width = 8,
              offset = 2,
              uiOutput("table")
            )
          ),
          
          br(),
          br(),
          
          fluidRow(
            column(
              width = 8,
              offset = 2,
              imageOutput("animado")
            )
          )
          
        ) # Cierra div contenido
        
      ), # Cierra tabItem menu1
      
      tabItem(
        tabName = "menu2",
        
        fluidRow(
          align = "center",
          div(style="display: inline-block; margin-right: 30px; margin-top: 4%;", img(src="https://yt3.googleusercontent.com/ytc/APkrFKbWwqXAmcNzty35LqQnSyJB6zfHIJ5O0ldSX5by1A=s176-c-k-c0x00ffffff-no-rj", height=104, width=104)),
          div(style="display: inline-block; vertical-align: middle;", h1("Pestaña", span("2", style = "font-weight: 300"),
                                                                         style = "font-family: 'Source Sans Pro';
                                                                                    color: #fff; text-align: center;
                                                                                    background-image: url('https://th.bing.com/th/id/R.b57082aa4dc524591c97aca2e1122436?rik=2MfUP96X0CXMzw&pid=ImgRaw&r=0.jpeg');
                                                                                    padding: 20px")
          )
        )
        
        # Contenido del tab 2
        
      ), # Cierra tabItem menu2
      
      tabItem(
        tabName = "menu3",
        
        fluidRow(
          align = "center",
          div(style="display: inline-block; margin-right: 30px; margin-top: 4%;", img(src="https://yt3.googleusercontent.com/ytc/APkrFKbWwqXAmcNzty35LqQnSyJB6zfHIJ5O0ldSX5by1A=s176-c-k-c0x00ffffff-no-rj", height=104, width=104)),
          div(style="display: inline-block; vertical-align: middle;", h1("Pestaña", span("3", style = "font-weight: 300"),
                                                                         style = "font-family: 'Source Sans Pro';
                                                                                    color: #fff; text-align: center;
                                                                                    background-image: url('https://th.bing.com/th/id/R.b57082aa4dc524591c97aca2e1122436?rik=2MfUP96X0CXMzw&pid=ImgRaw&r=0.jpeg');
                                                                                    padding: 20px")
          )
        )
        
        # Contenido del tab 3
        
      ) # Cierra tabItem menu3
      
    ) # Cierra tabItems
  ) # Cierra dashboardBody
) # Cierra dashboardPage