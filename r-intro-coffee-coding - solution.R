# solution to self guided coding in the YOUR TURN section
starwars <- starwars %>%
  select(!c(birth_year,sex,homeworld)) %>%
  filter(gender == "masculine" &
         species %in% c("Human","Droid","Gungan","Wookiee","Zabrak")) %>% 
  rename(hair_colour = hair_color,
         skin_colour = skin_color,
         eye_colour = eye_color)