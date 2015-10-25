shinyUI(pageWithSidebar(
  headerPanel(" "),
  sidebarPanel(

    selectInput('cylcat', 'Cylinders', choices = c("any","4 cylinder engines"=4,"6 cylinder engines"=6,"8 cylinder engines"=8)),
    
    selectInput('gears', 'Number of gears', choices = c("all","3 (no Manual)" = 3,4,"5 (no Automatic)" =5)),
    selectInput('engine', 'Engine layout', choices = c("all","V shaped engine"="V","in-line")),
    selectInput('trans', 'Transmission', choices = c("all","Automatic Transmission"="Auto","Manual Transmission"="Manual")),
    selectInput('Variable', 'Dependant Variable', choices = c("Horse Power"="hp","Weight"="wt")),
    
    h4("Regression coefficients", align ="center"),
    p('(increase in MPG per increase in selected dependant variable)'),
    p('Auto'),
    textOutput('coefam'),
    br(),
    p('Manual'),
    textOutput('coefma'),
    br(),
    h4('Estimated gain in MPG of Manual over Automatic', align ="center"),
    textOutput('difference')
    ),
  mainPanel(
    p('The shiny application developed is a Calculator for the estimated increase in Miles per galon of a vehicule with Manual transmission instead of Automatic, as a function of HORSE POWER, or WEIGHT.'),
    br(),     
    p('The application uses data from the "mtcars" dataset, and the computation (by mean of linear regression on the data) can be made for all cars, or filtering the data by engine type, number of cylinders, and/or number of gears. Since the dataset is small (all 3 gear vehicules are automatic, and all 5 gears are manual) the computation is only possible with the options "4 gears" and "all"'),
    
    h2("Chart of MPG ", align ="center"),
    textOutput('title'),
    plotOutput('newHist'),
    p('The above chart displays the cars of the "mtcars" dataset according to their mileage.'),
    p('When the points apear in different colors, the light blue dots reflect vehicules with manual transmission')
  
    
  )
))