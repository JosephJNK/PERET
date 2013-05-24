var templates;

window.tmpl = templates = {};

templates.add = function(name, code) {
  return templates[name] = jade.compile(code, {
    pretty: true,
    filename: name
  });
};

templates.add("testValues", 'pre.pre-scrollable\n  each value in testValues\n    |#{value}\n    br');

templates.add("executionResults", 'pre.pre-scrollable\n  each value in falseHits\n    font(color=\'red\') #{value}\n    br\n  each value in misses\n    font(color=\'gray\') #{value}\n    br\n  each value in hits\n    font(color=\'black\') #{value}\n    br');

templates.add("step", '.step\n  .title #{title}\n  .description #{statement}\n  .input\n    input(type="text", placeholder="Enter an expression")\n    a.submit-button.btn Execute');
