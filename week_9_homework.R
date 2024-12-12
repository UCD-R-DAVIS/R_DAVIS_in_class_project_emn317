surveys <- read.csv("data/portal_data_joined.csv")

?nchar

newtaxon <- surveys[surveys$taxa == i,]

longestnames <- newtaxon[nchar(newtaxon$species) == max(nchar(newtaxon$species)),]

?paste0

for(i in unique(surveys$taxa)){
  newtaxon
  longestnames
  print(paste0("The longest species name(s) among ", i, "s is/are: "))
  print(unique(longestnames$species))
}

#all same results ^

for(i in unique(surveys$taxa)){
  taxon_names <- surveys[surveys$taxa == i, ]
  longest_names <- taxon_names[nchar(taxon_names$species)==
                                 max(nchar(taxon_names$species)),] %>% 
    select(species)
  print(paste0("Longest species name(s) for the taxon ", i, " is/are: "))
  print(unique(longest_names$species))
}

mycols <- mloa %>% select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")

mycols %>% map(max, na.rm = T)

C_to_F <- function(x){
  x * 1.8 + 32
}

mloa$temp_F_2m <- C_to_F(mloa$temp_C_2m)
mloa$temp_F_10m <- C_to_F(mloa$temp_C_10m)
mloa$temp_F_towertop <- C_to_F(mloa$temp_C_towertop)
