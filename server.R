#import package data
library(shiny)
library(tidyverse)
library(plotly)

options(scipen = 999)
df <- read.csv("df.csv", header=T, fileEncoding = "UTF-8")

server <- function(input, output){
  # basic info
  d_basic <- reactive({
    df_basic_info_list <- list()
    for (i in c(3:11)){
      df_var <- df %>%
        count(var = df[colnames(df)[i]]) %>%
        mutate(., percentage = round(n/388, 2)) %>%
        arrange(desc(n))
      df_basic_info_list[[i]] <- df_var
    }
    
    return(df_basic_info_list)
  })
  
  # dependent variable
  dv.at <- reactive({
    df_dv_list <- list()
    for (i in c(12:18)){
      df_var <- df %>%
        filter(., df[,6] %in% input$inhabitation_9th_grade & df[,5] %in% input$gender)
      df_var <- df_var %>%
        count(., var = df_var[colnames(df_var)[i]]) %>%
        mutate(., pct = round(n/length(df_var[,1]), 2))
      df_dv_list [[i]] <- df_var
    }
    
    return(df_dv_list)
  })
  
  dv.ab <- reactive({
    df_dv_list <- list()
    for (i in c(19:35)){
      df_var <- df %>%
        filter(., df[,6] %in% input$inhabitation_9th_grade.ab & df[,5] %in% input$gender.ab)
      df_var <- df_var %>%
        count(., var = df_var[colnames(df_var)[i]]) %>%
        mutate(., pct = round(n/length(df_var[,1]), 2)) %>%
        arrange(match(var, c("非常流利", "流利", "普通", "不太會", "非常不會")))
      df_dv_list [[i]] <- df_var
    }
    
    return(df_dv_list)
  })
  
  dv.us <- reactive({
    df_dv_list <- list()
    for (i in c(36:56)){
      df_var <- df %>%
        filter(., df[,6] %in% input$inhabitation_9th_grade.us & df[,5] %in% input$gender.us)
      df_var <- df_var %>%
        count(., var = df_var[colnames(df_var)[i]]) %>%
        mutate(., pct = round(n/length(df_var[,1]), 2)) %>%
        arrange(match(var, c("很頻繁", "偶爾", "幾乎沒有", "從未")))
      df_dv_list [[i]] <- df_var
    }
    
    return(df_dv_list)
  })
  
  # page 1. basic info
  output$p1_1_major <- renderDataTable({
    d_basic()[[3]]
  })
  
  output$p1_2_age <- renderDataTable({
    d_basic()[[4]]
  })
  
  output$p1_3_gender <- renderDataTable({
    d_basic()[[5]]
  })
  
  output$p1_4_inhabitationat9thgrade <- renderDataTable({
    d_basic()[[6]]
  })
  
  output$p1_5_grandparents <- renderDataTable({
    d_basic()[[7]]
  })
  
  output$p1_6_mothertongue <- renderDataTable({
    d_basic()[[8]]
  })
  
  output$p1_7_sixathome <- renderDataTable({
    d_basic()[[9]]
  })
  
  output$p1_8_use <- renderDataTable({
    d_basic()[[10]]
  })
  
  output$p1_9_ability <- renderDataTable({
    d_basic()[[11]]
  })
  
  # page 2. attitude
  output$p1_10 <- renderTable({
    input$Inspect_at
    isolate(dv.at()[[12]])
  })
  
  output$p1_11 <- renderTable({
    input$Inspect_at
    isolate(dv.at()[[13]])
  })
  
  output$p1_12 <- renderTable({
    input$Inspect_at
    isolate(dv.at()[[14]])
  })
  
  output$p1_13 <- renderTable({
    input$Inspect_at
    isolate(dv.at()[[15]])
  })
  
  output$p1_14 <- renderTable({
    input$Inspect_at
    isolate(dv.at()[[16]])
  })
  
  output$p1_15 <- renderTable({
    input$Inspect_at
    isolate(dv.at()[[17]])
  })
  
  output$p1_16 <- renderTable({
    input$Inspect_at
    isolate(dv.at()[[18]])
  })
  # page 3. ability
  # ?隤?
  output$p3_1 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[19]])
  })
  
  output$p3_2 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[20]])
  })
  
  output$p3_3 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[21]])
  })
  
  output$p3_4 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[22]])
  })
  # ?隤?
  output$p3_5 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[23]])
  })
  
  output$p3_6 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[24]])
  })
  
  output$p3_7 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[25]])
  })
  
  output$p3_8 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[26]])
  })
  # 摰Ｚ??
  output$p3_9 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[27]])
  })
  
  output$p3_10 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[28]])
  })
  
  output$p3_11 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[29]])
  })
  
  output$p3_12 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[30]])
  })
  # ???????
  output$p3_13 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[31]])
  })
  
  output$p3_14 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[32]])
  })
  
  output$p3_15 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[33]])
  })
  
  output$p3_16 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[34]])
  })
  
  output$p3_17 <- renderTable({
    input$Inspect_ab
    isolate(dv.ab()[[35]])
  })
  
  # page 4. usage
  # ?隤?
  output$p4_1 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[36]])
  })
  
  output$p4_2 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[37]])
  })
  
  output$p4_3 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[38]])
  })
  
  output$p4_4 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[39]])
  })
  
  output$p4_5 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[40]])
  })
  
  # ?隤?
  output$p4_6 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[41]])
  })
  
  output$p4_7 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[42]])
  })
  
  output$p4_8 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[43]])
  })
  
  output$p4_9 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[44]])
  })
  
  output$p4_10 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[45]])
  })
  
  # 摰Ｚ??
  output$p4_11 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[46]])
  })
  
  output$p4_12 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[47]])
  })
  
  output$p4_13 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[48]])
  })
  
  output$p4_14 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[49]])
  })
  
  output$p4_15 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[50]])
  })
  
  # ???????
  output$p4_16 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[51]])
  })
  
  output$p4_17 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[52]])
  })
  
  output$p4_18 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[53]])
  })
  
  output$p4_19 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[54]])
  })
  
  output$p4_20 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[55]])
  })
  
  output$p4_21 <- renderTable({
    input$Inspect_us
    isolate(dv.us()[[56]])
  })
}