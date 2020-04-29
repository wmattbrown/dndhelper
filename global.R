# global
library(dplyr)

options(stringsAsFactors = FALSE)

set.seed(Sys.time())

source("functions.R")


# ability list----
ability_list <- c("STR", "DEX", "CON", "INT", "WIS", "CHA")
names(ability_list) = ability_list

# skill list----
skill_list <- c("acrobatics",
                "animal handling",
                "arcana",
                "athletics",
                "deception",
                "history",
                "insight",
                "intimidation",
                "investigation",
                "medicine",
                "nature",
                "perception",
                "performance",
                "persuasion",
                "religion",
                "sleight of hand",
                "stealth",
                "survival")
names(skill_list) <- skill_list


# skill abilities----
skill_abilities <- c("acrobatics" = "DEX",
                     "animal handling" = "WIS",
                     "arcana" = "INT",
                     "athletics" = "STR",
                     "deception" = "CHA",
                     "history" = "INT",
                     "insight" = "WIS",
                     "intimidation" = "CHA",
                     "investigation" = "INT",
                     "medicine" = "WIS",
                     "nature" = "INT",
                     "perception" = "WIS",
                     "performance" = "CHA",
                     "persuasion" = "CHA",
                     "religion" = "INT",
                     "sleight of hand" = "DEX",
                     "stealth" = "DEX",
                     "survival" = "WIS")


# roll history settings ----
history_length <- 5
# need to set initial values... because I'm a hack - in server now
saving_throw_history <- rep("", history_length)
skill_check_history <- rep("", history_length)
dice_roll_history <- rep("", history_length)



# FOR TESTING -----
# load a sample character to start and allow quicker testing of functionality
# my_character <- list(
#   "name" = "Test Character",
#   # currently multiclassing is not supported
#   "class" = "Wizard",
#   "level" = 1,
#   "abilities" = c("STR" = 10,
#                   "DEX" = 11,
#                   "CON" = 12,
#                   "INT" = 13,
#                   "WIS" = 14,
#                   "CHA" = 15),
#   "proficiency" = 2,
#   "speed" = 30,
#   "max HP" = 19,
#   "proficiencies" = c("STR" = FALSE,
#                       "DEX" = FALSE,
#                       "CON" = FALSE,
#                       "INT" = FALSE,
#                       "WIS" = TRUE,
#                       "CHA" = TRUE,
#                       "acrobatics" = FALSE,
#                       "animal handling" = FALSE,
#                       "arcana" = FALSE,
#                       "athletics" = FALSE,
#                       "deception" = TRUE,
#                       "history" = FALSE,
#                       "insight" = FALSE,
#                       "intimidation" = TRUE,
#                       "investigation" = TRUE,
#                       "medicine" = FALSE,
#                       "nature" = FALSE,
#                       "perception" = FALSE,
#                       "performance" = FALSE,
#                       "persuasion" = TRUE,
#                       "religion" = FALSE,
#                       "sleight of hand" = TRUE,
#                       "stealth" = FALSE,
#                       "survival" = FALSE)
# )
