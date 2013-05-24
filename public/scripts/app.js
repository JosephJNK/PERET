var displayProblemInput, displayProblemText, displayResults, displaySteps, error, expression, test, works, _ref;

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

displaySteps = function(stepProblemStatements) {
  var $step, $steps, i, num, statement, _i, _len, _results;

  $steps = $("#steps > .content");
  $steps.html("");
  _results = [];
  for (i = _i = 0, _len = stepProblemStatements.length; _i < _len; i = ++_i) {
    statement = stepProblemStatements[i];
    num = i + 1;
    $steps.append(tmpl.step({
      statement: statement,
      number: num
    }));
    $step = $steps.children().last();
    _results.push($step.find(".submit-button").on('click', {
      statement: statement,
      number: num
    }, function(event) {
      return console.log(event.data.number, "clicked");
    }));
  }
  return _results;
};

test = function() {
  displayProblemText("A pair of character literals separated by a hyphen within square braces match the range of characters beginning with the first literal and ending with the second");
  displaySteps(['First', 'Second', 'Third']);
  displayProblemInput(["a", "aa", "cat", "bagel", "A", "b", "cot", "CAT"]);
  return displayResults(['a', 'b', 'cde']);
};

test();

console.log('compiling regex...');

_ref = lib.extPosixToJs('a|bc'), error = _ref[0], expression = _ref[1];

console.log('expression:' + expression);

works = (expression.test('asdf')) && (expression.test('bcd')) && !expression.test('foo');

if (works) {
  console.log('regex compilition works');
} else {
  console.log('regex compilation failed v.v');
}

console.log('first problem: ', problems[0]);
