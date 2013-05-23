displayProblemText = (text) -> $("#problem-display > .content").html text

displayProblemInput = (inputArray) ->
  $("#problem-input > .content").html tmpl.stringList tests: inputArray

displayResults = (resultArray) ->
  $("#results > .content").html tmpl.stringList tests: resultArray

displaySteps = (stepProblemStatements) ->
  $steps = $ "#steps > .content"
  $steps.html ""
  for statement, i in stepProblemStatements
    num = i+1
    $steps.append tmpl.step { statement: statement, number: num }
    $step = $steps.children().last()
    $step.find(".submit-button").on 'click', {statement: statement, number:num}, (event) ->
      console.log event.data.number, "clicked"

test = ->
  displayProblemText "A pair of character literals separated by a hyphen within square braces match the range of characters beginning with the first literal and ending with the second"
  displaySteps(['First', 'Second', 'Third'])
  displayProblemInput [ "a", "aa", "cat", "bagel", "A", "b", "cot", "CAT" ]
  displayResults ['a', 'b', 'cde']

test()
