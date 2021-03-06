var analyzeSolution, clearResults, displayProblemInput, displayProblemText, displayResults, displaySteps, loadProblem;

displayProblemText = function(text) {
  return $("#problem-display > .content").html(text);
};

displayProblemInput = function(inputArray) {
  return $("#problem-input > .content").html(tmpl.testValues({
    testValues: inputArray
  }));
};

displayResults = function(results) {
  $("#results > .content").html(tmpl.executionResults(results));
  if (results.correct) {
    return $("#results > .content pre").css({
      'border-width': '2px',
      'border-style': 'solid',
      'border-color': 'green'
    });
  } else {
    return $("#results > .content pre").css({
      'border-width': '2px',
      'border-style': 'solid',
      'border-color': 'red'
    });
  }
};

clearResults = function() {
  $("#results > .content").html(tmpl.executionResults({
    hits: [],
    misses: [],
    falseHits: []
  }));
  return $("#results > .content pre").css({
    'border-width': '1px',
    'border-style': 'solid',
    'border-color': 'gray'
  });
};

displaySteps = function(problem) {
  var $step, $steps, i, step, title, _i, _len, _ref, _results;

  $steps = $("#steps > .content");
  $steps.html("");
  _ref = problem.steps;
  _results = [];
  for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
    step = _ref[i];
    title = i === 0 ? 'Answer' : "Step " + i;
    $steps.append(tmpl.step({
      statement: step.statement,
      title: title,
      stepNumber: i
    }));
    $step = $steps.children().last();
    _results.push($step.find('.submit-button').on('click', {
      stepNumber: i
    }, function(event) {
      var expression;

      expression = $("#steps [stepnumber=" + event.data.stepNumber + "]").val();
      console.log('expression', expression);
      return analyzeSolution(problem, event.data.stepNumber, expression);
    }));
  }
  return _results;
};

analyzeSolution = function(problem, stepNumber, solutionAttempt) {
  var results;

  results = lib.checkSolution(problem.testValues, solutionAttempt, problem.steps[stepNumber].solution);
  console.log(results);
  return displayResults(results);
};

loadProblem = function(problemIndex) {
  var problem;

  problem = lib.stepifyProblem(problems[problemIndex]);
  displayProblemText(problem.steps[0].statement);
  displayProblemInput(problem.testValues);
  displaySteps(problem);
  return clearResults();
};

loadProblem(1);
