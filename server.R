server <- function(input, output, session) {
  
  output$plot_dona <- renderPlot({
    datos %>% 
      count(sexo_biologico) %>% 
      mutate(porcentaje = n/sum(n), ymax = cumsum(porcentaje),
             ymin = c(0,head(ymax, n = -1)), labelpos = (ymax + ymin)/2,
             labelname = paste(sexo_biologico,"\n",n,"\n",percent(porcentaje, 0.1))) %>% 
      ggplot(aes(ymax = ymax, ymin = ymin, xmax=10, xmin=1, fill = sexo_biologico ))+
      geom_rect()+
      geom_text(aes(x = -3.2,y = labelpos, label = labelname),size = 4, color = "black", fontface = "bold")+
      scale_fill_manual(values = c("#4292c6",
                                   "#41b6c4","#7fcdbb","#238b45",
                                   "#78c679","#c7e9b4","#edf8b1","#fee391","#fec44f",
                                   "#fe9929","#ec7014")) +
      coord_polar(theta = "y")+
      xlim(c(20,-10))+
      theme_void()+
      theme(legend.position = "none",
            panel.background = element_blank())
  })
  
  
  output$plot_barras <- renderPlot({
    datos %>% 
      count(categoria_edad) %>% 
      mutate(Porcentaje = percent(n/sum(n), accuracy = .1)) %>% 
      ggplot(aes(x = categoria_edad, y = n, fill = categoria_edad, label = paste(Porcentaje,"\n",n," ")))+
      geom_col()+
      geom_text(vjust = 0.5, size = 3.5, color = "black", fontface = "bold")+
      labs(x = "Vicerrectoría o Facultad", y = "Cantidad de empleados")+ 
      #title = "Porcentaje de administrativos de acuerdo con el nivel")+
      theme(legend.position="none")+
      theme(axis.text.y = element_text(size = 10, color = "black", face = "bold"))+
      theme(axis.text.x = element_text(size = 10))+
      scale_fill_manual(values = c("#2171b5",
                                   "#4292c6","#74a9cf",
                                   "#41b6c4","#7fcdbb","#238b45",#"#41ab5d",
                                   "#78c679","#c7e9b4","#edf8b1","#fee391","#fec44f",
                                   "#fe9929","#ec7014"))
  })
  
  
  output$table <- renderUI({
    
    htmltools_value(
      datos %>% 
        group_by(sexo_biologico) %>% 
        summarise(Edad = mean(edad_anos_cumplidos),
                  `Estatura (cm)` = mean(estatura_cm),
                  `Peso (kg)` = mean(peso_o_masa_corporal_kg)) %>% 
        pivot_longer(cols = c(2:4), names_to = "Promedio características") %>% 
        pivot_wider(names_from = sexo_biologico, values_from = value) %>% 
        mutate(across(where(is.numeric), \(x) round(x, 1))) %>% 
        ftable()
    )
    
  })
  
  
  output$animado <- renderImage({
    df <- cafe %>%
      filter(departamento %in% c("CALDAS", "QUINDIO", "RISARALDA")) %>%
      mutate(ano = as.numeric(ano)) %>% 
      ggplot(aes(x = ano, y = produccion_ton, color = departamento))+
      geom_line(aes(group = departamento), linewidth = 1.5)+
      geom_point(size = 4)+
      labs(x = "Año", y = "Producción (ton)",
           title = "Producción de café en el {as.integer(frame_along)} (ton)",
           col = "Departamento")+
      #title = "Porcentaje de administrativos de acuerdo con el nivel")+
      theme(legend.position="bottom")+
      theme(axis.text.y = element_text(size = 10))+
      theme(axis.text.x = element_text(size = 10))+
      scale_color_manual(values = c("#3288bd","#41b6c4","#238b45",
                                    "#7fcdbb","#238b45",#"#41ab5d",
                                    "#78c679","#c7e9b4","#edf8b1","#fee391","#fec44f",
                                    "#fe9929","#ec7014"))+
      transition_reveal(ano)
    
    
    anim_save("outfile.gif", animate(df, width = 700, height = 400, nframes = 45))
    
    # Return a list containing the filename
    list(src = "outfile.gif", contentType = "image/gif")
  }, deleteFile = TRUE)
  
  
}
