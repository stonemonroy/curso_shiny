server <- function(input, output, session) {
  
  output$plot_dona <- renderPlot({
    datos %>% 
      count(sexo_biologico) %>% 
      mutate(porcentaje = n/sum(n), ymax = cumsum(porcentaje),
             ymin = c(0,head(ymax, n = -1)), labelpos = (ymax + ymin)/2,
             labelname = paste(sexo_biologico,"\n",n,"\n",paste(round(porcentaje*100,digits = 1),"%"))) %>% 
      ggplot(aes(ymax = ymax, ymin = ymin, xmax=10 , xmin=1,fill = sexo_biologico ))+
      geom_rect()+
      # Si queremos imprimir las etiquetas SIN recuadro, dejamos la línea siguiente
      geom_text(aes(x = -3.2,y = labelpos, label = labelname),size = 4, color = "black", fontface = "bold")+
      # Si queremos imprimir las etiquetas CON recuadro, dejamos la línea siguiente
      #geom_label(x = 1,aes(y = labelpos, label = labelname),size = 4)+
      # Para usar otra paleta de colores.
      #scale_fill_brewer(palette = 4)+
      scale_fill_manual(values = c("#4292c6",
                                   "#41b6c4","#7fcdbb","#238b45",#"#41ab5d",
                                   "#78c679","#c7e9b4","#edf8b1","#fee391","#fec44f",
                                   "#fe9929","#ec7014")) +
      #scale_color_brewer(palette = 4)+
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
  
  
  
}
