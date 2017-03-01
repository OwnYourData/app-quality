# UI to collect data
# last update: 2017-03-01

appSourceInput <- function(){
        tabPanel('Datenerfassung', br(),
                 fluidRow(
                         column(2,
                                img(src='write.png',
                                    width='70px',
                                    style='margin-left:40px;')),
                         column(10,
                                helpText('Erfasse hier einen neuen Eintrag im Qualitäts-Tracker.'),
                                textInput('inputTopicTimestamp',
                                          'Zeit:',
                                          value = as.character(Sys.time())),
                                selectInput('inputTopicSelect',
                                            label = 'Bereich',
                                            choices = c('keine'),
                                            selected = 'keine'),
                                selectInput('inputOptionsSelect',
                                            label = 'Auswahl',
                                            choices = c(' '),
                                            selected = ' '),
                                tags$label('Anmerkung:'),
                                br(),
                                tags$textarea(id='inputNotes',
                                              rows=2, cols=80,
                                              ''),
                                br(),br(),
                                actionButton('saveInputTopic', 'Speichern',
                                             icon('save')),
                                br(), br(), uiOutput('inputTopicStatus')
                         )
                 )
        )
}