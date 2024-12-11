surveys <- read.csv('data/portal_data_joined.csv')
surveys

surveys_base <- surveys[c('species_id', 'weight', 'plot_type')]
surveys_base

colnames(surveys)
rownames(surveys)

surveys_base <- surveys[1:5000, c('species_id', 'weight', 'plot_type')]
surveys_base

str(surveys_base)
class('plot_type')
class('species_id')

surveys_base <- surveys_base[complete.cases(surveys_base), ] # gets rid of NAs!!s
surveys_base

as.numeric('species_id')
levels('species_id')
levels(surveys_base$"species_id")

surveys_base$species_id <- factor(surveys_base$species_id) # takes character ids and converts to factor
surveys_base$species_id   

is.factor('species_id') # so why is this species id not a factor???
is.factor(surveys_base$species_id) # so 'species_id' is NOT a factor but surveys_base$species_id IS a factor

surveys_base$plot_type <- factor(surveys_base$plot_type)

is.factor(surveys_base$plot_type)


nlevels('species_id')
levels('species_id')
typeof('species_id') # character 
typeof(surveys_base$species_id) # integer





species_id <- factor(c('species_id'))
species_id


surveys_base$species_id <- as.factor(surveys_base$species_id)
surveys_base$species_id

surveys_base$plot_type <- as.factor(surveys_base$plot_type)
surveys_base$plot_type

weight <- (!is.na('weight'))
weight
