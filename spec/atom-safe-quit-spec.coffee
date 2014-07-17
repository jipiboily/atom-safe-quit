# {WorkspaceView} = require 'atom'
# AtomSafeQuit = require '../lib/atom-safe-quit'

# # Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
# #
# # To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# # or `fdescribe`). Remove the `f` to unfocus the block.

# describe "AtomSafeQuit", ->
#   activationPromise = null

#   beforeEach ->
#     atom.workspaceView = new WorkspaceView
#     activationPromise = atom.packages.activatePackage('atom-safe-quit')

#   describe "when the atom-safe-quit:toggle event is triggered", ->
#     it "attaches and then detaches the view", ->
#       expect(atom.workspaceView.find('.atom-safe-quit')).not.toExist()

#       # This is an activation event, triggering it will cause the package to be
#       # activated.
#       atom.workspaceView.trigger 'atom-safe-quit:toggle'

#       waitsForPromise ->
#         activationPromise

#       runs ->
#         expect(atom.workspaceView.find('.atom-safe-quit')).toExist()
#         atom.workspaceView.trigger 'atom-safe-quit:toggle'
#         expect(atom.workspaceView.find('.atom-safe-quit')).not.toExist()
