console.log('google');
$.get(
  chrome.extension.getURL("src/google.coffee"),
  "text"
)
.done(function(source){
  eval(CoffeeScript.compile(source, {bare: false}));
});