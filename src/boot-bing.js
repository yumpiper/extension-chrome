console.log('google');
$.get(
  chrome.extension.getURL("src/bing.coffee"),
  "text"
)
.done(function(source){
  eval(CoffeeScript.compile(source, {bare: false}));
});