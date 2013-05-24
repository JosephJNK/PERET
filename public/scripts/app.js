var analyzeSolution, displayProblemInput, displayProblemText, displayResults, displaySteps, loadProblem;

displayProblemText = function(text) {
  return $("#problem-display > .content").html(text);
};

displayProblemInput = function(inputArray) {
  return $("#problem-input > .content").html(tmpl.testValues({
    testValues: inputArray
  }));
};

displayResults = function(results) {
  return $("#results > .content").html(tmpl.executionResults(results));
};

displaySteps = function(problem) {
  var $step, $steps, i, num, step, title, _i, _len, _ref, _results;

  $steps = $("#steps > .content");
  $steps.html("");
  _ref = problem.steps;
  _results = [];
  for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
    step = _ref[i];
    num = i;
    title = i === 0 ? 'Answer' : "Step " + i;
    $steps.append(tmpl.step({
      statement: step.statement,
      title: title
    }));
    $step = $steps.children().last();
    _results.push($step.find('.submit-button').on('click', {
      number: i
    }, function(event) {
      var expression;

      expression = $step.find('input').val();
      return analyzeSolution(problem, event.data.number, expression);
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
  return displayResults({
    hits: [],
    misses: [],
    falseHits: []
  });
};

loadProblem(0);
