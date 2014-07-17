{$} = require 'atom'
fs = require 'fs-plus'

module.exports =
class AtomSafeQuit
  constructor: ->
    @bindEvents()
    @resetStateObj()

  resetStateObj: ->
    @state = {}
    @state.panes = []
    @state.treeView = null
    @state.rootPath = null

  bindEvents: ->
    $(window).on 'beforeunload', (e) =>
      @saveWindowState()

    $(window).on 'ready', =>
      @restoreWindow()

  saveWindowState: ->
    @resetStateObj()
    @state.rootPath = atom.project.getPath()
    for pane in atom.workspace.getPanes()
      @savePaneState(pane)
    fs.writeFileSync(@filePath(@state.rootPath), JSON.stringify(@state))

  savePaneState: (pane) ->
    paneObj =
      items: []
      active: pane == atom.workspace.getActivePane()
    for item in pane.getItems()
      if item.constructor.name == 'Editor'
        obj = @prepareEditorObj(item, pane)
        paneObj.items.push(obj)
      else
        console.log("NOT SAVED:")
        console.log(item)
    @state.panes.push(paneObj)

  prepareEditorObj: (editor, pane) ->
    obj = {}
    obj.type = 'Editor'
    obj.path = editor.getPath()
    obj.active = editor.getPath() == pane.getActiveEditor().getPath()
    obj.saved = !editor.shouldPromptToSave()
    unless obj.saved
      obj.buffer = obj = {}.getText()
      obj = {}.buffer.reload()
    obj

  filePath: (projectPath) ->
    fileName = btoa(projectPath)
    "/Users/jipiboily/code/atom-safe-quit/tmp/#{fileName}.json"

  restoreWindow: ->
    @loadState()
    @scracthAll()

    index = 0
    for pane in @state.panes
      @restorePane(pane, index)
      index++

  scracthAll: ->
    # Clear current state, start from scracth!
    for pane in atom.workspace.getPanes()
      pane.destroy()

  loadState: ->
    windowStateFile = fs.readFileSync(@filePath(atom.project.getPath()))
    @state = JSON.parse(windowStateFile)

  restorePane: (paneData, index) ->
    console.log('opening pane #' + index)
    if index isnt 0
      atom.workspace.getActivePane().splitRight()
    for tab in paneData.items
      console.log('Should open:' + tab.path)
      atom.workspace.open(tab.path) if tab.type == 'Editor'
