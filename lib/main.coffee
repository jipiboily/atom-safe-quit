AtomSafeQuit = require './atom-safe-quit'

module.exports =
  activate: (state) ->
    @atomSafeQuit = new AtomSafeQuit()

  deactivate: ->
    @atomSafeQuit?.destroy()
    @atomSafeQuit = null
