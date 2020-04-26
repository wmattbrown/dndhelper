#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  # load character -----
  observeEvent(input$character_file, {
    my_character <<- readRDS(input$character_file$datapath)
  })
  
  # my_character <- reactive({readRDS(input$character_file$datapath)})
  
  # output$character_name <- reactive(renderText(my_character[["name"]]))
  # why doens't the following work? no matter what I load it has vernons info. I
  # don't understand how that's even possible. the above works but uses <<-
  # which is discouraged. Oh well.
  # my_character <- reactive(readRDS(input$character_file$datapath))
  
  # saving throws ----
  # roll dice
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
  
  # roll saving throw
  observeEvent(input$get_saving_throw,{
    saving_throw_history <<- c(saving_throw_history[2:length(saving_throw_history)],
                               sprintf("%s: %s", input$saving_throw_type,
                                       roll_saving_throw(input$saving_throw_type, 
                                                         input$saving_throw_roll)$message))
    
    saving_throw_message <- paste(saving_throw_history, 
                                  collapse = "<br/>")
    
    output$saving_throw_result <- renderUI(HTML(saving_throw_message))
  })
  
  # roll skill check
  observeEvent(input$get_skill_check,{
    skill_check_history <<- c(skill_check_history[2:length(skill_check_history)],
                              sprintf("%s: %s", input$skill_check_type,
                                      roll_skill_check(input$skill_check_type, 
                                                       input$skill_check_roll)$message))
    
    skill_check_message <- paste(skill_check_history,
                                 collapse = "<br/>")
    
    output$skill_check_result <- renderUI(HTML(skill_check_message))
  })
  
  # new_character----
  new_char_data <- reactive({
    new_char_prof_list <- data.frame(skill = c(names(ability_list), names(skill_list))) %>% 
      mutate(prof = skill %in% input$new_char_profs) %>% 
      as.list()
    new_char_profs <- new_char_prof_list$prof
    names(new_char_profs) <- new_char_prof_list$skill
    
    list("name" = input$new_char_name,
         "class" = input$new_char_class,
         "level" = input$new_char_level,
         "abilities" = c("STR" = input$new_char_str,
                         "DEX" = input$new_char_dex,
                         "CON" = input$new_char_con,
                         "INT" = input$new_char_int,
                         "WIS" = input$new_char_wis,
                         "CHA" = input$new_char_cha),
         "proficiency" = input$new_char_proficiency,
         "speed" = input$new_char_speed,
         "max HP" = input$new_char_hp,
         "proficiencies" = new_char_profs)
  })
  
  output$save_new_character <- downloadHandler(
    filename = function() {
      paste0(input$new_char_name, ".RDS")
    },
    content = function(file) {
      saveRDS(new_char_data(), file)
    }
  )
  
  # STATS SUMMARY PAGE----
  # display basic stats - will eventually be on a back page for reference only
  # using for testing of functions
  output$stat_table <- renderTable(
    data.frame(stat = ability_list) %>%
      mutate(value = as.integer(my_character[["abilities"]]),
             ability_modifier = get_ability_modifier(value),
             saving_throw_modifier = sapply(stat, get_saving_throw_modifier))
  )
  
  output$skill_table <- renderTable(
    data.frame(skill = names(skill_abilities)) %>%
      mutate(modifier = get_skill_modifier(skill))
  )
  
  output$proficiency_table <- renderTable(
    data.frame(Proficiencies = names(my_character[["proficiencies"]]),
               proficient = my_character[["proficiencies"]]) %>%
      filter(proficient) %>%
      select(Proficiencies)
  )
})
