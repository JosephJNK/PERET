var displayProblemInput, displayProblemText, displayResults, displaySteps, loadProblem;

displayProblemText = function(text) {
  return $("#problem-display > .content").html(text);
};

displayProblemInput = function(inputArray) {
  return $("#problem-input > .content").html(tmpl.stringList({
    tests: inputArray
  }));
};

displayResults = function(resultArray) {
  return $("#results > .content").html(tmpl.stringList({
    tests: resultArray
  }));
};

displaySteps = function(steps) {
  var $step, $steps, i, num, step, title, _i, _len, _results;

  $steps = $("#steps > .content");
  $steps.html("");
  _results = [];
  for (i = _i = 0, _len = steps.length; _i < _len; i = ++_i) {
    step = steps[i];
    num = i;
    title = i === 0 ? 'Answer' : "Step " + i;
    $steps.append(tmpl.step({
      statement: step.statement,
      title: title
    }));
    $step = $steps.children().last();
    _results.push($step.find(".submit-button").on('click', {
      number: i
    }, function(event) {
      return console.log(event.data.number, "clicked");
    }));
  }
  return _results;
};

loadProblem = function(problemIndex) {
  var problem;

  problem = lib.stepifyProblem(problems[problemIndex]);
  displayProblemText(problem.steps[0].statement);
  displayProblemInput(problem.testValues);
  displaySteps(problem.steps);
  return displayResults(['a', 'b', 'cde']);
};

loadProblem(0);
