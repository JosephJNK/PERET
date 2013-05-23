var templates;

window.tmpl = templates = {};

templates.add = function(name, code) {
  return templates[name] = jade.compile(code, {
    pretty: true,
    filename: name
  });
};

templates.add("stringList", 'pre.pre-scrollable \n  - each test in tests\n    | #{test} \n    | ');

templates.add("step", '.step\n  .title Step #{number}\n  .description #{statement}\n  .input\n    input(type="text", placeholder="Try your best.")\n    a.submit-button.btn Enter');
