shinyUI(fluidPage(theme = "bootstrap.css", style = "color:rgb(187,187,153)",
        titlePanel("Simple RPG simulator"),
        
#++++++++++ ATRIBUTE SETTINGS ++++++++++       
        
        fluidRow(
                #++++++++++ INTRO
                fluidRow(
                        column(1, img(src = "torch_gifmania_co_uk.gif"),
                               br(),
                               img(src = "torch_gifmania_co_uk.gif")),
                        column(10, wellPanel(
                          h3 ("The Temple of Trials", style = "text-align:center"),
                          h4("Imagine yourself being a young member of a small tribe somewhere in
                                the wastelands aching to explore the world beyond your village's outskirts. Your task is to go 
                                through the Trial and prove yourself worth of adventure you wish to experience. You will be tested
                            inside the Temple of trials, where you will have to face two challenges testing your abilities.
                            You have to determine your abilities first, spending 3 atribution points. If you invest one point, you
                                are weak in respective ability, if you invest two points, you are good at it, if you invest all your
                                points into one ability, you are the best and cannot be defeated. Chose well, 
                            you cannot be the best in everything, yet it is better to be at least good in something."),
                          br(),
                          p("In more practical terms, you are to distribute 3 atribution points into your atributes 
                            (strength, agility, intelligence). Number of invested points determine number of dice rolls you have 
                        given use of respective ability. The trials take form of dice rolls, the sum of your roll(s) have to be
                            bigger then sum of your opponent roll(s). In first trial your opponents have one dice roll, in second one
                            your opponent has two rolls. You will have one more atribution point to spend after winning in first trial.")
                                ) #end of wellPanel    
                        ), #end of collumn of inside fluidRow 1
                        
                        column(1, img(src = "torch_gifmania_co_uk.gif"),
                               br(),
                               img(src = "torch_gifmania_co_uk.gif"))
                        
                ), #end of inside fluidRow 1
                
                #++++++++++ SET ATRIBUTES
                fluidRow(
                        column(3, wellPanel(
                               helpText("Points spent (have to be 3 to be able to proceed):"),
                               verbatimTextOutput("sum"))
                        ), #end of column 1, inside fluidRow 2
                        
                        column(3, wellPanel(
                               numericInput("st", "Strength", min=0, max=3, step=1, value=0))
                        ), #end of column 2, inside fluidRow 2
                        
                        column(3, wellPanel(
                               numericInput("ag", "Agility", min=0, max=3, step=1, value=0))
                        ), #end of column 3, inside fluidRow 2
                        
                        column(3, wellPanel(
                               numericInput("int", "Intelligence", min=0, max=3, step=1, value=0))
                        ) #end of column 4, inside fluidRow 2
                        
                ), #end of inside fluidRow 2
                
                #++++++++++ ACTION BUTTONS
                fluidRow(
                        column(3, offset = 3,
                               conditionalPanel("output.sum == 3", actionButton("goButton", "Go for first trial!"))
                        ), #end of column 1, inside fluidRow 3
                        
                        column(6,
                               conditionalPanel("input.winLose == 1",  
                                                div("Assign one more point to proceed.", style="color:red"),
                                                conditionalPanel("output.sum == 4", 
                                                                 actionButton("goButton2", "Go for final trial!"))
                               ) #end of wrapping conditionalPanel
                        ) #end of column 2, inside fluidRow 3
                        
                        
                ) #end of inside fluidRow 3
                
        ), #end of fluidRow 1



#++++++++++ FIRST TRIAL ++++++++++ 
        
        fluidRow(
                #++++++++++ CHOSE STAT
                column(4, conditionalPanel ("input.goButton >=1", wellPanel(
                               
                               p("Chose one of the passages. In first one you will have to fight with rats, in second one you will
                                 have to step lightly over the traps, and in the third one you will have to solve some riddles."),
                               
                               br(),
                               radioButtons("trial", label = ("Which one do you choose?"),
                                            choices = list("Rats" = 1, "Traps" = 2, "Riddles" = 3), 
                                            selected = 1, inline = TRUE),
                               img(src = "MAMRATAA_se.gif"),
                               img(src = "Bear_trap.jpg"),
                               img(src = "RunePic2.jpg"),
                               br(),
                               actionButton("fightButton", "Go to the chosed passage.")
                               
                               ) #end of wellPanel
                       )#end of conditionalPanel
                ), #end of column 1, fluidRow 2
                
                #++++++++++ FIGHT + WIN/LOSE
                column(4, conditionalPanel ("input.fightButton >=1", wellPanel(
                        p("Here are results of your trial:"),
                        tableOutput("table"),
                        br(),
                        img(src = "MAPLNTAA_se.gif"), img(src = "MAPLNTAA_se.gif"), img(src = "MAPLNTAA_se.gif"),
                        br(),
                        radioButtons("winLose", label=h4("Have you win?"), 
                                     choices = list("Yes"=1, "No"=2), selected = character(0))
                        
                                ) #end of wellPanel      
                        ) #end of conditionalPanel
                ), #end of column 2, fluidRow 2
                
                #++++++++++ WHATS NEXT
                column(4, conditionalPanel("input.winLose == 1", wellPanel(
                        p("Well done. You win one more atribution point. Please assign it and proceed to
                          the last trial with the Gatekeeper. As he is a final boss, he has two rolls of dice.
                          Spend your free point wise.")
                                ) #end of wellPanel
                        ), #end of conditionalPanel win
                
                        conditionalPanel("input.winLose == 2",
                                 wellPanel(p("Chose another passage.")
                                 ) #end of wellPanel
                        )#end of conditionalPanel lose
                ) #end of column 3, fluidRow 2
                
        ), #end of fluidRow 2



#++++++++++ GATEKEEPER ++++++++++ 
        
        fluidRow(
                #++++++++++ CHOSE STAT
                column(4, conditionalPanel ("input.goButton2 >= 1", wellPanel(
                                p("The gatekeeper. As his title suggests, he keeps the gate leading out from trial chambers.
                                          You may fight with him, try to steal a key from him or 
                                          you can try to persuade him to just let you go."),
                                
                                br(),
                                radioButtons("gatekeeper", label = ("What path do you choose?"),
                                     choices = list("Fight" = 1, "Steal" = 2, "Talk" = 3), 
                                     selected = 1, inline = TRUE), 
                                img(src = "fight3.gif"),
                                img(src = "pickpocket.gif"),
                                img(src = "thinking3.gif"),
                                br(),
                                actionButton("bossButton", "Approach gatekeeper.")
                                ) #end of wellPanel
                        ) #end of conditionalPanel
                ), #end of column 1,  fluidRow 3
                
                #++++++++++ FIGHT + WIN/LOSE
                column(4, conditionalPanel ("input.bossButton >= 1", wellPanel(
                                p("Here are results of your final trial:"),
                                tableOutput("boss"),
                                br(),
                                img(src = "MAPLNTAA_se.gif"), img(src = "MAPLNTAA_se.gif"), img(src = "MAPLNTAA_se.gif"),
                                br(),
                                radioButtons("winLoseBoss", label=h4("Have you win?"), 
                                     choices = list("Yes"=1, "No"=2), selected = character(0))
                                ) #end of wellPanel     
                        ) #end of conditionaPanel
                ), #end of column 2,  fluidRow 3
                
                #++++++++++ WHATS NEXT
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
                ) #end of column 3, fluidRow 3
                
        ), #end of fluidRow 3


#++++++++++ CREDITS ++++++++++

        fluidRow(
                column(10, offset = 1, conditionalPanel("input.winLoseBoss > 0", wellPanel(
                       h6("Credits for gifs go to gifmania.co.uk and Fallout NMA (http://www.nma-fallout.com)."),
                       h6("Credits for fern go to maggielinyu.wordpress.com")
                                ) #end of wellPanel
                        ) #end of conditionalPanel
                ) #end of column 1, fluidRow 4
        ) #end of fluidRow 4


)) #end of shinyUI