
library(shiny)

shinyUI(navbarPage("D&D Helper",
                   # Welcome/load page------------------------------------------
                   tabPanel(
                     title = "Welcome",
                     fluidRow(column(4,
                                     "You must load a character file to use this web app. If you don't already have one you can make one in the 'Character' tab")
                     ),
                     # _ load a character ----
                     hr(),
                     fluidRow(
                       column(6,
                              h4("Currently loaded character: ")
                       ),
                       column(6,
                              uiOutput("current_character_name")
                       )
                     ),
                     fluidRow(
                       column(12,
                              fileInput("load_character_file",
                                        "Load Character File",
                                        accept = c(".RDS", ".rds"))
                       )
                     ),
                     fluidRow(
                       column(6,
                              p("After the file loads you must press the button below to actually use the loaded file. I can't make it do the second step automatically when you load. I don't know why. I guess it's because I suck, sorry.")
                       )
                     ),
                     fluidRow(
                       column(12,
                              actionButton("use_loaded_character", 
                                           "Use Loaded Character")
                       )
                     )
                   ),
                   # character stats----
                   tabPanel(
                     title = "Character",
                     fluidRow(
                       column(2,
                              numericInput("character_str",
                                           "STR",
                                           value = 10,
                                           min = 1,
                                           max = 20,
                                           step = 1),
                              numericInput("character_dex",
                                           "DEX",
                                           value = 10,
                                           min = 1,
                                           max = 20,
                                           step = 1),
                              numericInput("character_con",
                                           "CON",
                                           value = 10,
                                           min = 1,
                                           max = 20,
                                           step = 1),
                              numericInput("character_int",
                                           "INT",
                                           value = 10,
                                           min = 1,
                                           max = 20,
                                           step = 1),
                              numericInput("character_wis",
                                           "WIS",
                                           value = 10,
                                           min = 1,
                                           max = 20,
                                           step = 1),
                              numericInput("character_cha",
                                           "CHA",
                                           value = 10,
                                           min = 1,
                                           max = 20,
                                           step = 1)),
                       column(2,
                              checkboxGroupInput("character_profs",
                                                 "Proficiencies",
                                                 choices = c(ability_list, skill_list))),
                       column(2,
                              textInput("character_name",
                                        "Character name",
                                        value = "NO CHARACTER LOADED YET",
                                        placeholder = "Give your new character a name"),
                              numericInput("character_hp",
                                           "Max hit points",
                                           value = 1,
                                           min = 1,
                                           max = 1000,
                                           step = 1),
                              numericInput("character_speed",
                                           "Speed",
                                           value = 30,
                                           min = 5,
                                           max = 120,
                                           step = 5),
                              numericInput("character_proficiency",
                                           "Proficiency",
                                           value = 2,
                                           min = 2,
                                           max = 100,
                                           step = 1),
                              numericInput("character_level",
                                           "Character level",
                                           value = 1,
                                           min = 1,
                                           max = 20,
                                           step = 1),
                              selectInput("character_class",
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
                              downloadButton("save_character", "Save Character")
                              
                              
                       )
                     )),
                     # rolls----
                     tabPanel("Rolls",
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
                   # saving throws----
                   tabPanel("Saving Throws",
                            fluidRow(
                              column(8,
                                     actionButton(inputId = "str_saving_throw",
                                                 label = "STR"),
                                     actionButton(inputId = "dex_saving_throw",
                                                  label = "DEX"),
                                     actionButton(inputId = "con_saving_throw",
                                                  label = "CON"),
                                     actionButton(inputId = "int_saving_throw",
                                                  label = "INT"),
                                     actionButton(inputId = "wis_saving_throw",
                                                  label = "WIS"),
                                     actionButton(inputId = "cha_saving_throw",
                                                  label = "CHA")
                                     ),
                                     
                              column(4,
                                     uiOutput("saving_throw_result2"))
                            )
                   ),
                   
                   # skill chekcs----
                   tabPanel("Skill Checks",
                            fluidRow(
                              column(8,
                                     actionButton(inputId = "acrobatics_skill_check",
                                                  label = "Acrobatics"),
                                     actionButton(inputId = "animal_handling_skill_check",
                                                  label = "Animal Handling"),
                                     actionButton(inputId = "arcana_skill_check",
                                                  label = "Arcana"),
                                     actionButton(inputId = "athletics_skill_check",
                                                  label = "Athletics"),
                                     actionButton(inputId = "deception_skill_check",
                                                  label = "Deception"),
                                     actionButton(inputId = "history_skill_check",
                                                  label = "History"),
                                     actionButton(inputId = "insight_skill_check",
                                                  label = "Insight"),
                                     actionButton(inputId = "intimidation_skill_check",
                                                  label = "Intimidation"),
                                     actionButton(inputId = "investigation_skill_check",
                                                  label = "Investigation"),
                                     actionButton(inputId = "medicine_skill_check",
                                                  label = "Medicine"),
                                     actionButton(inputId = "nature_skill_check",
                                                  label = "Nature"),
                                     actionButton(inputId = "perception_skill_check",
                                                  label = "Perception"),
                                     actionButton(inputId = "performance_skill_check",
                                                  label = "Performance"),
                                     actionButton(inputId = "persuasion_skill_check",
                                                  label = "Persuasion"),
                                     actionButton(inputId = "religion_skill_check",
                                                  label = "Religion"),
                                     actionButton(inputId = "sleight_of_hand_skill_check",
                                                  label = "Sleight of Hand"),
                                     actionButton(inputId = "stealth_skill_check",
                                                  label = "Stealth"),
                                     actionButton(inputId = "survival_skill_check",
                                                  label = "Survival")
                              ),
                              
                              column(4,
                                     uiOutput("skill_check_result2"))
                            )
                   ),
                   
                     # stats page ----
                     tabPanel("Stats",
                              fluidRow(
                                column(12,
                                       h2("placeholder for loaded character name")
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
                              )
                     )
                   ))
        