shinyServer(function(input, output) {
        # sum for go buttons:
        output$sum <- reactive(sum(input$st, input$ag, input$int))
        
        #Trial fight
                #more elegant solutions like using switch or wrapping just input$trial use into ifelse statements weren't working
                #and I don't know why :-(
        output$table <- renderTable({
                #strength
                if (input$trial==1) {
                        n1 <- (sample(1:6, 1, replace = T))
                        n2<- (sum((sample(1:6, input$st, replace = T))))
                        n3 <- as.character(n1 < n2)
                        df<-data.frame(n1, n2, n3)
                        colnames(df) <- c("Your opponent", "You", "Do you win?")
                        df}
                else
                #agility
                        if (input$trial==2) {
                                n1 <- (sample(1:6, 1, replace = T))
                                n2<- (sum((sample(1:6, input$ag, replace = T))))
                                n3 <- as.character(n1 < n2)
                                df<-data.frame(n1, n2, n3)
                                colnames(df) <- c("Your opponent", "You", "Do you win?")
                                df}
                else {
                #intelligence
                        n1 <- (sample(1:6, 1, replace = T))
                        n2<- (sum((sample(1:6, input$int, replace = T))))
                        n3 <- as.character(n1 < n2)
                        df<-data.frame(n1, n2, n3)
                        colnames(df) <- c("Your opponent", "You", "Do you win?")
                        df}        
        })
        
        #Gatekeeper fight
        output$boss <- renderTable({
                #strength
                if (input$gatekeeper==1) {
                        n4 <- sum(sample(1:6, 2, replace = T))
                        n5<- (sum((sample(1:6, input$st, replace = T))))
                        n6 <- as.character(n4 < n5)
                        df<-data.frame(n4, n5, n6)
                        colnames(df) <- c("Gatekeeper", "You", "Do you win?")
                        df
                }
                else
                #agility
                        if (input$gatekeeper==2) {
                                n4 <- sum(sample(1:6, 2, replace = T))
                                n5<- (sum((sample(1:6, input$ag, replace = T))))
                                n6 <- as.character(n4 < n5)
                                df<-data.frame(n4, n5, n6)
                                colnames(df) <- c("Gatekeeper", "You", "Do you win?")
                                df
                        }
                else {
                #intelligence
                        n4 <- sum(sample(1:6, 2, replace = T))
                        n5<- (sum((sample(1:6, input$int, replace = T))))
                        n6 <- as.character(n4 < n5)
                        df<-data.frame(n4, n5, n6)
                        colnames(df) <- c("Gatekeeper", "You", "Do you win?")
                        df
                }
        })
        
        
        #fern
        #credits go to https://maggielinyu.wordpress.com/2012/02/25/barnsleys-fern-in-r/
        output$fern <- renderPlot({
                A=vector("list",4)
                A[[1]]=matrix(c(0,0,0,0.16),nrow=2)
                A[[2]]=matrix(c(0.85,-0.04,0.04,0.85),nrow=2)
                A[[3]]=matrix(c(0.2,0.23,-0.26,0.22),nrow=2)
                A[[4]]=matrix(c(-0.15,0.26,0.28,0.24),nrow=2)
                b=vector("list",4)
                b[[1]]=matrix(c(0,0))
                b[[2]]=matrix(c(0,1.6))
                b[[3]]=matrix(c(0,1.6))
                b[[4]]=matrix(c(0,0.44))
                n <- 50000
                x <- numeric(n)
                y <- numeric(n)
                x[1] <- y[1] <- 0
                for (i in 1:(n-1)) {
                        trans <- sample(1:4, prob=c(.01, .85, .07, .07), size=1)
                        xy <- A[[trans]]%*%c(x[i],y[i]) + b[[trans]]
                        x[i+1] <- xy[1]
                        y[i+1] <- xy[2]
                }
                plot(y,x,col="dark green",cex=0.1)
        })
        
      
})
