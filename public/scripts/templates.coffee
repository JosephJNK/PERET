window.tmpl = templates = {}

templates.add = (name, code) ->
  templates[name] = jade.compile code, {
    pretty: true
    filename: name
  }

templates.add "stringList",
  '''
  pre.pre-scrollable 
    - each test in tests
      | #{test} 
      | 
  '''

templates.add "step",
  '''
  .step
    .title #{title}
    .description #{statement}
    .input
      input(type="text", placeholder="Try your best.")
      a.submit-button.btn Enter
  '''
