window.tmpl = templates = {}

templates.add = (name, code) ->
  templates[name] = jade.compile code, {
    pretty: true
    filename: name
  }

templates.add "testValues",
  '''
  pre.pre-scrollable
    each value in testValues
      |#{value}
      br
  '''

templates.add "executionResults",
  '''
  pre.pre-scrollable
    each value in falseHits
      font(color='red') #{value}
      br
    each value in misses
      font(color='gray') #{value}
      br
    each value in hits
      font(color='black') #{value}
      br
  '''

templates.add "step",
  '''
  .step
    .title #{title}
    .description #{statement}
    .input
      input(type="text", placeholder="Enter an expression")
      a.submit-button.btn Execute
  '''
