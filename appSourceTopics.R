# UI for configuring topics
# last update: 2017-03-01

appSourceTopics <- function(){
        tabPanel('Bereiche konfigurieren',
                 br(),
                 helpText('Konfiguriere hier die Bereiche, deren Qualität du tracken möchtest.', style='display:inline'),
                 br(),br(),
                 fluidRow(
                         column(4,
                                selectInput('topicList',
                                            'Bereiche:',
                                            topicUiList,
                                            multiple=TRUE, 
                                            selectize=FALSE,
                                            size=12,
                                            selected = 'Temperatur'),
                                actionButton('delTopicList', 'Entfernen', 
                                             icon('trash')),
                                actionButton('importTopicList', 'Importieren',
                                             icon('download'))),
                         column(8,
                                textInput('topicItemName',
                                          'Name:',
                                          value = ''),
                                tags$label('Auswahlmöglicheiten (Einträge durch Strichpunkte trennen):'),
                                br(),
                                tags$textarea(id='topicItemOptions',
                                              rows=3, cols=80,
                                              ''),
                                br(),br(),
                                actionButton('addTopicItem', 
                                             'Hinzufügen', icon('plus')),
                                actionButton('updateTopicItem', 
                                             'Aktualisieren', icon('edit'))
                         )
                 )
        )
}