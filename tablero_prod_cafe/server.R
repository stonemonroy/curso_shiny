server <- function(input, output, session) {
  
  output$texto_produccion <- renderText({
    "En esta pestaña se puede observar el total de toneladas de café producido por cada departamento en el año seleccionado. Así como el porcentaje de participación que tienen estos departamentos dentro de la producción total de café del país."
  })
  
  output$valuebox_produccion <- renderUI({
    
    splitLayout(
      valueBox(
        width = 12,
        value = (datos %>% 
                   filter(ano == input$select_anio,
                          departamento %in% input$select_depto) %>% 
                   summarise(sum(produccion_ton)) %>% 
                   pull()),
        subtitle = "Toneladas producidas",
        color = "yellow",
        icon = icon("industry")
      ),
      valueBox(
        width = 12,
        value = (datos %>% 
                   filter(ano == input$select_anio,
                          departamento %in% input$select_depto) %>% 
                   summarise(paste0(sum(produccion_nacional_ton), "%")) %>%
                   pull()),
        subtitle = "Impacto en producción nacional",
        color = "blue",
        icon = icon("globe")
      )
    )
    
  })
  
}


