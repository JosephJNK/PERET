displayProblemText = (text) -> $("#problem-display > .content").html text

displayProblemInput = (inputArray) ->
  $("#problem-input > .content").html tmpl.stringList tests: inputArray

displayResults = (resultArray) ->
  $("#results > .content").html tmpl.stringList tests: resultArray

displaySteps = (problem) ->
  $steps = $ "#steps > .content"
  $steps.html ""
  for step, i in problem.steps
    num = i
    title = if i is 0 then 'Answer' else "Step #{i}"
    $steps.append tmpl.step { statement: step.statement, title: title }
    $step = $steps.children().last()
    $step.find('.submit-button').on 'click', { number: i }, (event) ->
      expression = $step.find('input').val()
      analyzeSolution problem, event.data.number, expression

analyzeSolution = (problem, stepNumber, solutionAttempt) ->
  results = lib.checkSolution problem.testValues, solutionAttempt, problem.steps[stepNumber].solution
  console.log results

loadProblem = (problemIndex) ->
  problem = lib.stepifyProblem problems[problemIndex]
  displayProblemText problem.steps[0].statement
  displayProblemInput problem.testValues
  displaySteps problem

loadProblem 0
