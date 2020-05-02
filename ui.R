
library(shiny)

shinyUI(
  navbarPage(
    theme = shinythemes::shinytheme("slate"), # darkly, slate
    collapsible = TRUE,
    inverse = FALSE,
    title = "D&D Helper",
    # Welcome/load page------------------------------------------
    tabPanel(
      tags$style(type="text/css", 
                 "
                 .checkbox { /* checkbox is a div class*/
                    line-height: 20px; /* 30px */
                    margin-bottom: 30px; /* 40px set the margin, so boxes don't overlap*/
                 }
                 input[type='checkbox']{ /* style for checkboxes */
                    width: 20px; /*Desired width 30*/
                    height: 20px; /*Desired height 30*/
                    line-height: 20px;  /* 30px */
                  }
                span { 
                    margin-left: 5px;  /*set the margin, so boxes don't overlap labels*/
                    line-height: 20px; /* 30px */
                }
                /* fix the alignment issue */
                .checkbox-inline { 
                    margin-left: 0px;
                    margin-right: 10px;
                }
                .checkbox-inline+.checkbox-inline {
                    margin-left: 0px;
                    margin-right: 10px;
                }
      "),
      title = "Welcome",
      fluidRow(
        column(12,
               p("You can load a character file to avoid inputing character information each time. If you don't already have a character file you can make one in the 'Character' tab.")
        )
      ),
      # _ load a character ----
      hr(),
      fluidRow(
        column(12,
               p("After the file loads you must press the button below to actually use the loaded file. I can't make it do the second step automatically when you load. I don't know why. I guess it's because I suck, sorry.")
        )
      ),
      fluidRow(
        column(12,
               fileInput("load_character_file",
                         "Load Character File",
                         accept = c(".RDS", ".rds")),
               
               actionButton("use_loaded_character", 
                            "Use Loaded Character")
        )
      )
    ),
    # character ----
    tabPanel(
      title = "Character",
      # fluidRow(
      #   column(12,
      #          h3(uiOutput("current_character_name")),
      #   )
      # ),
      fluidRow(
        column(2,
               numericInput("character_str",
                            "Strength",
                            value = 10,
                            min = 1,
                            max = 20,
                            step = 1),
               numericInput("character_dex",
                            "Dexterity",
                            value = 10,
                            min = 1,
                            max = 20,
                            step = 1),
               numericInput("character_con",
                            "Constitution",
                            value = 10,
                            min = 1,
                            max = 20,
                            step = 1),
               numericInput("character_int",
                            "Itelligence",
                            value = 10,
                            min = 1,
                            max = 20,
                            step = 1),
               numericInput("character_wis",
                            "Wisdom",
                            value = 10,
                            min = 1,
                            max = 20,
                            step = 1),
               numericInput("character_cha",
                            "Charisma",
                            value = 10,
                            min = 1,
                            max = 20,
                            step = 1),
               numericInput("character_proficiency",
                            "Proficiency",
                            value = 2,
                            min = 2,
                            max = 100,
                            step = 1)),
        column(6,
               checkboxGroupInput("character_profs",
                                  "Proficiencies",
                                  # choices = c(ability_list, skill_list),
                                  choiceValues = c(unname(ability_list),
                                                   unname(skill_list)),
                                  choiceNames = lapply(
                                    sprintf("<span style='font-family: monospace;'>%s</span>",
                                            stringr::str_pad(toupper(names(c(ability_list, skill_list))),
                                                             width = 17,
                                                             side = "right",
                                                             # \u00A0 is the unicode character for &nbsp;
                                                             pad = "\u00A0")), 
                                    HTML),
                                  inline = TRUE,
                                  width = "100%")),
        column(4,
               textInput("character_name",
                         "Character name",
                         value = "",
                         placeholder = "Give your new character a name"),
               # __ save character file
               downloadButton("save_character", "Save Character")
               # numericInput("character_hp",
               #              "Max hit points",
               #              value = 1,
               #              min = 1,
               #              max = 1000,
               #              step = 1),
               # numericInput("character_speed",
               #              "Speed",
               #              value = 30,
               #              min = 5,
               #              max = 120,
               #              step = 5),
               
               # numericInput("character_level",
               #              "Character level",
               #              value = 1,
               #              min = 1,
               #              max = 20,
               #              step = 1),
               # selectInput("character_class",
               #             "Class",
               #             choices = list("Figher",
               #                            "Cleric", 
               #                            "Wizard",
               #                            "Sorceror",
               #                            "Warlock",
               #                            "Rogue",
               #                            "Paladin",
               #                            "Barbarian",
               #                            "Druid",
               #                            "Bard",
               #                            "Ranger",
               #                            "?? I'm going from memory..."))
        )
      )),
    # # saving throws----
    # tabPanel("Saving Throws",
    #          fluidRow(
    #            column(8,
    #                   actionButton(inputId = "str_saving_throw",
    #                                label = "Strength", width = "30%"),
    #                   actionButton(inputId = "dex_saving_throw",
    #                                label = "Dexterity", width = "30%"),
    #                   actionButton(inputId = "con_saving_throw",
    #                                label = "Constitution", width = "30%"),
    #                   actionButton(inputId = "int_saving_throw",
    #                                label = "Intelligence", width = "30%"),
    #                   actionButton(inputId = "wis_saving_throw",
    #                                label = "Wisdom", width = "30%"),
    #                   actionButton(inputId = "cha_saving_throw",
    #                                label = "Charisma", width = "30%")
    #            ),
    #            
    #            column(4,
    #                   uiOutput("saving_throw_result"))
    #          )
    # ),
    # 
    # # skill chekcs----
    # tabPanel("Skill Checks",
    #          fluidRow(
    #            column(8,
    #                   actionButton(inputId = "acrobatics_skill_check",
    #                                label = "Acrobatics", width = "30%"),
    #                   actionButton(inputId = "animal_handling_skill_check",
    #                                label = "Animal Handling", width = "30%"),
    #                   actionButton(inputId = "arcana_skill_check",
    #                                label = "Arcana", width = "30%"),
    #                   actionButton(inputId = "athletics_skill_check",
    #                                label = "Athletics", width = "30%"),
    #                   actionButton(inputId = "deception_skill_check",
    #                                label = "Deception", width = "30%"),
    #                   actionButton(inputId = "history_skill_check",
    #                                label = "History", width = "30%"),
    #                   actionButton(inputId = "insight_skill_check",
    #                                label = "Insight", width = "30%"),
    #                   actionButton(inputId = "intimidation_skill_check",
    #                                label = "Intimidation", width = "30%"),
    #                   actionButton(inputId = "investigation_skill_check",
    #                                label = "Investigation", width = "30%"),
    #                   actionButton(inputId = "medicine_skill_check",
    #                                label = "Medicine", width = "30%"),
    #                   actionButton(inputId = "nature_skill_check",
    #                                label = "Nature", width = "30%"),
    #                   actionButton(inputId = "perception_skill_check",
    #                                label = "Perception", width = "30%"),
    #                   actionButton(inputId = "performance_skill_check",
    #                                label = "Performance", width = "30%"),
    #                   actionButton(inputId = "persuasion_skill_check",
    #                                label = "Persuasion", width = "30%"),
    #                   actionButton(inputId = "religion_skill_check",
    #                                label = "Religion", width = "30%"),
    #                   actionButton(inputId = "sleight_of_hand_skill_check",
    #                                label = "Sleight of Hand", width = "30%"),
    #                   actionButton(inputId = "stealth_skill_check",
    #                                label = "Stealth", width = "30%"),
    #                   actionButton(inputId = "survival_skill_check",
    #                                label = "Survival", width = "30%")
    #            ),
    #            
    #            column(4,
    #                   uiOutput("skill_check_result"))
    #          )
    # ),
    
    # all rolls----
    tabPanel("Saving Throws / Skill Checks",
             fluidRow(
               column(8,
                      actionButton(inputId = "str_saving_throw",
                                   label = "Strength", width = "30%"),
                      actionButton(inputId = "dex_saving_throw",
                                   label = "Dexterity", width = "30%"),
                      actionButton(inputId = "con_saving_throw",
                                   label = "Constitution", width = "30%"),
                      actionButton(inputId = "int_saving_throw",
                                   label = "Intelligence", width = "30%"),
                      actionButton(inputId = "wis_saving_throw",
                                   label = "Wisdom", width = "30%"),
                      actionButton(inputId = "cha_saving_throw",
                                   label = "Charisma", width = "30%"),
                      hr(),
                      actionButton(inputId = "acrobatics_skill_check",
                                   label = "Acrobatics", width = "30%"),
                      actionButton(inputId = "animal_handling_skill_check",
                                   label = "Animal Handling", width = "30%"),
                      actionButton(inputId = "arcana_skill_check",
                                   label = "Arcana", width = "30%"),
                      actionButton(inputId = "athletics_skill_check",
                                   label = "Athletics", width = "30%"),
                      actionButton(inputId = "deception_skill_check",
                                   label = "Deception", width = "30%"),
                      actionButton(inputId = "history_skill_check",
                                   label = "History", width = "30%"),
                      actionButton(inputId = "insight_skill_check",
                                   label = "Insight", width = "30%"),
                      actionButton(inputId = "intimidation_skill_check",
                                   label = "Intimidation", width = "30%"),
                      actionButton(inputId = "investigation_skill_check",
                                   label = "Investigation", width = "30%"),
                      actionButton(inputId = "medicine_skill_check",
                                   label = "Medicine", width = "30%"),
                      actionButton(inputId = "nature_skill_check",
                                   label = "Nature", width = "30%"),
                      actionButton(inputId = "perception_skill_check",
                                   label = "Perception", width = "30%"),
                      actionButton(inputId = "performance_skill_check",
                                   label = "Performance", width = "30%"),
                      actionButton(inputId = "persuasion_skill_check",
                                   label = "Persuasion", width = "30%"),
                      actionButton(inputId = "religion_skill_check",
                                   label = "Religion", width = "30%"),
                      actionButton(inputId = "sleight_of_hand_skill_check",
                                   label = "Sleight of Hand", width = "30%"),
                      actionButton(inputId = "stealth_skill_check",
                                   label = "Stealth", width = "30%"),
                      actionButton(inputId = "survival_skill_check",
                                   label = "Survival", width = "30%")
               ),
               
               column(4,
                      uiOutput("save_check_result"))
             )),
    # dice roll----
    tabPanel("Dice Roll",
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
             ))
  ))
