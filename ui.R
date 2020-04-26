
library(shiny)

shinyUI(navbarPage("D&D Helper",
                   # Welcome/load page----
                   tabPanel("Welcome",
                            fluidRow(column(3),
                                     column(6,
                                            "You must load a character file to use this web app. If you don't already have one you can make one in the 'New Character' tab"),
                                     column(3)),
                            # load a character ----
                            hr(),
                            fluidRow(
                              column(6,
                                     h4("Currently loaded character: ")),
                              column(6,
                                     textOutput("character_name"))
                            ),
                            fluidRow(
                              column(12,
                                     fileInput("character_file",
                                               "Load Character File",
                                               accept = c(".RDS", ".rds"))
                              )
                            )
                   ),
                   # saving throws---
                   tabPanel("Saving Throws",
                            fluidRow(
                              # ability saving throw
                              column(2,
                                     selectInput(inputId = "saving_throw_type",
                                                 label = "Saving Throw",
                                                 choices = ability_list,
                                                 selected = ability_list[1])),
                              column(2,
                                     numericInput(inputId = "saving_throw_roll",
                                                  label = "Roll Value",
                                                  value = NA,
                                                  min = 1, max = 20,
                                                  step = 1)),
                              column(2,
                                     actionButton(inputId = "get_saving_throw",
                                                  label = "Get saving throw")),
                              column(6,
                                     uiOutput("saving_throw_result"))
                            ),
                            fluidRow(
                              # skill check
                              column(2, 
                                     selectInput(inputId = "skill_check_type",
                                                 label = "Skill Check",
                                                 choices = skill_list,
                                                 selected = skill_list[1])),
                              column(2,
                                     numericInput(inputId = "skill_check_roll",
                                                  label = "Roll Value",
                                                  value = NULL,
                                                  min = 1, max = 20,
                                                  step = 1)),
                              column(2,
                                     actionButton(inputId = "get_skill_check",
                                                  label = "Get skill check")),
                              column(6,
                                     uiOutput("skill_check_result"))
                            ),
                            fluidRow(
                              # dice roller
                              
                              column(2, 
                                     selectInput(inputId = "die_type",
                                                 label = "Die type",
                                                 choices = list("d4" = 4,
                                                                "d6" = 6,
                                                                "d8" = 8,
                                                                "d10" = 10,
                                                                "d12" = 12,
                                                                "d20" = 20,
                                                                "d100" = 100),
                                                 selected = 20)),
                              column(2,
                                     numericInput(inputId = "number_of_dice",
                                                  label = "Number of dice",
                                                  value = 1,
                                                  min = 1, max = 100,
                                                  step = 1)),
                              # column(2,
                              #        numericInput(inputId = "dice_modifier",
                              #                     label = "Modifer",
                              #                     value = 0,
                              #                     min = 0, max = 100,
                              #                     step = 1)),
                              column(2,
                                     actionButton(inputId = "roll_dice",
                                                  label = "Roll")),
                              column(6,
                                     uiOutput(outputId = "dice_roll_result"))
                            )),
                   # new character----
                   tabPanel("New Character",
                            
                            fluidRow(
                              column(2,
                                     numericInput("new_char_str",
                                                  "STR",
                                                  value = 10,
                                                  min = 1,
                                                  max = 20,
                                                  step = 1),
                                     numericInput("new_char_dex",
                                                  "DEX",
                                                  value = 10,
                                                  min = 1,
                                                  max = 20,
                                                  step = 1),
                                     numericInput("new_char_con",
                                                  "CON",
                                                  value = 10,
                                                  min = 1,
                                                  max = 20,
                                                  step = 1),
                                     numericInput("new_char_int",
                                                  "INT",
                                                  value = 10,
                                                  min = 1,
                                                  max = 20,
                                                  step = 1),
                                     numericInput("new_char_wis",
                                                  "WIS",
                                                  value = 10,
                                                  min = 1,
                                                  max = 20,
                                                  step = 1),
                                     numericInput("new_char_cha",
                                                  "CHA",
                                                  value = 10,
                                                  min = 1,
                                                  max = 20,
                                                  step = 1)),
                              column(2,
                                     checkboxGroupInput("new_char_profs",
                                                        "Proficiencies",
                                                        choices = c(ability_list, skill_list))),
                              column(2,
                                     textInput("new_char_name",
                                               "Character name",
                                               value = "",
                                               placeholder = "Give your new character a name"),
                                     numericInput("new_char_hp",
                                                  "Max hit points",
                                                  value = 1,
                                                  min = 1,
                                                  max = 1000,
                                                  step = 1),
                                     numericInput("new_char_speed",
                                                  "Speed",
                                                  value = 30,
                                                  min = 5,
                                                  max = 120,
                                                  step = 5),
                                     numericInput("new_char_proficiency",
                                                  "Proficiency",
                                                  value = 2,
                                                  min = 2,
                                                  max = 100,
                                                  step = 1),
                                     numericInput("new_char_level",
                                                  "Character level",
                                                  value = 1,
                                                  min = 1,
                                                  max = 20,
                                                  step = 1),
                                     selectInput("new_char_class",
                                                 "Class",
                                                 choices = list("Figher",
                                                                "Cleric", 
                                                                "Wizard",
                                                                "Sorceror",
                                                                "Warlock",
                                                                "Rogue",
                                                                "Paladin",
                                                                "Barbarian",
                                                                "Druid",
                                                                "Bard",
                                                                "Ranger",
                                                                "?? I'm going from memory..."))),
                              column(2,
                                     downloadButton("save_new_character", "Save New Character"))
                              
                              
                            )
                   ),
                   # stats page ----
                   tabPanel("Stats",
                            fluidRow(
                              column(12,
                                     h2(textOutput("character_name")))
                            ),
                            fluidRow(
                              column(6,
                                     tableOutput('stat_table'),
                                     tableOutput('proficiency_table')
                              ),
                              column(6,
                                     tableOutput('skill_table')
                              )
                            )
                   ),
                   # the 'more' area ----
                   navbarMenu("More",
                              tabPanel("Sub-Component A"),
                              tabPanel("Sub-Component B",
                                       fluidPage(
                                         # Page title
                                         titlePanel("another section")
                                       )
                              )
                   )
)
)
