{Range}  = require('atom')
fuzzaldrin = require('fuzzaldrin')

module.exports =
class SnippetsProvider
  selector: '*'

  constructor: ->
    if atom.config.get('autocomplete-snippets.highInclusionPriority')
      @inclusionPriority = 9999

  getSuggestions: ({scopeDescriptor, prefix}) ->
    return unless prefix?.length
    scopeSnippets = atom.config.get('snippets', {scope: scopeDescriptor})
    @findSuggestionsForPrefix(scopeSnippets, prefix)

  findSuggestionsForPrefix: (snippets, prefix) ->
    return [] unless snippets?

    for __, snippet of snippets when snippet.prefix.lastIndexOf(prefix, 0) isnt -1
      iconHTML: '<i class="icon-move-right"></i>'
      type: 'snippet'
      text: snippet.prefix
      replacementPrefix: prefix
      rightLabel: snippet.name

  onDidInsertSuggestion: ({editor}) ->
    atom.commands.dispatch(atom.views.getView(editor), 'snippets:expand')
