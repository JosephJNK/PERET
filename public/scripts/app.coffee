displayProblemText = (text) -> $("#problem-display > .content").html text

displayProblemInput = (inputArray) ->
  $("#problem-input > .content").html tmpl.testValues testValues: inputArray

displayResults = (results) ->
  $("#results > .content").html tmpl.executionResults results
  if results.correct
    $("#results > .content pre").css { 'border-width': '2px', 'border-style': 'solid', 'border-color': 'green' }
  else
    $("#results > .content pre").css { 'border-width': '2px', 'border-style': 'solid', 'border-color': 'red' }

clearResults = ->
  $("#results > .content").html tmpl.executionResults {hits: [], misses: [], falseHits: []}
  $("#results > .content pre").css { 'border-width': '1px', 'border-style': 'solid', 'border-color': 'gray' }

displaySteps = (problem) ->
  $steps = $ "#steps > .content"
  $steps.html ""
  for step, i in problem.steps
    title = if i is 0 then 'Answer' else "Step #{i}"
    $steps.append tmpl.step { statement: step.statement, title: title, stepNumber: i }
    $step = $steps.children().last()
    $step.find('.submit-button').on 'click', {stepNumber: i}, (event) ->
      expression = $("#steps [stepnumber=#{event.data.stepNumber}]").val()
      console.log 'expression', expression
      analyzeSolution problem, event.data.stepNumber, expression

analyzeSolution = (problem, stepNumber, solutionAttempt) ->
  results = lib.checkSolution problem.testValues, solutionAttempt, problem.steps[stepNumber].solution
  console.log results
  displayResults results

loadProblem = (problemIndex) ->
  problem = lib.stepifyProblem problems[problemIndex]
  displayProblemText problem.steps[0].statement
  displayProblemInput problem.testValues
  displaySteps problem
  clearResults()

loadProblem 1
