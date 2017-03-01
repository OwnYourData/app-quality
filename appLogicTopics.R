# configure quality topics
# last update: 2017-03-01

# get stored topics
readTopicItems <- function(){
        app <- currApp()
        topicItems <- data.frame()
        if(length(app) > 0){
                url <- itemsUrl(app[['url']], 
                                paste0(app[['app_key']],
                                       '.topics'))
                topicItems <- readItems(app, url)
                if(nrow(topicItems) > 0){
                        rownames(topicItems) <- topicItems$topic
                        topicItems <- topicItems[, c('options', 'id'), drop=FALSE]
                }
        }
        topicItems
        
}

topicList <- function(){
        allItems <- readTopicItems()
        if(nrow(allItems) > 0){
                updateSelectInput(session, 'topicSelect',
                                  choices = rownames(allItems))
                updateSelectInput(
                        session,
                        'inputTopicSelect',
                        choices = rownames(allItems),
                        selected = rownames(allItems)[1])
                opts <- lapply(strsplit(allItems$options, ';'), trimws)[[1]]
                updateSelectInput(
                        session,
                        'inputOptionsSelect',
                        choices = opts,
                        selected = opts[1])
        } else {
                updateSelectInput(
                        session,
                        'inputTopicSelect',
                        choices = c('keine Bereiche konfiguriert'),
                        selected = 'keine Bereiche konfiguriert')
                updateSelectInput(
                        session,
                        'inputOptionsSelect',
                        choices = ' ',
                        selected = ' ')
        }
}

# show attributes on selecting an item
observeEvent(input$topicList, {
        selItem <- input$topicList
        if(length(selItem)>1){
                selItem <- selItem[1]
                updateSelectInput(session, 'topicList', selected = selItem)
        }
        allItems <- readTopicItems()
        selItemName <- selItem
        selItemOptions <- allItems[rownames(allItems) == selItem, 'options']
        updateTextInput(session, 'topicItemName',
                        value = selItemName)
        updateTextInput(session, 'topicItemOptions',
                        value = trim(as.character(selItemOptions)))
})

observeEvent(input$addTopicItem, {
        errMsg <- ''
        itemName <- input$topicItemName
        itemOptions <- input$topicItemOptions
        
        allItems <- readTopicItems()
        if(itemName %in% rownames(allItems)){
                errMsg <- 'Name bereits vergeben'
        }
        if(errMsg == ''){
                app <- currApp()
                url <- itemsUrl(app[['url']], 
                                paste0(app[['app_key']],
                                       '.topics'))
                data <- list(
                        topic   = itemName,
                        options = itemOptions,
                        '_oydRepoName' = 'Bereiche'
                )
                writeItem(app, url, data)
                initNames <- rownames(allItems)
                updateSelectInput(session, 'topicList',
                                  choices = c(initNames, itemName),
                                  selected = NA)
                updateTextInput(session, 'topicItemName',
                                value = '')
                updateTextInput(session, 'topicItemOptions',
                                value = '')
        }
        closeAlert(session, 'myTopicItemStatus')
        if(errMsg != ''){
                createAlert(session, 'taskInfo', 
                            'myTopicItemStatus',
                            title = 'Achtung',
                            content = errMsg,
                            style = 'warning',
                            append = 'false')
        }
        topicList()
})

