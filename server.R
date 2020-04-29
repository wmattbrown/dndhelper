
library(shiny)
# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # HELPER FUNCTIONS----
  saving_throw_helper <- function(stat){
    saving_throw_history2 <<- c(saving_throw_history2[2:history_length],
                                sprintf("%s: %s",
                                        stat,
                                        roll_save_check(input[[sprintf("character_%s", tolower(stat))]],
                                                        input$character_proficiency * (stat %in% input$character_profs))$message))
    
    saving_throw_message2 <- paste(saving_throw_history2, 
                                   collapse = "<br/>")
    
    output$saving_throw_result2 <- renderUI(HTML(saving_throw_message2))
  }
  
  skill_check_helper <- function(skill){
    nice_skill <- skill %>% 
      gsub("_skill_check", "", .) %>% 
      gsub("_", " ", .) %>% 
      tools::toTitleCase()
    
    stat <- skill_abilities[tolower(nice_skill)]
    
    skill_check_history2 <<- c(skill_check_history2[2:history_length],
                               sprintf("%s: %s", 
                                       nice_skill,
                                       roll_save_check(
                                         input[[sprintf("character_%s", tolower(stat))]],
                                         input$character_proficiency * (stat %in% input$character_profs))$message))
    
    skill_check_message2 <- paste(skill_check_history2, 
                                  collapse = "<br/>")
    
    output$skill_check_result2 <- renderUI(HTML(skill_check_message2))
  }
  
  
  # load character file -----  
  my_character <- eventReactive(input$load_character_file, {
    readRDS(input$load_character_file$datapath)
  })
  
  # UPDATE CHARACTER STATS --------
  observeEvent(input$use_loaded_character,{
    # show the name of currently loaded character
    output$current_character_name <- renderText(my_character()[["name"]])
    # set character name in character tab
    updateTextInput(session, "character_name", 
                    value = my_character()[["name"]])
    # ABILITIES
    updateNumericInput(session, "character_str", 
                       value = my_character()[["abilities"]][["STR"]])
    updateNumericInput(session, "character_dex", 
                       value = my_character()[["abilities"]][["DEX"]])
    updateNumericInput(session, "character_con", 
                       value = my_character()[["abilities"]][["CON"]])
    updateNumericInput(session, "character_int", 
                       value = my_character()[["abilities"]][["INT"]])
    updateNumericInput(session, "character_wis", 
                       value = my_character()[["abilities"]][["WIS"]])
    updateNumericInput(session, "character_cha", 
                       value = my_character()[["abilities"]][["CHA"]])
    # PROFICIENCIES
    updateCheckboxGroupInput(session, "character_profs",
                             selected = names(my_character()[["proficiencies"]])[my_character()[["proficiencies"]]])
    # CLASS, LEVEL, HP, PROFICIENCY, SPEED, etc
    updateNumericInput(session, "character_hp", 
                       value = my_character()[["max HP"]])
    updateNumericInput(session, "character_speed", 
                       value = my_character()[["speed"]])
    updateNumericInput(session, "character_proficiency", 
                       value = my_character()[["proficiency"]])
    updateNumericInput(session, "character_level", 
                       value = my_character()[["level"]])
    updateTextInput(session, "character_class", 
                    value = my_character()[["class"]])
    
  })
    
    
    # edit/save character -----
    # _ character stats----
    character_data <- reactive({
      character_prof_list <- data.frame(skill = c(names(ability_list), names(skill_list))) %>% 
        mutate(prof = skill %in% input$character_profs) %>% 
        as.list()
      character_profs <- character_prof_list$prof
      names(character_profs) <- character_prof_list$skill
      
      list("name" = input$character_name,
           "class" = input$character_class,
           "level" = input$character_level,
           "abilities" = c("STR" = input$character_str,
                           "DEX" = input$character_dex,
                           "CON" = input$character_con,
                           "INT" = input$character_int,
                           "WIS" = input$character_wis,
                           "CHA" = input$character_cha),
           "proficiency" = input$character_proficiency,
           "speed" = input$character_speed,
           "max HP" = input$character_hp,
           "proficiencies" = character_profs)
    })
    # _ save character----
    output$save_character <- downloadHandler(
      filename = function() {
        paste0(input$character_name, ".RDS")
      },
      content = function(file) {
        saveRDS(character_data(), file)
      }
    )
    
    
    # ROLLS ----
    # _ SPECIFIC SAVING THROWS----
    # ___ STR----
    observeEvent(input$str_saving_throw, {
      saving_throw_helper("STR")
    })
    # ___ DEX----
    observeEvent(input$dex_saving_throw, {
      saving_throw_helper("DEX")
    })
    # ___ CON----
    observeEvent(input$con_saving_throw, {
      saving_throw_helper("CON")
    })
    # ___ INT----
    observeEvent(input$int_saving_throw, {
      saving_throw_helper("INT")
    })
    # ___ WIS----
    observeEvent(input$wis_saving_throw, {
      saving_throw_helper("WIS")
    })
    # ___ CHA----
    observeEvent(input$cha_saving_throw, {
      saving_throw_helper("CHA")
    })
    
    # _ SPECIFIC SKILL CHECKS----
    # ___acrobatics----
    observeEvent(input$acrobatics_skill_check, {
      skill_check_helper("acrobatics")
    })
    # ___animal handling----
    observeEvent(input$animal_handling_skill_check, {
      skill_check_helper("animal_handling")
    })
    # ___arcana----
    observeEvent(input$arcana_skill_check, {
      skill_check_helper("arcana")
    })
    # ___athletics----
    observeEvent(input$athletics_skill_check, {
      skill_check_helper("athletics")
    })
    # ___deception----
    observeEvent(input$deception_skill_check, {
      skill_check_helper("deception")
    })
    # ___history----
    observeEvent(input$history_skill_check, {
      skill_check_helper("history")
    })
    # ___insight----
    observeEvent(input$insight_skill_check, {
      skill_check_helper("insight")
    })
    # ___intimidation----
    observeEvent(input$intimidation_skill_check, {
      skill_check_helper("intimidation")
    })
    # ___investigation----
    observeEvent(input$investigation_skill_check, {
      skill_check_helper("investigation")
    })
    # ___medicine----
    observeEvent(input$medicine_skill_check, {
      skill_check_helper("medicine")
    })
    # ___nature----
    observeEvent(input$nature_skill_check, {
      skill_check_helper("nature")
    })
    # ___perception----
    observeEvent(input$perception_skill_check, {
      skill_check_helper("perception")
    })
    # ___performance----
    observeEvent(input$performance_skill_check, {
      skill_check_helper("performance")
    })
    # ___persuasian----
    observeEvent(input$persuasion_skill_check, {
      skill_check_helper("persuasion")
    })
    # ___religion----
    observeEvent(input$religion_skill_check, {
      skill_check_helper("religion")
    })
    # ___sleight of hand----
    observeEvent(input$sleight_of_hand_skill_check, {
      skill_check_helper("sleight_of_hand")
    })
    # ___stealth----
    observeEvent(input$stealth_skill_check, {
      skill_check_helper("stealth")
    })
    # ___survival----
    observeEvent(input$survival_skill_check, {
      skill_check_helper("survival")
    })
    
    
    # _ roll dice ----
    observeEvent(input$roll_dice, {
      # I've removed the dice roll modifier, seems kind of silly. 
      # i might remove the roller altogether once the specific roll things are setup
      # show all dice rolls + num_dice * modifier = result
      roll <- roll(input$die_type, input$number_of_dice)
      
      if (input$number_of_dice == 1) {
        # one dice, no modifier
        # if(input$dice_modifier == 0){
        res <- as.character(roll)
        # one die + modifier
        # } else{
        #   res <- sprintf("%d + %d = %d", roll, input$dice_modifier, roll + input$dice_modifier)
        # }
      } else {
        # multi dice, no modifier
        # if(input$dice_modifier == 0){
        res <- sprintf("%s = %d", paste(roll, collapse = " + "), sum(roll))
        #   # multi dice + modifier
        # } else {
        # res <- sprintf("(%s) + (%d x %d) = %d", 
        #                paste(roll, collapse = " + "),
        #                input$number_of_dice, input$dice_modifier,
        #                sum(roll) + input$number_of_dice * input$dice_modifier)
        # }      
      }
      output$dice_roll_result <- renderUI(HTML(res))
    })
    
})
  