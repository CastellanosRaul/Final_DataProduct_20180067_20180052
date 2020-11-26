
library(shiny)
shinyUI(fluidPage(
    
    tabsetPanel(
        tabPanel('Tabla Covid-19 por país',
                 titlePanel("Casos de Covid 2020"),
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput(
                             "date0","Date",min = min(data$Date),max = max(data$Date),value = c(min(data$Date),max(data$Date)),step = 1
                         ),
                         selectInput(
                             "pais0","Seleccione País", choices = levels(as.factor(data$CountryRegion)),multiple = TRUE
                         ),
                         selectInput(
                             "estado0","Seleccione el estado", choices = levels(as.factor(data$Estatus)),multiple = TRUE
                         )
                     ),
                     mainPanel(
                         DT::dataTableOutput("data0")
                     )
                 )
        ),
        tabPanel('Mapa por país',
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput(
                             "date","Date",min = min(data$Date),max = max(data$Date),value = c(min(data$Date),max(data$Date)),step = 1
                         ),
                         
                         selectInput(
                             "pais","Seleccione País", choices = levels(as.factor(data$CountryRegion)),multiple = TRUE,selected="China"
                         ),
                         selectInput(
                             "estado","Seleccione el estado", choices = levels(as.factor(data$Estatus)),multiple = TRUE, selected = "Confirmed"
                         )
                     ),
                     mainPanel(
                         leafletOutput(outputId = "map", width="100%")
                     )
                 )
        ),
        tabPanel('Gáficas por país',
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput(
                             "date1","Date",min = min(data$Date),max = max(data$Date),value = c(min(data$Date),max(data$Date)),step = 1
                         ),
                         
                         selectInput(
                             "pais1","Seleccione País", choices = levels(as.factor(data$CountryRegion)),multiple = FALSE
                         ),
                         selectInput(
                             "estado1","Seleccione el estado", choices = levels(as.factor(data$Estatus)),multiple = FALSE,selected = "Confirmados"
                         )
                     ),
                     mainPanel(
                         "Casos totales acumulados", plotOutput("casos")
                     )
                 )
        ),
        tabPanel('Tabla Mundial Covid-19',
                 titlePanel("Casos de Covid 2020"),
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput(
                             "date2","Date",min = min(data$Date),max = max(data$Date),value = c(min(data$Date),max(data$Date)),step = 1
                         ),
                         selectInput(
                             "estado2","Seleccione el estado", choices = levels(as.factor(data$Estatus)),multiple = TRUE
                         )
                     ),
                     mainPanel(
                         DT::dataTableOutput("data1")
                     )
                 )
        ),
        tabPanel('Mapa Mundial',
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput(
                             "date3","Date",min = min(data$Date),max = max(data$Date),value = c(min(data$Date),max(data$Date)),step = 1
                         ),
                         selectInput(
                             "estado3","Seleccione el estado", choices = levels(as.factor(data$Estatus)),multiple = TRUE, selected = "Confirmed"
                         )
                     ),
                     mainPanel(
                         leafletOutput(outputId = "map1", width="100%")
                     )
                 )
        ),
        tabPanel('Gáficas Mundial',
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput(
                             "date4","Date",min = min(data$Date),max = max(data$Date),value = c(min(data$Date),max(data$Date)),step = 1
                         ),
                         selectInput(
                             "estado4","Seleccione el estado", choices = levels(as.factor(data$Estatus)),multiple = FALSE,selected = "Confirmed"
                         )
                     ),
                     mainPanel(
                         "Casos totales acumulados", plotOutput("casos1")
                     )
                 )
        )
    )
)
)