observeEvent(input$updateTopicItem, {
        errMsg   <- ''
        selItem  <- input$topicList
        itemName <- input$topicItemName
        itemOptions  <- input$topicItemOptions
        if(is.null(selItem)){
                errMsg <- 'Kein Bereich ausgewählt.'
        }
        if(errMsg == ''){
                allItems <- readTopicItems()
                app <- currApp()
                id <- allItems[rownames(allItems) == selItem, 'id']
                url <- itemsUrl(app[['url']], 
                                paste0(app[['app_key']],
                                       '.topics'))
                data <- list(
                        topic   = itemName,
                        options = itemOptions
                )
                updateItem(app, url, data, id)
                newRowNames <- rownames(allItems)
                newRowNames[newRowNames == selItem] <- itemName
                updateSelectInput(session, 'topicList',
                                  choices = newRowNames,
                                  selected = NA)
                updateTextInput(session, 'topicItemName',
                                value = '')
                updateTextInput(session, 'topicItemOptions',
                                value = '')
        }
        closeAlert(session, 'myTopicItemStatus')
        if(errMsg != ''){
                createAlert(session, 'taskInfo', 
                            'myTopicItemStatus',
                            title = 'Achtung',
                            content = errMsg,
                            style = 'warning',
                            append = 'false')
        }
        topicList()
})

observeEvent(input$delTopicList, {
        errMsg  <- ''
        selItem <- input$topicList
        if(is.null(selItem)){
                errMsg <- 'Kein Bereich ausgewählt.'
        }
        if(errMsg == ''){
                allItems <- readTopicItems()
                newRowNames <- rownames(allItems)
                app <- currApp()
                url <- itemsUrl(app[['url']], 
                                paste0(app[['app_key']],
                                       '.topics'))
                id <- allItems[rownames(allItems) == selItem, 'id']
                deleteItem(app, url, id)
                newRowNames <- newRowNames[newRowNames != selItem]
                allItems <- allItems[rownames(allItems) != selItem, ]
                updateSelectInput(session, 'topicList',
                                  choices = newRowNames,
                                  selected = NA)
                updateTextInput(session, 'topicItemName',
                                value = '')
                updateTextInput(session, 'topicItemOptions',
                                value = '')
        }
        closeAlert(session, 'myTopicItemStatus')
        if(errMsg != ''){
                createAlert(session, 'taskInfo', 
                            'myTopicItemStatus',
                            title = 'Achtung',
                            content = errMsg,
                            style = 'warning',
                            append = 'false')
        }
        topicList()
})

observeEvent(input$inputTopicSelect, {
        allItems <- readTopicItems()
        selItem <- input$inputTopicSelect
        if(nrow(allItems) > 0){
                if(selItem %in% rownames(allItems)){
                        opts <- lapply(strsplit(
                                        allItems[rownames(allItems) == selItem,
                                                 'options'], ';'), 
                                       trimws)[[1]]
                } else {
                        opts <- lapply(strsplit(allItems$options, ';'), 
                                       trimws)[[1]]
                }
                updateSelectInput(
                        session,
                        'inputOptionsSelect',
                        choices = opts,
                        selected = opts[1])
        } else {
                updateSelectInput(
                        session,
                        'inputTopicSelect',
                        choices = c('keine Bereiche konfiguriert'),
                        selected = 'keine Bereiche konfiguriert')
                updateSelectInput(
                        session,
                        'inputOptionsSelect',
                        choices = ' ',
                        selected = ' ')
        }
})

observeEvent(input$saveInputTopic, {
        inputMsg = ''
        inputTimestampTry = try(as.POSIXct(input$inputTopicTimestamp))
        if(is.POSIXct(inputTimestampTry)){
                app <- currApp()
                url <- itemsUrl(app[['url']], app[['app_key']])
                data <- list(
                        timestamp = inputTimestampTry,
                        topic     = input$inputTopicSelect,
                        event     = input$inputOptionsSelect,
                        note      = input$inputNotes,
                        '_oydRepoName' = 'Liste'
                )
                writeItem(app, url, data)
                updateTextInput(
                        session,
                        'inputTopicTimestamp',
                        value = as.character(Sys.time()))
                inputMsg = 'ein neuer Eintrag wurde im Qualitätstracker gespeichert'
        } else {
                inputMsg = 'Fehler: ungültiges Datum/Zeit Format, die Eingabe wurde nicht gespeichert'
        }
        output$inputTopicStatus <- renderUI(inputMsg)
})