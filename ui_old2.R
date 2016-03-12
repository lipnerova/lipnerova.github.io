shinyUI(fluidPage(#theme = "bootstrap.css", #https://www.codecademy.com/learn/web naucit se css
        titlePanel("Chrám zkoušek"),
        sidebarLayout(
                sidebarPanel(width=2, 
                        helpText("You can assign 3 points. It is up to you how you spend them.
                                 1 point gives you weak characteristic,
                                 2 points give you normal characteristic and 3 points give you strong."),
                        
                        
                        helpText("Points spent (have to be 3 to be able to proceed):"),
                        
                        verbatimTextOutput("sum"),
                        
                        numericInput("st", "Strength", min=0, max=3, step=1, value=0),
                        
                        numericInput("ag", "Agility", min=0, max=3, step=1, value=0),
                        
                        numericInput("int", "Inteligence", min=0, max=3, step=1, value=0),
                        
                        conditionalPanel("output.sum == 3", actionButton("goButton", "Go!")),
                        
                        conditionalPanel("input.winLose == 1",  
                                         div("Assign one more point to proceed.", style="color:red"),
                                         conditionalPanel("output.sum == 4", 
                                                          actionButton("goButton2", "Go for final trial!"))
                        ) #end of wrapping conditionalPanel
                        
                        ) #end of sidebarPanel
                ,
                
                mainPanel(
                        fluidRow(
                                column(4, conditionalPanel ("input.goButton >=1", wellPanel(
                                        
                                        p("Chrám zkoušek, vyber si jednu ze tří chodeb. V první jsou krysy, ve druhé nášlapné pasti, 
                                          ve třetí hlavolam."),
                                        
                                        radioButtons("trial", label = h5("Which one do you choose?"),
                                                     choices = list("Rats" = 1, "Traps" = 2, "Riddles" = 3), 
                                                     selected = 1, inline = TRUE), 
                                        
                                        actionButton("fightButton", "Go to chosed tunnel")
                                        
                                                        ) #end of wellPanel
                                        )#end of conditionalPanel
                                ), #end of column 1, fluidrow 1
                                
                                column(4, conditionalPanel ("input.fightButton >=1", wellPanel(
                                        p("Here are results of your trial:"),
                                        tableOutput("table"),
                                        radioButtons("winLose", label=h4("Have you win?"), 
                                                     choices = list("Yes"=1, "No"=2), selected = character(0))
                                        
                                                        ) #end of wellPanel      
                                        ) #end of conditionalPanel
                                ), #end of column 2, fluidrow 1
                                
                                column(4, conditionalPanel("input.winLose == 1", wellPanel(
                                        p("Well done. You win one more atribution point. Please assign it and proceed to
                                          the last trial with the Gatekeeper. As he is a final boss, he has two rolls of dice.
                                          Spend your free point wise.")
                                        
                                                        ) #end of wellPanel
                                        ), #end of conditionalPanel win
                                       
                                       conditionalPanel("input.winLose == 2",
                                                           wellPanel(p("Chose another tunnel.")
                                                                     
                                                        ) #end of wellPanel
                                        )#end of conditionalPanel lose
                                ) #end of column 3, fluidrow 1
                                
                        ), #end of fluidRow 1
                        
                        fluidRow(
                                column(4, conditionalPanel ("input.goButton2 >= 1", wellPanel(
                                        p("The gatekeeper. As his title suggests, he keeps the gate leading out from trial chambers.
                                          You may fight with him, try to steal a key from him or 
                                          you can try to persuade him to let you go. What path do you choose?"),
                                        
                                        radioButtons("gatekeeper", label = h3("The gatekeeper"),
                                                     choices = list("Fight" = 1, "Steal" = 2, "Talk" = 3), 
                                                     selected = 1, inline = TRUE), 
                                        
                                        actionButton("bossButton", "Approach gatekeeper.")
                                        
                                                        ) #end of wellPanel
                                        ) #end of conditionalPanel
                                ), #end of column 1, fluidrow 2
                                
                                column(4, conditionalPanel ("input.bossButton >= 1", wellPanel(
                                        p("Here are results of your final trial:"),
                                        tableOutput("boss"),
                                        radioButtons("winLoseBoss", label=h5("Have you win?"), 
                                                     choices = list("Yes"=1, "No"=2), selected = character(0))
                                        
                                                )  #end of wellPanel     
                                        ) #end of conditionaPanel
                                ), #end of column 2, fluidrow 2
                                
                                column(4, conditionalPanel("input.winLoseBoss == 1", wellPanel(
                                        h3("Congratulations!"),
                                        p("You succesfully went through trials and are ready to go for your adventure.
                                          Here, take this fern, for luck."),
                                        plotOutput("fern")
                                        
                                                ) #end of wellPanel
                                        ), #end of conditionalPanel boss win
                                       
                                       conditionalPanel("input.winLoseBoss == 2", wellPanel(
                                               p("You failed. Try another way.")
                                                
                                               ) # end of wellPanel
                                       ) #end of conditionalPanel boss lose
                                ) #end of column 3, fluidrow 2
                        ) #end of fluidRow 2
                ) #end of mainPanel
)))
                        