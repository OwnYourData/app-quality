# global constants available to the app
# last update:2016-01-17

# constants required for every app
appName <- 'quality'
appTitle <- 'Qualitäts-Tracker'
app_id <- 'eu.ownyourdata.quality'
helpUrl <- 'https://www.ownyourdata.eu/apps/qualitaets-tracker/'
mobileUrl <- 'https://quality-mobil.datentresor.org'

# definition of data structure
currRepoSelect <- ''
appRepos <- list(Liste = 'eu.ownyourdata.quality',
                 Bereiche = 'eu.ownyourdata.quality.topics',
                 Verlauf = 'eu.ownyourdata.quality.log')
appStruct <- list(
        Liste = list(
                fields      = c('timestamp', 'topic', 'event', 'note'),
                fieldKey    = 'timestamp',
                fieldTypes  = c('timestamp', 'string', 'string', 'string'),
                fieldInits  = c('empty', 'empty', 'empty', 'empty'),
                fieldTitles = c('Zeit', 'Bereich', 'Ereignis', 'Anmerkung'),
                fieldWidths = c(150, 200, 200, 250)),
        Bereiche = list(
                fields      = c('topic', 'options'),
                fieldKey    = 'topic',
                fieldTypes  = c('string', 'string'),
                fieldInits  = c('empty', 'empty'),
                fieldTitles = c('Bereich', 'Auswahl'),
                fieldWidths = c(200, 400)),
        Verlauf = list(
                fields      = c('date', 'description'),
                fieldKey    = 'date',
                fieldTypes  = c('date', 'string'),
                fieldInits  = c('empty', 'empty'),
                fieldTitles = c('Datum', 'Text'),
                fieldWidths = c(150, 450)))

# Version information
currVersion <- "0.3.0"
verHistory <- data.frame(rbind(
        c(version = "0.3.0",
          text    = "erstes Release")
))

# app specific constants
topicUiList <- vector()
