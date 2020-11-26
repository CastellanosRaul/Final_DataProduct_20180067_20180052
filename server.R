library(readr)
library(leaflet)
library(lubridate)
library(dplyr)
deaths <- read_csv("tidydeath.csv")
confirmed <- read_csv("tidyconfirmed.csv")
recovered <- read_csv("tidyrecovered.csv")
deaths <- deaths[,-1]
recovered <- recovered[,-1]
confirmed <- confirmed[,-1]
data <- rbind(confirmed,deaths,recovered)
data$Date <- as.Date(data$CoviDate)
data$Estatus <- ifelse(data$Estatus==1,"Confirmed",ifelse(data$Estatus==2,"Death","Recovered"))
#data <- data[sample(1:nrow(data),100),]
datag <- data %>% filter(CountryRegion=="Guatemala")

library(shiny)


shinyServer(function(input, output) {
    
    output$data0 <- DT::renderDataTable(
        (data %>% filter((CountryRegion %in% input$pais0) & (Date >= input$date0[1] & Date <= input$date0[2]) & Estatus %in% input$estado0)), extensions = 'Buttons', options = list(dom = 'Bfrtip', buttons = list('csv', 'excel'))
    )
    
    output$map <- renderLeaflet({
        pal <- colorFactor(c("navy", "red", "green"),
                           domain = unique(data$Estatus))
        leaflet(data %>% filter((CountryRegion %in% input$pais) & (Date >= input$date[1] & Date <= input$date[2]) & Estatus %in% input$estado & Cantidad>0))  %>% addProviderTiles("CartoDB.Positron") %>%
            addCircleMarkers(color = ~pal(Estatus),
                             stroke = FALSE, fillOpacity = 0.5,
                             lng = ~Longitude, lat = ~Latitude,
                             label = ~as.character(Estatus))
        
    })
    
    output$casos <- renderPlot({
        fechas <- data %>% filter((CountryRegion %in% input$pais1) & (Date >= input$date1[1] & Date <= input$date1[2]) & Estatus %in% input$estado1) %>% group_by(Date) %>% summarise(total = sum(Cantidad), .groups ='drop')
        barplot(fechas$total, main="Casos",
                xlab="fecha")
    })
    output$data1 <- DT::renderDataTable(
        (data %>% filter((Date >= input$date2[1] & Date <= input$date2[2]) & Estatus %in% input$estado2)), extensions = 'Buttons', options = list(dom = 'Bfrtip', buttons = list('csv', 'excel'))
    )
    
    output$map1 <- renderLeaflet({
        pal <- colorFactor(c("navy", "red", "green"),
                           domain = unique(data$Estatus))
        leaflet(data %>% filter((Date >= input$date3[1] & Date <= input$date3[2]) & Estatus %in% input$estado3 & Cantidad >0))  %>%   addProviderTiles("CartoDB.Positron") %>%
            addCircleMarkers(color = ~pal(Estatus),
                             stroke = FALSE, fillOpacity = 0.5,
                             lng = ~Longitude, lat = ~Latitude,
                             label = ~as.character(Estatus))
    })
    
    output$casos1 <- renderPlot({
        fechas <- data %>% filter((Date >= input$date4[1] & Date <= input$date4[2]) & Estatus %in% input$estado4) %>% group_by(Date) %>% summarise(total = sum(Cantidad), .groups ='drop')
        barplot(fechas$total, main="Casos",
                xlab="fecha")
    })
})