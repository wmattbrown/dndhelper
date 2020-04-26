# functions!

# roll <number> <sided> dice
# e.g. roll 3 8 sided dice: roll(8, 3)
# e.g. roll 1 20 sided die: roll(20)
roll <- function(sided = 20, number = 1){
  stopifnot(is.numeric(number))
  stopifnot(number == round(number))
  stopifnot(sided %in% c(4, 6, 8, 10, 12, 20, 100))
  stopifnot(number > 0)
  
  # roll the dice
  sample(1:sided, number, replace = TRUE)
}

# given a stat like strength or charisma, get the associated modifier
get_ability_modifier <- function(stat){
  stopifnot(is.numeric(stat))
  stopifnot(stat >= 1)
  stopifnot(stat <= 20)
  stopifnot(stat == round(stat))
  as.integer(floor((stat - 10) / 2))
}

get_skill_modifier <- function(skill){
  my_ability_stat <- my_character[["abilities"]][skill_abilities[skill]]
  my_proficiency <- my_character[["proficiencies"]][skill] * my_character[["proficiency"]] 
  
  as.integer(get_ability_modifier(my_ability_stat) + my_proficiency)
}

# this is NOT vectorized (can't use it in mutate as is, need to use sapply)
get_saving_throw_modifier <- function(ability){
  stopifnot(ability %in% ability_list)
  
  my_ability_modifier <- get_ability_modifier(my_character[["abilities"]][[ability]])
  
  my_proficiency <- my_character[["proficiency"]] * my_character[["proficiencies"]][[ability]]
  
  as.integer(my_ability_modifier + my_proficiency)
} 

roll_saving_throw <- function(ability, roll_value = NA){
  stopifnot(ability %in% ability_list)
  
  # a roll can be provided, or the app can roll for you
  if(is.na(roll_value)) roll_value <- roll(20)
  
  my_saving_throw_modifier <- get_saving_throw_modifier(ability)
  
  
  value <- roll_value + my_saving_throw_modifier
  
  message <- sprintf("%d + %d = <b>%d</b>",
                     roll_value, 
                     my_saving_throw_modifier,
                     value)
  
  list(message = message,
       value = value)
}


roll_skill_check <- function(skill, roll_value = NA){
  stopifnot(skill %in% names(skill_abilities))
  stopifnot(roll_value <= 20 | is.na(roll_value))
  stopifnot(roll_value >=1 | is.na(roll_value))
  
  # a roll can be provided, or the app can roll for you
  if(is.na(roll_value)) roll_value <- roll(20)
  
  skill_modifier <- get_skill_modifier(skill)
  
  message <- sprintf("%s + %s = <b>%s</b>", roll_value, skill_modifier, roll_value + skill_modifier) 
  value <- as.integer(roll_value + skill_modifier)
  
  list(message = message,
       value = value)
}


