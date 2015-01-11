function getRating(ingredients)
{
  return $.getJSON('http://127.0.0.1:5000/?ingredients='+ingredients.join(',').toLowerCase());
}

$.get(
  chrome.extension.getURL("src/extension.coffee"),
  "text"
)
.done(function(source){
  eval(CoffeeScript.compile(source, {bare: false}));
});