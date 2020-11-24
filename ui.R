library(shiny)
library(plotly)
library(ggplot2)
library(DT)
library(ggrepel)
library(shinycssloaders)
library(shinythemes)
library(SwimmeR)
library(shinyWidgets)

city_names <- c("基隆市", "新北市", "臺北市", "桃園市", "新竹市", "新竹縣", "苗栗縣",
                "臺中市", "彰化縣", "南投縣", "雲林縣", "嘉義縣", "臺南市",
                "高雄市", "屏東縣", 
                "宜蘭縣", "花蓮縣", "臺東縣",
                "澎湖縣", "香港", "馬來西亞", "美國")
button_color_css <- "
#Inspect_at, #Inspect_ab, #Inspect_us{
/* Change the background color of the update button
to blue. */
background: DodgerBlue;
/* Change the text size to 15 pixels. */
font-size: 15px;
}"

select_city_css <- "
# no{
height: 100px;
}
"

ui <- navbarPage(
  theme = shinytheme("lumen"),
  tags$link(rel="preconnect", href="https://fonts.gstatic.com"),
  tags$link(href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap", rel="stylesheet"),
  tags$style(HTML('body {font-family: "Noto Sans TC", sans-serif;}')),
  title = "台灣大學語言使用習慣調查-台大學生會文化部本土語言小組",
  selected = "基本資料",
  #page1-basic_info ####
  tabPanel("基本資料", fluid = T, icon = icon("chart-bar"),
           headerPanel("基本資料"),
           sidebarPanel(
             h2("有效樣本: 388"),
             p("版本20201119"),
             p("抱歉之後才會補上漂漂的圖表跟把版面排好看一點QQ"),
             p("製作：廖政華Kamel Liao")
           ),
           mainPanel(
             fluidRow(
               column(4, h2("系級"), dataTableOutput("p1_1_major")),
               column(4, h2("年紀"), dataTableOutput("p1_2_age")),
               column(4, h2("性別"), dataTableOutput("p1_3_gender")),
             ),
             fluidRow(
               column(4, h2("國三居住地"), dataTableOutput("p1_4_inhabitationat9thgrade")),
               column(4, h2("祖父母族群"), dataTableOutput("p1_5_grandparents")),
               column(4, h2("母語認同"), dataTableOutput("p1_6_mothertongue"))
             ),
             fluidRow(
               column(4, h2("六歲在家語言"), dataTableOutput("p1_7_sixathome")),
               column(4, h2("語言_使用頻率_最常"), dataTableOutput("p1_8_use")),
               column(4, h2("語言_能力"), dataTableOutput("p1_9_ability"))
             )
           )
  ),
  tabPanel("對本土語言的態度", fluid = T, icon = icon("comment"),
           tags$style(button_color_css),
           tags$style(select_city_css),
           headerPanel("對本土語言的態度"),
           sidebarPanel(
             titlePanel("有興趣觀察的變項"),
             # 性別
             checkboxGroupInput(inputId = "gender",
                               label = "性別:",
                               choices = c("男", "女"),
                               selected = c("男", "女"),
                               inline = TRUE
                               ),
             # 國三居住地
             pickerInput(
                 "inhabitation_9th_grade",
                 label = "國三居住地:",
                 choices = city_names,
                 selected = city_names,
                 multiple = TRUE,
                 options = list(`actions-box` = TRUE,
                                height = 100)
                 ),
             actionButton(inputId = "Inspect_at", label = "檢視")
           ),
           mainPanel(
             fluidRow(
               column(4, h2("台語_應學會程度"), tableOutput("p1_10")),
               column(4, h2("客語_應學會程度"), tableOutput("p1_11")),
               column(4, h2("原住民族語_應學會程度"), tableOutput("p1_12"))
             ),
             fluidRow(
               column(4, h2("修本土語言意願"), tableOutput("p1_13")),
               column(4, h2("支持本土語言抵大一國文"), tableOutput("p1_14")),
               column(4, h2("支持大學入學考試提供本土語言版本試卷"), tableOutput("p1_15"))
             ),
             h2("本土語言在台使用情形看法"),
             tableOutput("p1_16")
             )),
  tabPanel("本土語言能力", fluid = T, icon = icon("pen"),
           tags$style(button_color_css),
           tags$style(select_city_css),
           headerPanel("本土語言能力"),
           sidebarPanel(
             titlePanel("有興趣觀察的變項"),
             # 性別
             checkboxGroupInput(inputId = "gender.ab",
                                label = "性別:",
                                choices = c("男", "女"),
                                selected = c("男", "女"),
                                inline = TRUE
             ),
             # 國三居住地
             pickerInput(
               "inhabitation_9th_grade.ab",
               label = "國三居住地:",
               choices = city_names,
               selected = city_names,
               multiple = TRUE,
               options = list(`actions-box` = TRUE,
                              height = 100)
             ),
             actionButton(inputId = "Inspect_ab", label = "檢視")
           ),
           mainPanel(
             h1("華語"),
             fluidRow(
               column(3, h2("聽力"), tableOutput("p3_1")),
               column(3, h2("口語表達"), tableOutput("p3_2")),
               column(3, h2("閱讀能力"), tableOutput("p3_3")),
               column(3, h2("寫作能力"), tableOutput("p3_4"))
             ),
             h1("台語"),
             fluidRow(
               column(3, h2("聽力"), tableOutput("p3_5")),
               column(3, h2("口語表達"), tableOutput("p3_6")),
               column(3, h2("閱讀能力"), tableOutput("p3_7")),
               column(3, h2("寫作能力"), tableOutput("p3_8"))
             ),
             h1("客語"),
             fluidRow(
               column(3, h2("聽力"), tableOutput("p3_9")),
               column(3, h2("口語表達"), tableOutput("p3_10")),
               column(3, h2("閱讀能力"), tableOutput("p3_11")),
               column(3, h2("寫作能力"), tableOutput("p3_12"))
             ),
             h1("原住民族語"),
             fluidRow(
               column(3, h2("聽力"), tableOutput("p3_13")),
               column(3, h2("口語表達"), tableOutput("p3_14")),
               column(3, h2("閱讀能力"), tableOutput("p3_15")),
               column(3, h2("寫作能力"), tableOutput("p3_16"))
             ),
             column(3, h2("哪一種語言"), tableOutput("p3_17"))
           )
           ),
  tabPanel("本土語言使用情形", fluid = T, icon = icon("user-friends"),
           tags$style(button_color_css),
           headerPanel("本土語言使用情形"),
           sidebarPanel(
             titlePanel("有興趣觀察的變項"),
             # 性別
             checkboxGroupInput(inputId = "gender.us",
                                label = "性別:",
                                choices = c("男", "女"),
                                selected = c("男", "女"),
                                inline = TRUE
             ),
             # 國三居住地
             pickerInput(
               "inhabitation_9th_grade.us",
               label = "國三居住地:",
               choices = city_names,
               selected = city_names,
               multiple = TRUE,
               options = list(`actions-box` = TRUE,
                              height = 100)
             ),
             actionButton(inputId = "Inspect_us", label = "檢視")
           ),
           mainPanel(
             h1("華語"),
             fluidRow(
               column(2, h2("祖父母"), tableOutput("p4_1")),
               column(2, h2("父母"), tableOutput("p4_2")),
               column(3, h2("兄弟姊妹"), tableOutput("p4_3")),
               column(3, h2("其他年長親戚"), tableOutput("p4_4")),
               column(2, h2("同儕"), tableOutput("p4_5"))
             ),
             h1("臺語"),
             fluidRow(
               column(2, h2("祖父母"), tableOutput("p4_6")),
               column(2, h2("父母"), tableOutput("p4_7")),
               column(3, h2("兄弟姊妹"), tableOutput("p4_8")),
               column(3, h2("其他年長親戚"), tableOutput("p4_9")),
               column(2, h2("同儕"), tableOutput("p4_10"))
             ),
             h1("客語"),
             fluidRow(
               column(2, h2("祖父母"), tableOutput("p4_11")),
               column(2, h2("父母"), tableOutput("p4_12")),
               column(3, h2("兄弟姊妹"), tableOutput("p4_13")),
               column(3, h2("其他年長親戚"), tableOutput("p4_14")),
               column(2, h2("同儕"), tableOutput("p4_15"))
             ),
             h1("原住民族語"),
             fluidRow(
               column(2, h2("祖父母"), tableOutput("p4_16")),
               column(2, h2("父母"), tableOutput("p4_17")),
               column(3, h2("兄弟姊妹"), tableOutput("p4_18")),
               column(3, h2("其他年長親戚"), tableOutput("p4_19")),
               column(2, h2("同儕"), tableOutput("p4_20"))
             ),
             column(6, h2("哪一種語言"), tableOutput("p4_21"))
           ))
)
