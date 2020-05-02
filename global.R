# global
library(dplyr)



# TO DO----
# have the character page also put in weapons and attack abilities
#     base damage (i.e 1d8, 3d6, whatever)
#     ability modifier, CHA, DEX, STR, whatever
#     to hit (if weapon, the ability modifier, DEX or STR, if spell, then spell attack modifier)
#         character sheet needs a 'spell attack modifier stat" thing, where you choose WIS, INT, or CHA (can it be STR or DEX?)
#             spell attack modifier can then be calculated on the fly, so you don't need to change the attack modifier, just the base stats
#             
#   allow unlimited number of attacks to be added. only requirements is that the names are unique. i.e. there can be only one calld "dagger" or "short sword". but you can make "short sword2".

options(stringsAsFactors = FALSE)

set.seed(Sys.time())

source("functions.R")


# ability list----
ability_list <- c("Strength" = "STR", 
                  "Dexterity" = "DEX", 
                  "Constitution" = "CON", 
                  "Intelligence" = "INT", 
                  "Wisdom" = "WIS", 
                  "Charisma" = "CHA")
# names(ability_list) = ability_list

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
history_length <- 6
# need to set initial values... because I'm a hack - in server now
saving_throw_history <- rep("", history_length)
skill_check_history <- rep("", history_length)

save_check_history <- rep("", history_length)

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
