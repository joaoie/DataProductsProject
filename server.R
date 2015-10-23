library(UsingR)

data(mtcars)
##x = x + 1
y = 0
regcoef <- NULL

shinyServer(
  function(input, output) {
     x <- reactive({
      if(input$cylcat=="any") dat<-mtcars
      else dat<-mtcars[which(mtcars$cyl==input$cylcat),]
      if(input$gears=="all") dat<-dat
      else dat<-dat[which(dat$gear==input$gears),]
      if(input$engine=="all") dat<-dat
      else {
        if(input$engine=="V") dat<-dat[which(dat$vs==0),]
        else dat<-dat[which(dat$vs==1),]
      }
      if(input$trans=="all") dat<-dat
      else {
        if(input$trans=="Auto") dat<-dat[which(dat$am==0),]
        else dat<-dat[which(dat$am==1),]
      }
    })
     
    output$title = renderText({
      y <- dim(x())[1]
      if(input$Variable=="hp")
        paste("You have selected HORSE POWER as the horizontal variable, with", y, "ocurrences")
      else
        paste("You have selected WEIGHT horizontal variable, with", y, "ocurrences")
    })
                                     
    output$newHist <- renderPlot({
      if(input$Variable=="hp")
        qplot(x()$hp, x()$mpg, data=x(), xlab='horse power', ylab = 'mileage (mpg)', color=am)
      else
        qplot(x()$wt, x()$mpg, data=x(), xlab='weight (lb/1000)', ylab = 'mileage (mpg)', color=am) 
       })
    output$coefam <- renderText({
      if(input$Variable=="hp")
        lm(mpg~hp,data=x()[which(x()$am==0),])$coef[2]
      else
        lm(mpg~wt,data=x()[which(x()$am==0),])$coef[2]
      })
    output$coefma <- renderText({
      if(input$Variable=="hp")
        lm(mpg~hp,data=x()[which(x()$am==1),])$coef[2]
      else
        lm(mpg~wt,data=x()[which(x()$am==1),])$coef[2]
      })
    output$difference <- renderText({
      if(input$Variable=="hp")
        lm(mpg~hp,data=x()[which(x()$am==0),])$coef[2]-lm(mpg~hp,data=x()[which(x()$am==1),])$coef[2]
      else
        lm(mpg~wt,data=x()[which(x()$am==0),])$coef[2]-lm(mpg~wt,data=x()[which(x()$am==1),])$coef[2]
      })

    
    
  }
)