# WAT-a-Game GUI

[WAT a Game](https://sites.google.com/site/waghistory/) est un jeu serieux developpé par l'IRSTEA et le CIRAD. 

Nous proposon ici, une interface graphique d'analyse des résultats pour le **debriefing**. Cette interface graphique est disponible sur [shinyapp.io](https://elcep.shinyapps.io/WAT-a-Game-GUI). Mais vous trouverez également ici les sources (dans ce dépôt Github). Elle est codée en [R](https://www.r-project.org/), grâce au package [shiny](http://shiny.rstudio.com/), ce qui vous permet également de la lancer en `localhost`

```
library(shiny)
setwd(mon_dossier)
shiny::runApp('WAT-a-game')

```
## Pense pas bête

Les informations pour confiture RStudio dans le but de se connecter à shinyapp.io sont disponibles ici : [http://shiny.rstudio.com/articles/shinyapps.html](http://shiny.rstudio.com/articles/shinyapps.html).
