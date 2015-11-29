library(shiny)
require(reshape2)
require(ineq)


##partie shiny
shinyServer(function(input, output) {
  
  ## lecture des donnees
  Dataset <- reactive({
    if (is.null(input$file)) {
      # l'utilisateur na pas encore charger les donnees
      return(data.frame())
    }
    
     Dataset<-as.data.frame(read.csv(input$file$datapath, header=input$entete, sep=input$sep, 
             quote=input$quote) )
    return(Dataset)
  })
  output$tableau <- renderTable({return(Dataset()) })
  
  tableauJoueurs<-reactive({
    if(input$calcul){
      return(Dataset()[,1:(input$nb_joueurs + 2)])
    }
    else
    {return(NULL)}
    })
  output$tableauJ <- renderTable({return(tableauJoueurs()) })
  
  tableau_Gini<-reactive({
    if(input$calcul){
      mini_df <- Dataset()[,1:(input$nb_joueurs + 2)]
      st1 <- as.data.frame(t(mini_df[,c(-1,-length(mini_df))]))
      gini.i <- as.data.frame(apply(st1, 2, ineq))
      gini.i <- cbind(c(1:length(gini.i[,1])),gini.i)
      colnames(gini.i) <- c("Tour","Gini Index")
      return(gini.i)
    }
    else
    {return(NULL)}
  })
  
  output$tableauGini<-renderTable({tableau_Gini()})
  
  tableauWat<-reactive({
    if(input$calcul){
      mini_df <- Dataset()[,(input$nb_joueurs + 2):length(Dataset())]
      return(mini_df)
    }
    else
    {return(NULL)}
  })
  
  output$tableauWater<-renderTable({tableauWat()})
  
#graph
  output$plot_joueur <- renderPlot({
    if(input$calcul){
      print(tableauJoueurs())
      s1.m <- melt(tableauJoueurs(), c("X","Saison" ))
      gg1 <- ggplot(data = s1.m)+
        geom_boxplot(aes(x = as.factor(X), y = value, fill = Saison))+
        labs(x = "", y = "revenu par tour", title = date.v)
      return(gg1)
      
    }else{
      return(NULL)
    }
  })
  
  output$plot_gini <- renderPlot({
    if(input$calcul){
      plot(tableau_Gini()[,1],tableau_Gini()[,2], 
           ylim=c(0, 0.5),
           xlab = "Tours",
           ylab = "Gini Index",
           type = "o",
           main = input$text)
    }else{
      return(NULL)
    }
  })

})
