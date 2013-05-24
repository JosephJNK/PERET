displayProblemText = (text) -> $("#problem-display > .content").html text

displayProblemInput = (inputArray) ->
  $("#problem-input > .content").html tmpl.stringList tests: inputArray

displayResults = (resultArray) ->
  $("#results > .content").html tmpl.stringList tests: resultArray

displaySteps = (steps) ->
  $steps = $ "#steps > .content"
  $steps.html ""
  for step, i in steps
    num = i
    title = if i is 0 then 'Answer' else "Step #{i}"
    $steps.append tmpl.step { statement: step.statement, title: title }
    $step = $steps.children().last()
    $step.find(".submit-button").on 'click', { number: i }, (event) ->
      console.log event.data.number, "clicked"

loadProblem = (problemIndex) ->
  problem = lib.stepifyProblem problems[problemIndex]
  displayProblemText problem.steps[0].statement
  displayProblemInput problem.testValues
  displaySteps problem.steps

  displayResults ['a', 'b', 'cde']

loadProblem 0
