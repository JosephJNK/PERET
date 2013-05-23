var libs;

libs = "/scripts/libs/";

head.js({
  jquery: libs + 'jquery-1.9.1.js'
}, {
  bootstrap: libs + 'bootstrap.js'
}, {
  jade: libs + 'jade.js'
}, {
  templates: '/scripts/templates.js'
}).ready(function() {
  return jQuery(function() {
    return head.js({
      app: '/scripts/app.js'
    });
  });
});
